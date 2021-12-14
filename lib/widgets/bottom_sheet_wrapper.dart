import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';

class BottomSheetWrapper extends StatefulWidget {
  const BottomSheetWrapper({
    Key? key,
    required this.contentItems,
    this.title,
    this.onItemTap,
    this.backgroundColor,
    this.bottomSheetRadius,
    this.bottomSheetHeight,
    this.bottomSheetWidth,
    this.dividerColor,
    this.dividerThickness,
    this.titlePadding,
    this.itemContentPadding,
    this.itemsPadding,
    this.titleAlign,
    this.itemsListBackgroundColor,
    this.titleBackgroundColor,
  }) : super(key: key);

  final List<Widget> contentItems;
  final Widget? title;
  final void Function(int index)? onItemTap;
  final Color? backgroundColor;
  final BorderRadius? bottomSheetRadius;
  final double? bottomSheetHeight;
  final double? bottomSheetWidth;
  final Color? dividerColor;
  final double? dividerThickness;
  final EdgeInsetsGeometry? titlePadding;
  final EdgeInsetsGeometry? itemContentPadding;
  final EdgeInsetsGeometry? itemsPadding;
  final Alignment? titleAlign;
  final Color? titleBackgroundColor;
  final Color? itemsListBackgroundColor;

  @override
  _BottomSheetWrapperState createState() => _BottomSheetWrapperState();
}

class _BottomSheetWrapperState extends State<BottomSheetWrapper> {
  final GlobalKey _titleKey = GlobalKey();
  RenderBox? _box;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _box = _titleKey.currentContext?.findRenderObject() as RenderBox?;
      print(_box?.size.height ?? 0.0);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.bottomSheetRadius ??
          const BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Theme.of(context).backgroundColor,
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: widget.title != null ? EdgeInsets.only(top: (_box?.size.height ?? 0.0) + 24.0) : EdgeInsets.zero,
              child: Column(
                children: [
                  Container(
                    padding: widget.itemContentPadding ?? EdgeInsets.zero,
                    color: widget.itemsListBackgroundColor,
                    child: Column(
                      children: [
                        ...List.generate(
                          widget.contentItems.length,
                          (index) => InkWellWrapper(
                            onTap: widget.onItemTap != null
                                ? () {
                                    widget.onItemTap?.call(index);
                                  }
                                : null,
                            color: AppColors.transparent,
                            child: Padding(
                              child: widget.contentItems[index],
                              padding: widget.itemContentPadding ?? EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: widget.titleBackgroundColor ?? Colors.white,
              key: _titleKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: widget.title,
                    alignment: widget.titleAlign,
                    padding: widget.titlePadding,
                  ),
                  Container(
                    height: widget.dividerThickness ?? 1.0,
                    color: widget.dividerColor ?? AppColors.hintColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
