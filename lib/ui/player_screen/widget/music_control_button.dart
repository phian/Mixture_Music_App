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
          stream: audioHandler.playbackState
              .map((state) => state.shuffleMode == AudioServiceShuffleMode.all)
              .distinct(),
          builder: (context, snapshot) {
            final shuffleModeEnabled = snapshot.data ?? false;

            return CupertinoButton(
              child: Icon(
                Icons.shuffle,
                color: shuffleModeEnabled ? theme.colorScheme.onBackground : theme.disabledColor,
              ),
              onPressed: () async {
                final enable = !shuffleModeEnabled;
                await audioHandler.setShuffleMode(
                    enable ? AudioServiceShuffleMode.all : AudioServiceShuffleMode.none);

                if (enable) {
                  widget.controller.isShuffle.value = true;
                  print('shuffled list: ${audioHandler.player.shuffleIndices}');

                  widget.controller.indexList.value = audioHandler.player.shuffleIndices!;

                  widget.controller.indexIndexList.value = 0;
                } else {
                  widget.controller.isShuffle.value = false;

                  widget.controller.indexIndexList.value =
                      widget.controller.indexList[widget.controller.indexIndexList.value];
                  widget.controller.indexList.clear();
                  for (int i = 0; i < widget.userDataController.currentPlaylist.length; i++) {
                    widget.controller.indexList.add(i);
                  }
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
                if (widget.controller.indexIndexList.value > 0) {
                  widget.controller.indexIndexList--;
                  audioHandler.skipToPrevious();
                } else {
                  widget.controller.indexIndexList.value = widget.controller.indexList.length - 1;

                  audioHandler.skipToQueueItem(widget.controller.indexIndexList.value);
                }
                widget.controller.playingSong.value = widget.userDataController
                    .currentPlaylist[widget.controller.indexList[widget.controller.indexIndexList.value]];
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

            if (processingState == AudioProcessingState.loading ||
                processingState == AudioProcessingState.buffering) {
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
                if (widget.controller.indexIndexList.value + 1 < widget.controller.indexList.length) {
                  widget.controller.indexIndexList++;
                  audioHandler.skipToNext();
                } else {
                  widget.controller.indexIndexList.value = 0;
                  audioHandler.skipToQueueItem(widget.controller.indexIndexList.value);
                }
                widget.controller.playingSong.value = widget.userDataController
                    .currentPlaylist[widget.controller.indexList[widget.controller.indexIndexList.value]];
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
                color: repeatMode == AudioServiceRepeatMode.none
                    ? theme.disabledColor
                    : theme.colorScheme.onBackground,
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
