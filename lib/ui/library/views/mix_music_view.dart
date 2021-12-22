import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/images/app_images.dart';
import 'package:mixture_music_app/models/playlist/playlist.dart';
import 'package:mixture_music_app/routing/routes.dart';
import 'package:mixture_music_app/ui/settings_screen/widgets/playlist_detail_card.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({Key? key, required this.playlists}) : super(key: key);
  final List<Playlist> playlists;

  @override
  _PlaylistViewState createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  @override
  Widget build(BuildContext context) {
    return widget.playlists.isEmpty
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                Image.asset(
                  AppImages.playlist,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.3,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16.0),
                Text(
                  "You don't have any playlist",
                  style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          )
        : Column(
            children: [
              ...List.generate(
                widget.playlists.length,
                (index) => PlaylistCard(
                  playListName: widget.playlists[index].title,
                  songs: widget.playlists[index].songs,
                  totalTracks: widget.playlists[index].songs.length,
                  index: index,
                  onTap: () {
                    Get.toNamed(AppRoutes.playlistDetailScreen, arguments: widget.playlists[index]);
                  },
                ),
              )
            ],
          );
  }
}
