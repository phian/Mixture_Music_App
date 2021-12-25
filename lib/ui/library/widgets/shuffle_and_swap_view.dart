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
    this.visibleSwapViewIcon = true,
  }) : super(key: key);

  final void Function()? onShuffleTap;
  final void Function(ViewType viewType)? onSwapViewTap;
  final bool visibleSwapViewIcon;

  @override
  State<ShuffleAndSwapView> createState() => _ShuffleAndSwapViewState();
}

class _ShuffleAndSwapViewState extends State<ShuffleAndSwapView>
    with SingleTickerProviderStateMixin {
  bool _isList = true;
  late AnimationController _aniController;

  @override
  void initState() {
    super.initState();
    _aniController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _aniController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWellWrapper(
          onTap: widget.onShuffleTap,
          color: AppColors.transparent,
          child: Container(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                const Icon(
                  Icons.shuffle,
                ),
                const SizedBox(width: 4.0),
                Text(
                  'Shuffle',
                  style: theme.textTheme.bodyText1!.copyWith(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: widget.visibleSwapViewIcon,
          child: InkWellWrapper(
            borderRadius: BorderRadius.circular(90.0),
            onTap: widget.onSwapViewTap != null
                ? () {
                    setState(() {
                      _isList = !_isList;
                      if (_isList) {
                        _aniController.reverse();
                        widget.onSwapViewTap?.call(ViewType.list);
                      } else {
                        _aniController.forward();
                        widget.onSwapViewTap?.call(ViewType.grid);
                      }
                    });
                  }
                : null,
            child: Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              padding: const EdgeInsets.all(12.0),
              child: AnimatedIcon(
                icon: AnimatedIcons.view_list,
                progress: _aniController,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
