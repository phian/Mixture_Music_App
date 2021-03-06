import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/controllers/user_data_controller.dart';
import 'package:mixture_music_app/images/app_images.dart';
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
      () => _userDataController.recents.isNotEmpty
          ? ListView.separated(
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
                      _initAudioSource(index: index);
                      if (_musicController.indexList.isEmpty) {
                        for (int i = 0; i < _userDataController.currentPlaylist.length; i++) {
                          _musicController.indexList.add(i);
                        }
                      }
                      _updatePlayingItem(index);
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
            )
          : Center(
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
                    'Your recent activity is empty',
                    style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
    );
  }

  void _updatePlayingItem(int index) async {
    if (_musicController.playingSong.value?.id != _userDataController.recents[index].id) {
      audioHandler.skipToQueueItem(index);
      audioHandler.play();

      _musicController.indexIndexList.value = index;

      _musicController.setSong(
        _userDataController.recents[index],
      );
      _musicController.playingSong.value = _userDataController.recents[index];
    } else {
      _checkPlayerState();
    }
  }

  void _initAudioSource({int? index}) {
    audioHandler.initAudioSource(_userDataController.recents, index: index);
    _userDataController.currentPlaylistType.value = 'recent';
    _userDataController.currentPlaylist.value = List.from(_userDataController.recents);
  }

  void _checkPlayerState() {
    if (audioHandler.player.playing == false) {
      audioHandler.play();
    } else {
      audioHandler.pause();
    }
  }
}
