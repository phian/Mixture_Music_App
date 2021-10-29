import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_text_style.dart';
import '../../../constants/enums/enums.dart';
import '../../../widgets/inkwell_wrapper.dart';

class ShuffleAndSwapView extends StatefulWidget {
  const ShuffleAndSwapView({
    Key? key,
    this.onShuffleTap,
    this.onSwapViewTap,
  }) : super(key: key);

  final void Function()? onShuffleTap;
  final void Function(ViewType viewType)? onSwapViewTap;

  @override
  State<ShuffleAndSwapView> createState() => _ShuffleAndSwapViewState();
}

class _ShuffleAndSwapViewState extends State<ShuffleAndSwapView> with SingleTickerProviderStateMixin {
  bool _isList = true;
  AnimationController? _aniController;

  @override
  void initState() {
    super.initState();
    _aniController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWellWrapper(
          onTap: widget.onShuffleTap,
          color: AppColors.transparent,
          child: Container(
            padding: EdgeInsets.all(4.0),
            child: Row(
              children: [
                const Icon(
                  Icons.shuffle,
                ),
                const SizedBox(width: 4.0),
                Text(
                  "Shuffle",
                  style: AppTextStyles.lightTextTheme.subtitle1?.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: widget.onSwapViewTap != null
              ? () {
                  setState(() {
                    _isList = !_isList;
                    if (_isList) {
                      _aniController!.reverse();
                      widget.onSwapViewTap?.call(ViewType.list);
                    } else {
                      _aniController!.forward();
                      widget.onSwapViewTap?.call(ViewType.grid);
                    }
                  });
                }
              : null,
          icon: AnimatedIcon(
            icon: AnimatedIcons.view_list,
            progress: _aniController!,
          ),
        ),
      ],
    );
  }
}
