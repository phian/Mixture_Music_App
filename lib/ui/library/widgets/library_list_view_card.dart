import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/models/library_model.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';
import 'package:mixture_music_app/widgets/loading_container.dart';
import 'package:mixture_music_app/widgets/rounded_inkwell_wrapper.dart';

class LibraryListViewCard extends StatefulWidget {
  const LibraryListViewCard({
    Key? key,
    required this.libraryModel,
    this.onTap,
    this.cardColor,
    this.loadingColor,
    this.borderRadius,
    this.titleStyle,
    this.subtitleStyle,
    this.isPlaying = false,
    this.cardBorder,
  }) : super(key: key);

  final LibraryModel libraryModel;
  final void Function(bool isPlaying)? onTap;
  final Color? cardColor;
  final Color? loadingColor;
  final BorderRadius? borderRadius;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final bool isPlaying;
  final BoxBorder? cardBorder;

  @override
  State<LibraryListViewCard> createState() => _LibraryListViewCardState();
}

class _LibraryListViewCardState extends State<LibraryListViewCard> with SingleTickerProviderStateMixin {
  late final bool _isLiked = widget.libraryModel.isFavourite ?? false;
  int likeCount = 0;
  late bool _isPlaying = widget.isPlaying;
  late final AnimationController _aniController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

  @override
  void dispose() {
    _aniController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LibraryListViewCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _isPlaying = widget.isPlaying;
    });

    if (_isPlaying == false) {
      _aniController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWellWrapper(
      onTap: widget.onTap != null
          ? () {
              setState(() {
                if (_isPlaying) {
                  _aniController.reverse();
                } else {
                  _aniController.forward();
                }

                _isPlaying = !_isPlaying;
                widget.onTap?.call(_isPlaying);
              });
            }
          : null,
      color: widget.cardColor ?? AppColors.black12,
      borderRadius: widget.borderRadius,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(border: widget.cardBorder),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                widget.libraryModel.imageUrl ?? '',
                width: 50.0,
                height: 50.0,
                loadingBuilder: (context, child, chunkEvent) {
                  if (chunkEvent == null) {
                    return child;
                  }
                  return LoadingContainer(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    width: 50.0,
                    height: 50.0,
                    borderRadius: BorderRadius.circular(20.0),
                    loadingColor: widget.loadingColor,
                  );
                },
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.libraryModel.libraryTitle != null
                      ? Text(
                          widget.libraryModel.libraryTitle!,
                          style: widget.titleStyle ??
                              Theme.of(context).textTheme.caption?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                        )
                      : LoadingContainer(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 20.0,
                          borderRadius: BorderRadius.circular(20.0),
                          loadingColor: widget.loadingColor,
                        ),
                  const SizedBox(height: 8.0),
                  widget.libraryModel.librarySubTitle != null
                      ? Text(
                          widget.libraryModel.librarySubTitle!,
                          style: widget.subtitleStyle ??
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.c7A7C81,
                                    fontSize: 14.0,
                                  ),
                        )
                      : LoadingContainer(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: 12.0,
                          borderRadius: BorderRadius.circular(20.0),
                          loadingColor: widget.loadingColor,
                        ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            RoundedInkWellWrapper(
              onTap: () {
                setState(() {
                  if (_isPlaying) {
                    _aniController.reverse();
                  } else {
                    _aniController.forward();
                  }

                  _isPlaying = !_isPlaying;
                  widget.onTap?.call(_isPlaying);
                });
              },
              child: Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                padding: const EdgeInsets.all(8.0),
                child: AnimatedIcon(icon: AnimatedIcons.play_pause, progress: _aniController),
              ),
            ),
            const SizedBox(width: 8.0),
            widget.libraryModel.isFavourite != null
                ? LikeButton(
                    size: 30.0,
                    isLiked: _isLiked,
                    onTap: _onLikeButtonTapped,
                    animationDuration: const Duration(milliseconds: 500),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.favorite,
                        color: isLiked ? AppColors.cEF01A0 : AppColors.white,
                        size: 25.0,
                      );
                    },
                  )
                : LoadingContainer(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    width: 30.0,
                    height: 30.0,
                    borderRadius: BorderRadius.circular(20.0),
                    loadingColor: widget.loadingColor,
                  ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onLikeButtonTapped(bool isLiked) async {
    return !isLiked;
  }
}
