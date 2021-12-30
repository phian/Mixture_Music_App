import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mixture_music_app/controllers/user_data_controller.dart';
import 'package:mixture_music_app/models/song/song_model.dart';
import 'package:mixture_music_app/ui/player_screen/controller/music_player_controller.dart';
import 'package:mixture_music_app/ui/test_audio_screen/model/position_data.dart';
import 'package:mixture_music_app/ui/test_audio_screen/model/queue_state.dart';
import 'package:mixture_music_app/ui/test_audio_screen/service/audio_player_handler.dart';
import 'package:mixture_music_app/widgets/loading_container.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

import '../../../constants/app_constants.dart';
import '../../../widgets/marquee_text.dart';

class MiniMusicPlayer extends StatefulWidget {
  const MiniMusicPlayer({
    Key? key,
    required this.song,
    required this.onTap,
  }) : super(key: key);

  final SongModel? song;
  final Function() onTap;

  @override
  State<MiniMusicPlayer> createState() => _MiniMusicPlayerState();
}

class _MiniMusicPlayerState extends State<MiniMusicPlayer> {
  final musicController = Get.find<MusicPlayerController>();
  final _userDataController = Get.find<UserDataController>();

  @override
  Widget build(BuildContext context) {
    if (widget.song == null) {
      return const SizedBox.shrink();
    }
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: widget.onTap,
      child: Material(
        child: Container(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          height: AppConstants.playerMinHeight,
          child: Column(
            children: [
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData =
                      snapshot.data ?? PositionData(Duration.zero, Duration.zero, Duration.zero);
                  return LinearProgressIndicator(
                    value:
                        (positionData.position.inSeconds / positionData.duration.inSeconds).isNaN ||
                                (positionData.position.inSeconds / positionData.duration.inSeconds)
                                    .isInfinite
                            ? 0.0
                            : positionData.position.inSeconds / positionData.duration.inSeconds,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.primaryColor,
                    ),
                    minHeight: 2.2,
                    backgroundColor: theme.primaryColor.withOpacity(0.3),
                  );
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () => Hero(
                          tag: 'Artwork',
                          child: musicController.playingSong.value != null
                              ? Obx(
                                  () => Image.network(
                                    musicController.playingSong.value!.data.imgURL,
                                    width: 45,
                                    height: 45,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (_, child, chunkEvent) {
                                      if (chunkEvent == null) return child;

                                      return const LoadingContainer(width: 45.0, height: 45.0);
                                    },
                                  ),
                                )
                              : Image.network(
                                  defaultImgURL,
                                  width: 45,
                                  height: 45,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (_, child, chunkEvent) {
                                    if (chunkEvent == null) return child;

                                    return const LoadingContainer(width: 45.0, height: 45.0);
                                  },
                                ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => MarqueeText(
                                musicController.playingSong.value?.data.title ?? "Song's name",
                                style: theme.textTheme.headline6!.copyWith(fontSize: 16),
                              ),
                            ),
                            Obx(
                              () => MarqueeText(
                                musicController.playingSong.value?.data.artist ?? "Artist's name",
                                //overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.caption!.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder<SequenceState?>(
                        stream: audioHandler.player.sequenceStateStream,
                        builder: (context, snapshot) {
                          final queueState = snapshot.data ?? QueueState.empty;

                          return IconButton(
                            onPressed: () {
                              if (musicController.indexIndexList.value > 0) {
                                musicController.indexIndexList--;
                                audioHandler.skipToQueueItem(musicController.indexIndexList.value);
                              } else {
                                musicController.indexIndexList.value = musicController.indexList.length - 1;
                                audioHandler.skipToQueueItem(musicController.indexIndexList.value);
                              }
                              musicController.playingSong.value =
                                  _userDataController.currentPlaylist[musicController.indexList[musicController.indexIndexList.value]];

                              setState(() {});
                            },
                            icon: Icon(
                              Icons.skip_previous,
                              color: theme.primaryColor,
                            ),
                          );
                        },
                      ),
                      StreamBuilder<PlaybackState>(
                        stream: audioHandler.playbackState,
                        builder: (context, snapshot) {
                          final playbackState = snapshot.data;
                          final processingState = playbackState?.processingState;
                          final playing = playbackState?.playing;

                          if (processingState == AudioProcessingState.loading || processingState == AudioProcessingState.buffering) {
                            return Container(
                              margin: const EdgeInsets.all(12.0),
                              width: 24.0,
                              height: 24.0,
                              child: const CircularProgressIndicator(),
                            );
                          } else if (playing != true) {
                            return IconButton(
                              icon: Icon(
                                Icons.play_arrow,
                                color: theme.primaryColor,
                              ),
                              onPressed: audioHandler.play,
                            );
                          } else {
                            return IconButton(
                              icon: Icon(
                                Icons.pause,
                                color: theme.primaryColor,
                              ),
                              onPressed: audioHandler.pause,
                            );
                          }
                        },
                      ),
                      StreamBuilder<SequenceState?>(
                        stream: audioHandler.player.sequenceStateStream,
                        builder: (context, snapshot) {
                          final queueState = snapshot.data ?? QueueState.empty;
                          return IconButton(
                            onPressed: () {
                              if (musicController.indexIndexList.value + 1 < musicController.indexList.length) {
                                musicController.indexIndexList++;
                                audioHandler.skipToQueueItem(musicController.indexIndexList.value);
                              } else {
                                musicController.indexIndexList.value = 0;
                                audioHandler.skipToQueueItem(musicController.indexIndexList.value);
                              }
                              musicController.playingSong.value = _userDataController
                                      .currentPlaylist[
                                  musicController.indexList[musicController.indexIndexList.value]];
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.skip_next,
                              color: theme.primaryColor,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stream<Duration> get _bufferedPositionStream =>
      audioHandler.playbackState.map((state) => state.bufferedPosition).distinct();

  Stream<Duration?> get _durationStream =>
      audioHandler.mediaItem.map((item) => item?.duration).distinct();

  Stream<PositionData> get _positionDataStream =>
      rxdart.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          AudioService.position,
          _bufferedPositionStream,
          _durationStream,
          (position, bufferedPosition, duration) =>
              PositionData(position, bufferedPosition, duration ?? Duration.zero));
}
