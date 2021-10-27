import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/constants/app_text_style.dart';
import 'package:mixture_music_app/models/library_model.dart';
import 'package:mixture_music_app/ui/library/widgets/loading_container.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';

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
  }) : super(key: key);

  final LibraryModel libraryModel;
  final void Function()? onTap;
  final Color? cardColor;
  final Color? loadingColor;
  final BorderRadius? borderRadius;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  @override
  State<LibraryListViewCard> createState() => _LibraryListViewCardState();
}

class _LibraryListViewCardState extends State<LibraryListViewCard> {
  late bool _isLiked = widget.libraryModel.isFavourite ?? false;
  int likeCount = 0;

  @override
  Widget build(BuildContext context) {
    return InkWellWrapper(
      onTap: widget.onTap,
      color: widget.cardColor ?? AppColors.black12,
      borderRadius: widget.borderRadius,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            widget.libraryModel.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.network(
                      widget.libraryModel.imageUrl!,
                      width: 120.0,
                      height: 120.0,
                    ),
                  )
                : LoadingContainer(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    width: 100.0,
                    height: 100.0,
                    borderRadius: BorderRadius.circular(20.0),
                    loadingColor: widget.loadingColor,
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
                              AppTextStyles.lightTextTheme.caption!.copyWith(
                                fontWeight: FontWeight.bold,
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
                              AppTextStyles.lightTextTheme.subtitle1!.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColors.c7A7C81,
                              ),
                        )
                      : LoadingContainer(
                          baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.2,
                    height: 12.0,
                    borderRadius: BorderRadius.circular(20.0),
                    loadingColor: widget.loadingColor,
                  ),
                ],
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
                  size: 30.0,
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
