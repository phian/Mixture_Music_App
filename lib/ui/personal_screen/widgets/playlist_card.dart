import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/constants/app_text_style.dart';
import 'package:mixture_music_app/models/playlist_model.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';
import 'package:mixture_music_app/widgets/loading_container.dart';

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({
    Key? key,
    required this.playlist,
    this.onTap,
    this.imageWidth,
    this.imageHeight,
    this.contentPadding,
    this.cardRadius,
    this.hasFavourite = false,
    this.favouriteIcon,
    this.onFavouriteTap,
    this.favouriteIconColor,
    this.favouriteIconSize,
    this.imageRadius,
  }) : super(key: key);

  final PlaylistModel playlist;
  final void Function()? onTap;
  final double? imageWidth;
  final double? imageHeight;
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadius? cardRadius;
  final bool hasFavourite;
  final Widget? favouriteIcon;
  final void Function()? onFavouriteTap;
  final Color? favouriteIconColor;
  final double? favouriteIconSize;
  final BorderRadius? imageRadius;

  @override
  Widget build(BuildContext context) {
    return InkWellWrapper(
      color: AppColors.transparent,
      onTap: onTap,
      borderRadius: cardRadius ?? BorderRadius.zero,
      child: Container(
        padding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
        child: Row(
          children: [
            playlist.imageUrl != null
                ? ClipRRect(
                    borderRadius: imageRadius ?? BorderRadius.circular(8.0),
                    child: Image.network(
                      playlist.imageUrl!,
                      width: 70.0,
                      height: 70.0,
                    ),
                  )
                : LoadingContainer(
                    width: 70.0,
                    height: 70.0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  playlist.playlistName != null
                      ? Text(
                          playlist.playlistName!,
                          style: AppTextStyles.lightTextTheme.caption?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : Text(
                          'Playlist',
                          style: AppTextStyles.lightTextTheme.caption?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                  playlist.owner != null
                      ? Text(
                          playlist.owner!,
                          style: AppTextStyles.lightTextTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                          ),
                        )
                      : Text(
                          'Owner',
                          style: AppTextStyles.lightTextTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.subTextColor,
                            fontSize: 16.0,
                          ),
                        ),
                ],
              ),
            ),
            Visibility(
              visible: hasFavourite,
              child: favouriteIcon ??
                  IconButton(
                    onPressed: onFavouriteTap,
                    icon: Icon(
                      Icons.favorite_border_outlined,
                      color: favouriteIconColor,
                      size: favouriteIconSize,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
