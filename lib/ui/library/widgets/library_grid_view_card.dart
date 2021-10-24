import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_text_style.dart';
import 'package:mixture_music_app/models/library_model.dart';
import 'package:mixture_music_app/ui/library/widgets/loading_container.dart';

class LibraryGridViewCard extends StatelessWidget {
  LibraryGridViewCard({
    Key? key,
    required this.libraryModel,
    this.titleStyle,
  }) : super(key: key);

  final LibraryModel libraryModel;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          child: libraryModel.imageUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.network(
                    libraryModel.imageUrl!,
                    height: MediaQuery.of(context).size.width * 0.4,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                )
              : LoadingContainer(
                  height: MediaQuery.of(context).size.width * 0.4,
                  width: MediaQuery.of(context).size.width * 0.4,
                  borderRadius: BorderRadius.circular(30.0),
                ),
        ),
        SizedBox(height: 16.0),
        Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.25),
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
