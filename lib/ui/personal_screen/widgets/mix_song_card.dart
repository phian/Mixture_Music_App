import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/constants/app_text_style.dart';
import 'package:mixture_music_app/ui/personal_screen/widgets/stacked_images_list.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';

class MixSongCard extends StatelessWidget {
  const MixSongCard({
    Key? key,
    required this.titleImageUrl,
    required this.songImages,
    required this.cardTitle,
    required this.songAmount,
    required this.onShuffleTap,
    this.cardBackgroundColor,
    this.shuffleButtonBackgroundColor,
    this.titleStyle,
    this.subTitleStyle,
    this.cardRadius,
  }) : super(key: key);

  final String titleImageUrl;
  final List<String> songImages;
  final String cardTitle;
  final int songAmount;
  final void Function() onShuffleTap;
  final Color? cardBackgroundColor;
  final Color? shuffleButtonBackgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final BorderRadius? cardRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: cardRadius ?? BorderRadius.circular(8.0),
        color: cardBackgroundColor ?? AppColors.coolBlue.withOpacity(0.7),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipOval(
                    child: Stack(
                      children: [
                        Image.network(titleImageUrl, width: 60.0, height: 60.0),
                      ],
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(40.0, 40.0),
                    child: InkWellWrapper(
                      color: shuffleButtonBackgroundColor ?? AppColors.white,
                      onTap: onShuffleTap,
                      borderRadius: BorderRadius.circular(90.0),
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        child: const Icon(Icons.shuffle, size: 12.0),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      cardTitle,
                      style: titleStyle ??
                          AppTextStyles.lightTextTheme.caption?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '$songAmount ${songAmount > 1 ? 'songs' : 'song'}',
                      style: AppTextStyles.lightTextTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.w300,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16.0),
          StackedImages(songImages: songImages),
        ],
      ),
    );
  }
}
