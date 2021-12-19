import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/constants/app_constants.dart';
import 'package:mixture_music_app/controllers/playlist_controller.dart';
import 'package:mixture_music_app/controllers/user_data_controller.dart';
import 'package:mixture_music_app/models/song/song_model.dart';
import 'package:mixture_music_app/widgets/loading_container.dart';
import '../create_playlist_screen.dart';

class AddToPlaylistSheet extends StatelessWidget {
  AddToPlaylistSheet({Key? key, required this.song}) : super(key: key);

  final _dataController = Get.find<UserDataController>();
  final SongModel song;
  final _playlistController = PlaylistController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: SizedBox(
        height: Get.height * 0.9,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Add to Playlist',
              style: theme.textTheme.headline5!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: theme.backgroundColor,
            elevation: 5,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CupertinoButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return CreatePlaylistScreen();
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(30),
                  color: theme.primaryColor,
                  child: Text(
                    'New playlist',
                    style: theme.textTheme.headline6!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Obx(() {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: _dataController.playlists.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: SizedBox(
                            height: 60,
                            width: 60,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: _dataController
                                      .playlists[index].songs.isNotEmpty
                                  ? GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                      ),
                                      itemCount: _dataController
                                                  .playlists[index]
                                                  .songs
                                                  .length >
                                              4
                                          ? 4
                                          : _dataController
                                              .playlists[index].songs.length,
                                      itemBuilder: (context, idx) =>
                                          Image.network(
                                        _dataController.playlists[index]
                                            .songs[idx].data.imgURL,
                                        loadingBuilder:
                                            (context, child, chunkEvent) {
                                          if (chunkEvent == null) return child;
                                          return const LoadingContainer(
                                              width: 30.0, height: 30.0);
                                        },
                                      ),
                                    )
                                  : Image.network(defaultImgURL),
                            ),
                          ),
                          title: Text(
                            _dataController.playlists[index].title,
                          ),
                          subtitle: Text(
                            _dataController.playlists[index].songs.length
                                    .toString() +
                                ' Tracks',
                          ),
                          trailing: Checkbox(
                            value: _dataController.playlists[index].songs
                                .contains(song),
                            onChanged: (value) {
                              if (value!) {
                                _dataController.playlists[index].songs.remove(
                                  song,
                                );
                              } else {
                                _dataController.playlists[index].songs
                                    .add(song);
                              }
                              _dataController.playlists.refresh();
                            },
                          ),
                          onTap: () {
                            bool hasAdded = _dataController
                                .playlists[index].songs
                                .contains(song);

                            if (hasAdded) {
                              _dataController.playlists[index].songs.remove(
                                song,
                              );
                            } else {
                              _dataController.playlists[index].songs.add(song);
                            }
                            // trigger getX to update UI
                            _dataController.playlists.refresh();

                            // update playlist in firestore
                            _playlistController.updatePlaylist(
                              _dataController.playlists[index],
                            );
                          },
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
