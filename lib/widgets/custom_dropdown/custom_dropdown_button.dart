import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mixture_music_app/widgets/custom_dropdown/config/dropdown_style.dart';
import 'package:mixture_music_app/widgets/custom_dropdown/widgets/dropdown_item.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDropdown<T> extends StatefulWidget {
  /// The place holder child widget for the button, this will be appeared if there aren't any
  final Widget placeHolderChild;

  /// onChange is called when the selected option is changed.
  /// It will pass back the value and the index of the option.
  final void Function(T?, int?)? onChanged;

  /// list of DropdownItems
  final List<DropdownItem<T>> items;
  final DropdownStyle dropdownStyle;

  /// dropdownButtonStyles passes styles to OutlineButton.styleFrom()
  final DropdownButtonStyle dropdownButtonStyle;

  /// dropdown button icon defaults to caret
  final Icon? icon;
  final bool hideIcon;

  /// If true the dropdown icon will as a leading icon, default to false
  final bool leadingIcon;

  /// If true the widget will automatically validate the selected data.
  ///
  /// If the data is null the error will be showed.
  final bool validateSelectedData;

  /// The custom error message to display when validate the selected data.
  ///
  /// It only appear when the [validateSelectedData] is set to true.
  final String? errorMessage;

  /// The [TextStyle] of the [errorMessage]
  final TextStyle? errorStyle;

  const CustomDropdown({
    Key? key,
    this.hideIcon = false,
    required this.placeHolderChild,
    required this.items,
    this.dropdownStyle = const DropdownStyle(),
    this.dropdownButtonStyle = const DropdownButtonStyle(),
    this.icon,
    this.leadingIcon = false,
    this.onChanged,
    this.validateSelectedData = false,
    this.errorMessage,
    this.errorStyle,
  }) : super(key: key);

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  late OverlayEntry _overlayEntry;
  bool _isOpen = false;
  int _currentIndex = -1;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;
  late DropdownButtonStyle style = widget.dropdownButtonStyle;
  late bool _isDataValid;
  MapEntry<int, DropdownItem<T>>? _selectedValue;
  bool _isFirstOpened = false;

  @override
  void initState() {
    super.initState();
    _isDataValid = true;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CustomDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    style = widget.dropdownButtonStyle;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // link the overlay to the button
    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: style.buttonWidth,
            height: style.buttonHeight,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: style.padding,
                backgroundColor: style.buttonBackgroundColor,
                elevation: style.buttonElevation,
                primary: style.buttonPrimaryColor,
                shape: style.buttonShape,
                side: style.side,
                shadowColor: style.shadowColor,
                animationDuration: style.animationDuration,
                textStyle: style.buttonTextStyle,
                fixedSize: style.fixedSize,
                maximumSize: style.maximumSize,
                minimumSize: style.minimumSize,
              ),
              onPressed: _toggleDropdown,
              child: Row(
                textDirection: widget.leadingIcon ? TextDirection.rtl : TextDirection.ltr,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_currentIndex == -1) ...[
                    Expanded(child: widget.placeHolderChild),
                  ] else ...[
                    Expanded(child: widget.items[_currentIndex]),
                  ],
                  if (!widget.hideIcon)
                    RotationTransition(
                      turns: _rotateAnimation,
                      child: widget.icon ?? const Icon(Icons.arrow_drop_down),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Visibility(
            visible: _isDataValid == false && widget.validateSelectedData,
            child: Text(
              widget.errorMessage ?? '* Please select a value!',
              style: widget.errorStyle ??
                  const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.red,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    // find the size and position of the current widget
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    var size = renderBox?.size ?? Size.zero;

    var offset = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
    var topOffset = offset.dy + size.height + 5.0;

    return OverlayEntry(
      // Full screen GestureDetector to register when a
      // User has clicked away from the dropdown
      builder: (context) => GestureDetector(
        onTap: () {
          _toggleDropdown(close: true);

          if (_selectedValue != null) {
            widget.onChanged?.call(_selectedValue!.value.value, _selectedValue!.key);
          }
        },
        behavior: HitTestBehavior.translucent,
        // full screen container to register taps anywhere and close drop down
        child: Stack(
          children: [
            Positioned(
              left: offset.dx,
              top: topOffset,
              width: widget.dropdownStyle.dropdownWidth ?? size.width,
              child: CompositedTransformFollower(
                offset: () {
                  if (widget.dropdownStyle.offset != null) {
                    return widget.dropdownStyle.offset!;
                  } else {
                    if (_isFirstOpened == false) {
                      return Offset(
                        0,
                        size.height + 5,
                      );
                    } else {
                      if (_selectedValue == null) {
                        return Offset(
                          0,
                          size.height - _getFontSizeHeight() + 5,
                        );
                      } else {
                        return Offset(
                          0,
                          size.height + 5,
                        );
                      }
                    }
                  }
                }(),
                link: _layerLink,
                showWhenUnlinked: false,
                child: Material(
                  elevation: widget.dropdownStyle.elevation ?? 0,
                  borderRadius: widget.dropdownStyle.borderRadius ?? BorderRadius.zero,
                  color: widget.dropdownStyle.dropdownColor ?? Colors.white,
                  child: SizeTransition(
                    axisAlignment: 1,
                    sizeFactor: _expandAnimation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      constraints: widget.dropdownStyle.constraints,
                      height: widget.dropdownStyle.dropdownHeight,
                      child: ListView(
                        padding: widget.dropdownStyle.padding ?? EdgeInsets.zero,
                        shrinkWrap: true,
                        children: widget.items.asMap().entries.map((item) {
                          return InkWellWrapper(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                            onTap: () {
                              setState(() => _currentIndex = item.key);
                              widget.onChanged?.call(item.value.value, item.key);
                              _toggleDropdown();

                              setState(() {
                                _selectedValue = item;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: item.value,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getFontSizeHeight() {
    if (widget.validateSelectedData) {
      if (widget.errorStyle != null) {
        if (widget.errorStyle!.fontSize != null) {
          print(widget.errorStyle!.fontSize!);
          return widget.errorStyle!.fontSize!;
        } else {
          return 14.0; // Default text font size
        }
      } else {
        return 14.0;
      }
    } else {
      return 0.0;
    }
  }

  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      await _animationController.reverse();
      _overlayEntry.remove();
      setState(() {
        _isOpen = false;
      });

      if (close && _selectedValue == null) {
        if (_isFirstOpened == false) {
          setState(() {
            _isFirstOpened = true;
          });
        }

        setState(() {
          _isDataValid = false;
        });
      }
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)?.insert(_overlayEntry);
      setState(() => _isOpen = true);
      _animationController.forward();

      setState(() {
        _isDataValid = true;
      });
    }
  }
}
