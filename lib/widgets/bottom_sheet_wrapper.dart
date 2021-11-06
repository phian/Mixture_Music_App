import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';

class BottomSheetWrapper extends StatefulWidget {
  const BottomSheetWrapper({
    Key? key,
    required this.contentItems,
    required this.title,
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
  }) : super(key: key);

  final List<Widget> contentItems;
  final Widget title;
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

  @override
  _BottomSheetWrapperState createState() => _BottomSheetWrapperState();
}

class _BottomSheetWrapperState extends State<BottomSheetWrapper> {
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: widget.title,
                alignment: widget.titleAlign,
                padding: widget.titlePadding,
              ),
              Container(
                height: widget.dividerThickness ?? 1.0,
                color: widget.dividerColor ?? AppColors.hintColor,
                margin: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              Padding(
                padding: widget.itemContentPadding ?? EdgeInsets.zero,
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
      ),
    );
  }
}
