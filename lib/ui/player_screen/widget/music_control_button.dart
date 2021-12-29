import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mixture_music_app/controllers/playlist_controller.dart';
import 'package:mixture_music_app/controllers/user_data_controller.dart';
import 'package:mixture_music_app/ui/player_screen/controller/music_player_controller.dart';
import 'package:mixture_music_app/ui/test_audio_screen/model/queue_state.dart';
import 'package:mixture_music_app/ui/test_audio_screen/service/audio_player_handler.dart';

class MusicControlButton extends StatefulWidget {
  const MusicControlButton({
    Key? key,
    required this.controller,
    required this.userDataController,
  }) : super(key: key);
  final MusicPlayerController controller;
  final UserDataController userDataController;

  @override
  State<MusicControlButton> createState() => _MusicControlButtonState();
}

class _MusicControlButtonState extends State<MusicControlButton> {
  bool isPlaying = false;
  bool isShuffle = false;
  bool isLoop = false;
  final PlaylistController _playlistController = PlaylistController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        StreamBuilder<bool>(
          stream: audioHandler.playbackState.map((state) => state.shuffleMode == AudioServiceShuffleMode.all).distinct(),
          builder: (context, snapshot) {
            final shuffleModeEnabled = snapshot.data ?? false;

            return CupertinoButton(
              child: Icon(
                Icons.shuffle,
                color: shuffleModeEnabled ? theme.colorScheme.onBackground : theme.disabledColor,
              ),
              onPressed: () async {
                final enable = !shuffleModeEnabled;
                await audioHandler.setShuffleMode(enable ? AudioServiceShuffleMode.all : AudioServiceShuffleMode.none);

                if (enable) {
                  widget.controller.isShuffle.value = true;
                  print('shuffled list: ${audioHandler.player.shuffleIndices}');
                  await _playlistController.saveLocalShuffleList(audioHandler.player.shuffleIndices!);
                  widget.controller.shuffleList.value = (await _playlistController.getLocalShuffleList())!;
                  widget.controller.currentIndex.value =
                      widget.userDataController.currentPlaylist.indexWhere((element) => element.id == widget.controller.playingSong.value?.id);
                } else {
                  widget.controller.isShuffle.value = false;
                  widget.controller.shuffleList.value = [];
                  await _playlistController.clearLocalShuffleList();
                }
              },
            );
          },
        ),
        const Spacer(),
        StreamBuilder<SequenceState?>(
          stream: audioHandler.player.sequenceStateStream,
          builder: (context, snapshot) {
            final queueState = snapshot.data ?? QueueState.empty;

            return CupertinoButton(
              child: Icon(
                Icons.skip_previous,
                size: 45,
                color: theme.primaryColor,
              ),
              onPressed: () {
                if (widget.controller.isShuffle.value) {
                  if (widget.controller.currentIndex.value - 1 >= 0) {
                    widget.controller.currentIndex.value = widget.controller.currentIndex.value - 1;
                    audioHandler.initAudioSource(widget.userDataController.currentPlaylist);
                    audioHandler.skipToQueueItem(widget.controller.currentIndex.value);
                    widget.controller.playingSong.value =
                        widget.userDataController.currentPlaylist[widget.controller.shuffleList[widget.controller.currentIndex.value]];
                  } else {
                    widget.controller.currentIndex.value = widget.controller.shuffleList.length - 1;
                    audioHandler.initAudioSource(widget.userDataController.currentPlaylist);
                    audioHandler.skipToQueueItem(widget.controller.currentIndex.value);
                    widget.controller.playingSong.value =
                        widget.userDataController.currentPlaylist[widget.controller.shuffleList[widget.controller.currentIndex.value]];
                  }
                } else {
                  audioHandler.skipToPrevious();

                  if (audioHandler.player.currentIndex != null) {
                    if (audioHandler.player.currentIndex! - 1 >= 0) {
                      widget.controller.currentIndex.value = audioHandler.player.currentIndex! - 1;
                      widget.controller.playingSong.value = widget.userDataController.currentPlaylist[widget.controller.currentIndex.value];
                      audioHandler.skipToQueueItem(audioHandler.player.currentIndex! - 1);
                    } else {
                      widget.controller.currentIndex.value = widget.userDataController.currentPlaylist.length - 1;
                      widget.controller.playingSong.value = widget.userDataController.currentPlaylist[widget.controller.currentIndex.value];
                      audioHandler.skipToQueueItem(widget.controller.currentIndex.value);
                    }
                  }
                }
              },
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
                margin: const EdgeInsets.all(8.0),
                width: 61.0,
                height: 61.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return CupertinoButton(
                child: const Icon(
                  Icons.play_arrow,
                  size: 45,
                  color: Colors.white,
                ),
                onPressed: audioHandler.play,
                padding: const EdgeInsets.all(16),
                borderRadius: BorderRadius.circular(1000),
                color: theme.primaryColor,
              );
            } else {
              return CupertinoButton(
                child: const Icon(
                  Icons.pause,
                  size: 45,
                  color: Colors.white,
                ),
                onPressed: audioHandler.pause,
                padding: const EdgeInsets.all(16),
                borderRadius: BorderRadius.circular(1000),
                color: theme.primaryColor,
              );
            }
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: audioHandler.player.sequenceStateStream,
          builder: (context, snapshot) {
            final queueState = snapshot.data ?? QueueState.empty;

            return CupertinoButton(
              child: Icon(
                Icons.skip_next,
                size: 45,
                color: theme.primaryColor,
              ),
              onPressed: () {
                if (widget.controller.isShuffle.value) {
                  if (widget.controller.currentIndex.value + 1 < widget.controller.shuffleList.length) {
                    widget.controller.currentIndex.value = widget.controller.currentIndex.value + 1;
                    audioHandler.initAudioSource(widget.userDataController.currentPlaylist);
                    audioHandler.skipToQueueItem(widget.controller.currentIndex.value);
                    widget.controller.playingSong.value =
                        widget.userDataController.currentPlaylist[widget.controller.shuffleList[widget.controller.currentIndex.value]];
                  } else {
                    widget.controller.currentIndex.value = 0;
                    audioHandler.initAudioSource(widget.userDataController.currentPlaylist);
                    audioHandler.skipToQueueItem(widget.controller.currentIndex.value);
                    widget.controller.playingSong.value = widget.userDataController.currentPlaylist[widget.controller.shuffleList[0]];
                  }
                } else {
                  audioHandler.skipToNext();

                  if (audioHandler.player.currentIndex != null) {
                    if (audioHandler.player.currentIndex! + 1 < widget.userDataController.currentPlaylist.length) {
                      widget.controller.currentIndex.value = audioHandler.player.currentIndex! + 1;
                      widget.controller.playingSong.value = widget.userDataController.currentPlaylist[widget.controller.currentIndex.value];
                      audioHandler.skipToQueueItem(audioHandler.player.currentIndex! + 1);
                    } else {
                      widget.controller.currentIndex.value = 0;
                      widget.controller.playingSong.value = widget.userDataController.currentPlaylist[0];
                      audioHandler.skipToQueueItem(0);
                    }
                  }
                }
              },
            );
          },
        ),
        const Spacer(),
        StreamBuilder<AudioServiceRepeatMode>(
          stream: audioHandler.playbackState.map((state) => state.repeatMode).distinct(),
          builder: (context, snapshot) {
            final repeatMode = snapshot.data ?? AudioServiceRepeatMode.none;
            const icons = [
              Icons.repeat,
              Icons.repeat,
              Icons.repeat_one,
            ];
            const cycleModes = [
              AudioServiceRepeatMode.none,
              AudioServiceRepeatMode.all,
              AudioServiceRepeatMode.one,
            ];
            final index = cycleModes.indexOf(repeatMode);

            return CupertinoButton(
              child: Icon(
                icons[index],
                color: repeatMode == AudioServiceRepeatMode.none ? theme.disabledColor : theme.colorScheme.onBackground,
              ),
              onPressed: () {
                audioHandler.setRepeatMode(
                  cycleModes[(cycleModes.indexOf(repeatMode) + 1) % cycleModes.length],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
