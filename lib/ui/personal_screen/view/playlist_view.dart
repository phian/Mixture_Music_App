import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/constants/app_text_style.dart';
import 'package:mixture_music_app/models/playlist_model.dart';
import 'package:mixture_music_app/ui/personal_screen/widgets/playlist_card.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({
    Key? key,
    required this.suggestedPlaylist,
  }) : super(key: key);

  final List<PlaylistModel> suggestedPlaylist;

  @override
  _PlaylistViewState createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Suggested playlist',
            style: AppTextStyles.lightTextTheme.headline5?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        ...List.generate(
          widget.suggestedPlaylist.length,
          (index) => PlaylistCard(
            playlist: widget.suggestedPlaylist[index],
            onTap: () {},
            hasFavourite: true,
            onFavouriteTap: () {},
          ),
        ),
      ],
    );
  }
}
