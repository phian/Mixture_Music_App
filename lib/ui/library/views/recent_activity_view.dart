import 'package:flutter/material.dart';
import 'package:mixture_music_app/constants/app_constants.dart';
import 'package:mixture_music_app/constants/app_text_style.dart';
import 'package:mixture_music_app/ui/settings_screen/widgets/playlist_card.dart';
import 'package:mixture_music_app/ui/settings_screen/widgets/recent_song_button.dart';

class RecentActivityView extends StatefulWidget {
  const RecentActivityView({Key? key}) : super(key: key);

  @override
  _RecentActivityViewState createState() => _RecentActivityViewState();
}

class _RecentActivityViewState extends State<RecentActivityView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RecentSongButton(
          onTap: () {},
          title: 'Recent song',
          titleStyle: AppTextStyles.lightTextTheme.caption?.copyWith(
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
        ...List.generate(
          personalSuggestPlaylists.length,
          (index) => PlaylistCard(
            onTap: () {},
            playlist: personalSuggestPlaylists[index],
          ),
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }
}
