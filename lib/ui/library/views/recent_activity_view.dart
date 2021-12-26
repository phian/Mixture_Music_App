import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/controllers/user_data_controller.dart';
import 'package:mixture_music_app/ui/player_screen/controller/music_player_controller.dart';
import 'package:mixture_music_app/ui/test_audio_screen/service/audio_player_handler.dart';
import 'package:mixture_music_app/widgets/song_tile.dart';

class RecentActivityView extends StatefulWidget {
  const RecentActivityView({Key? key}) : super(key: key);

  @override
  _RecentActivityViewState createState() => _RecentActivityViewState();
}

class _RecentActivityViewState extends State<RecentActivityView> {
  final _userDataController = Get.find<UserDataController>();
  final _musicController = Get.put(MusicPlayerController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _userDataController.recents.length,
        itemBuilder: (context, index) {
          return Obx(
            () => SongTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 32,
              ),
              songModel: _userDataController.recents[index],
              isPlaying: _musicController.playingSong.value != null
                  ? _musicController.playingSong.value!.id == _userDataController.recents[index].id
                      ? true
                      : false
                  : false,
              onTap: () async {
                _musicController.setSong(
                  _userDataController.recents[index],
                );

                _userDataController.setCurrentPlaylistType('recent');
                if (audioHandler.items.isEmpty) {
                  audioHandler.initAudioSource(_userDataController.recents.value, index: index);
                } else {
                  if (_userDataController.currentPlaylistType.value != 'recent') {
                    audioHandler.initAudioSource(_userDataController.recents.value, index: index);
                  }
                }

                _updateCurrentPlaylist();
                if (audioHandler.player.currentIndex == index) {
                  if (audioHandler.player.playing == false) {
                    audioHandler.play();
                  } else {
                    audioHandler.pause();
                  }
                } else {
                  audioHandler.skipToQueueItem(index);
                  audioHandler.play();
                }
              },
              isFavorite: _userDataController.favorites.contains(
                _userDataController.recents[index],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          thickness: 0.5,
        ),
      ),
    );
  }

  void _updateCurrentPlaylist() {
    if (_userDataController.currentPlaylist.isEmpty) {
      _userDataController.setCurrentPlaylist(_userDataController.recents);
    } else {
      if (_userDataController.currentPlaylistType.value != 'recent') {
        _userDataController.currentPlaylist.clear();
        _userDataController.setCurrentPlaylist(_userDataController.recents);
      }
    }
  }
}
