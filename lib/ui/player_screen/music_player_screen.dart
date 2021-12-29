import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mixture_music_app/constants/app_constants.dart';
import 'package:mixture_music_app/controllers/user_data_controller.dart';
import 'package:mixture_music_app/ui/add_to_playlist/add_to_playlist_screen.dart';
import 'package:mixture_music_app/ui/test_audio_screen/model/position_data.dart';
import 'package:mixture_music_app/ui/test_audio_screen/service/audio_player_handler.dart';
import 'package:mixture_music_app/ui/test_audio_screen/widgets/seek_bar.dart';
import 'package:mixture_music_app/widgets/loading_container.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

import '../../widgets/marquee_text.dart';
import 'controller/music_player_controller.dart';
import 'widget/music_control_button.dart';

class MusicPlayerScreen extends StatefulWidget {
  MusicPlayerScreen({Key? key}) : super(key: key);

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final controller = Get.put(MusicPlayerController());
  final _userDataController = Get.put(UserDataController());

  @override
  void initState() {
    super.initState();
    //_listenToPositionStream();
  }

  void _listenToPositionStream() {
    audioHandler.player.positionStream.listen((position) {
      _onSongCompleted(position);
      //print('aaa');
    });
  }

  bool isFavorite() {
    return _userDataController.favorites.contains(controller.playingSong.value);
  }

  @override
  Widget build(BuildContext context) {
    // _listenToPositionStream();
    final theme = Theme.of(context);
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text(
                'Now playing',
                style: theme.textTheme.headline6,
              ),
              centerTitle: true,
              leading: CupertinoButton(
                onPressed: Get.back,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              actions: [
                CupertinoButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return AddToPlaylistSheet(
                          song: controller.playingSong.value!,
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.playlist_add_rounded,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Hero(
                        tag: 'Artwork',
                        child: controller.playingSong.value != null
                            ? Obx(
                                () => Image.network(
                                  controller.playingSong.value!.data.imgURL,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (_, child, chunkEvent) {
                                    if (chunkEvent == null) return child;

                                    return const LoadingContainer(width: 45.0, height: 45.0);
                                  },
                                ),
                              )
                            : Image.network(
                                defaultImgURL,
                                fit: BoxFit.cover,
                                loadingBuilder: (_, child, chunkEvent) {
                                  if (chunkEvent == null) return child;

                                  return const LoadingContainer(width: 45.0, height: 45.0);
                                },
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => MarqueeText(
                              controller.playingSong.value?.data.title ?? "Song's name",
                              style: Theme.of(context).textTheme.headline6!.copyWith(
                                    fontSize: 26,
                                  ),
                              horizontalPadding: 10,
                            ),
                          ),
                        ),
                        CupertinoButton(
                          onPressed: () async {
                            if (isFavorite()) {
                              _userDataController.favorites.remove(
                                controller.playingSong.value!,
                              );
                              await controller.removeSongFromFav();
                            } else {
                              _userDataController.favorites.add(
                                controller.playingSong.value!,
                              );
                              await controller.addSongToFav();
                            }
                            await _userDataController.getAllUserFavSongs();
                          },
                          child: Icon(
                            isFavorite() ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            color:
                                isFavorite() ? theme.primaryColor : theme.colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => MarqueeText(
                        controller.playingSong.value?.data.artist ?? "Artist's name",
                        style: theme.textTheme.caption!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        horizontalPadding: 10,
                      ),
                    ),
                    const SizedBox(height: 16),
                    StreamBuilder<PositionData>(
                      stream: _positionDataStream,
                      builder: (context, snapshot) {
                        final positionData = snapshot.data ??
                            PositionData(Duration.zero, Duration.zero, Duration.zero);
                        return SeekBar(
                          duration: positionData.duration,
                          position: positionData.position,
                          onChangeEnd: (newPosition) {
                            audioHandler.seek(newPosition);
                            if (newPosition == audioHandler.player.duration) {
                              _onSongCompleted(newPosition);
                            }
                          },
                        );
                      },
                    ),
                    const Expanded(child: SizedBox()),
                    MusicControlButton(
                      controller: controller,
                      userDataController: _userDataController,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSongCompleted(Duration position) {
    if (position >= audioHandler.player.duration!) {
      if (controller.isShuffle.value) {
        switch (audioHandler.player.loopMode) {
          case LoopMode.all:
          case LoopMode.off:
            if (controller.indexIndexList.value + 1 < controller.indexList.length) {
              controller.indexIndexList++;
              audioHandler.skipToNext();
            } else {
              controller.indexIndexList.value = 0;
              audioHandler.skipToQueueItem(controller.indexIndexList.value);
            }
            controller.playingSong.value = _userDataController
                .currentPlaylist[controller.indexList[controller.indexIndexList.value]];

            print(controller.indexIndexList);
            setState(() {});
            break;

          case LoopMode.one:
            break;
        }
      } else {
        switch (audioHandler.player.loopMode) {
          case LoopMode.off:
          case LoopMode.all:
            if (controller.indexIndexList + 1 < _userDataController.currentPlaylist.length) {
              controller.indexIndexList++;

              print('index: ${controller.indexIndexList}');
              audioHandler.skipToNext();
              controller.playingSong.value =
                  _userDataController.currentPlaylist[controller.indexIndexList.value];
              setState(() {});
            } else {
              controller.indexIndexList.value = 0;
              audioHandler.skipToQueueItem(0);
              controller.playingSong.value = _userDataController.currentPlaylist[0];
              setState(() {});
              if (audioHandler.player.loopMode == LoopMode.all) {
                audioHandler.play();
              } else {
                audioHandler.stop();
              }
            }

            break;
          case LoopMode.one:
            break;
        }
      }
    }
  }

  Stream<PositionData> get _positionDataStream =>
      rxdart.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        audioHandler.player.positionStream,
        audioHandler.player.bufferedPositionStream,
        audioHandler.player.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );
}
