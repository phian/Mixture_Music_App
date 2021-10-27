import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_text_style.dart';
import 'package:mixture_music_app/models/library_model.dart';
import 'package:mixture_music_app/ui/library/widgets/loading_container.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';

class LibraryGridViewCard extends StatelessWidget {
  const LibraryGridViewCard({
    Key? key,
    required this.libraryModel,
    this.titleStyle,
    this.onTap,
    this.imageRadius,
  }) : super(key: key);

  final LibraryModel libraryModel;
  final TextStyle? titleStyle;
  final void Function()? onTap;
  final BorderRadius? imageRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          child: libraryModel.imageUrl != null
              ? InkWellWrapper(
                  color: Colors.transparent,
                  borderRadius: imageRadius,
                  onTap: onTap,
                  child: ClipRRect(
                    borderRadius: imageRadius,
                    child: Ink.image(
                      image: NetworkImage(libraryModel.imageUrl!),
                      height: MediaQuery.of(context).size.width * 0.4,
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                  ),
                )
              : LoadingContainer(
                  height: MediaQuery.of(context).size.width * 0.4,
                  width: MediaQuery.of(context).size.width * 0.4,
                  borderRadius: BorderRadius.circular(30.0),
                ),
        ),
        const SizedBox(height: 16.0),
        Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.25),
          child: Text(
            libraryModel.libraryTitle ?? "Library's title",
            style: titleStyle ??
                AppTextStyles.lightTextTheme.caption!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        )
      ],
    );
  }
}
