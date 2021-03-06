import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/controllers/user_data_controller.dart';
import 'package:mixture_music_app/ui/test_audio_screen/service/audio_player_handler.dart';

import '../../widgets/song_tile.dart';
import '../player_screen/controller/music_player_controller.dart';
import 'controller/home_controller.dart';
import 'widget/playlist_header.dart';
import 'widget/refresh_indicator.dart';
import 'widget/weather_infor.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.find<HomeController>();
  final musicController = Get.put(MusicPlayerController());
  final _userDataController = Get.put(UserDataController());
  bool _isRefreshed = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: CustomRefreshIndicator(
          builder: (
            BuildContext context,
            Widget child,
            IndicatorController indiController,
          ) {
            return MRefreshIndicator(
              context: context,
              child: child,
              controller: indiController,
            );
          },
          onRefresh: () async {
            await controller.onPullToRefresh();
            setState(() {
              _isRefreshed = true;
            });
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              children: [
                Obx(() {
                  if (controller.weatherModel.value != null) {
                    return WeatherInfo(
                      weatherResponse: controller.weatherModel.value!,
                      location: controller.location.value,
                    );
                  }
                  return const SizedBox.shrink();
                }),
                const SizedBox(height: 16),
                const Divider(
                  indent: 16,
                  thickness: 0.5,
                  height: 16,
                ),
                Obx(() {
                  return PlaylistHeader(
                    coverImageUrl: controller.suggestedSongs.map((e) => e.data.imgURL).toList(),
                    onSave: () {
                      controller.saveSuggestedSongAsPlaylist().then(
                            (value) => Fluttertoast.showToast(
                              msg: 'Added playlist to your Library',
                              backgroundColor: theme.primaryColor,
                            ),
                          );
                      _userDataController.getAllUserPlaylists();
                    },
                    onRefresh: () async {
                      await controller.getSuggestSongs();
                      setState(() {
                        _isRefreshed = true;
                      });
                    },
                  );
                }),
                const Divider(
                  indent: 16,
                  endIndent: 16,
                  thickness: 0.5,
                  height: 1,
                ),
                Obx(
                  () => ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    itemCount: controller.suggestedSongs.length,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => SongTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          songModel: controller.suggestedSongs[index],
                          isPlaying: musicController.playingSong.value != null
                              ? musicController.playingSong.value!.id == controller.suggestedSongs[index].id
                                  ? true
                                  : false
                              : false,
                          onTap: () async {
                            print('current index: ${audioHandler.player.currentIndex}');
                            _initAudioSource(index: index);

                            if (musicController.indexList.isEmpty) {
                              for (int i = 0; i < _userDataController.currentPlaylist.length; i++) {
                                musicController.indexList.add(i);
                              }
                            }
                            _updatePlayingItem(index);
                          },
                          isFavorite: _userDataController.favorites.contains(
                            controller.suggestedSongs[index],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                      thickness: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updatePlayingItem(int index) async {
    if (musicController.playingSong.value?.id != controller.suggestedSongs[index].id) {
      audioHandler.skipToQueueItem(index);
      audioHandler.play();

      musicController.indexIndexList.value = index;

      musicController.setSong(
        controller.suggestedSongs[index],
      );
      _userDataController.getAllUserRecents();

      musicController.playingSong.value = _userDataController.currentPlaylist[index];
    } else {
      _checkPlayerState();
    }
  }

  void _initAudioSource({int? index}) {
    audioHandler.initAudioSource(controller.suggestedSongs, index: index);
    _userDataController.currentPlaylistType.value = 'suggest';
    _userDataController.currentPlaylist.value = List.from(controller.suggestedSongs);
  }

  void _checkPlayerState() {
    if (audioHandler.player.playing == false) {
      audioHandler.play();
    } else {
      audioHandler.pause();
    }
  }
}
