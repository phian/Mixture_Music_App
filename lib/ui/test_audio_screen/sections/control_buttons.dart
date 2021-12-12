import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/ui/test_audio_screen/model/custom_audio_handler.dart';
import 'package:mixture_music_app/utils/extensions.dart';

//tach methods
class ControlButtons extends StatefulWidget {
  const ControlButtons({Key? key, required this.audioHandler}) : super(key: key);

  final CustomAudioHandler audioHandler;

  @override
  _ControlButtonsState createState() => _ControlButtonsState();
}

class _ControlButtonsState extends State<ControlButtons> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildShuffleButton(),
            _buildSkipPreviousButton(),
            _buildPlayPauseButton(),
            _buildSkipNextButton(),
            _buildRepeatButton(),
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     // IconButton(
        //     //   icon: Icon(
        //     //     Icons.volume_up,
        //     //     color: AppColors.c7E7E7E,
        //     //   ),
        //     //   onPressed: () {
        //     //     _showSliderDialog(
        //     //       context: context,
        //     //       title: "Adjust volume",
        //     //       divisions: 10,
        //     //       min: 0.0,
        //     //       max: 1.0,
        //     //       stream: AudioService.playbackStateStream,
        //     //       onChanged: widget.player.setVolume,
        //     //     );
        //     //   },
        //     // ),
        //     // StreamBuilder<double>(
        //     //   stream: widget.player.speedStream,
        //     //   builder: (context, snapshot) => IconButton(
        //     //     icon: Text(
        //     //       "${snapshot.data?.toStringAsFixed(1)}x",
        //     //       style: TextStyle(
        //     //         fontWeight: FontWeight.bold,
        //     //         color: AppColors.c7E7E7E,
        //     //       ),
        //     //     ),
        //     //     onPressed: () {
        //     //       _showSliderDialog(
        //     //         context: context,
        //     //         title: "Adjust speed",
        //     //         divisions: 10,
        //     //         min: 0.5,
        //     //         max: 1.5,
        //     //         stream: widget.player.speedStream,
        //     //         onChanged: widget.player.setSpeed,
        //     //       );
        //     //     },
        //     //   ),
        //     // ),
        //   ],
        // ),
      ],
    ).marginOnly(top: 16.0);
  }

  StreamBuilder<PlaybackState> _buildRepeatButton() {
    return StreamBuilder<PlaybackState>(
      stream: widget.audioHandler.playbackState,
      builder: (context, snapshot) {
        final loopMode = snapshot.data?.repeatMode ?? AudioServiceRepeatMode.none;
        const icons = [
          Icon(Icons.repeat, color: Colors.grey),
          Icon(Icons.repeat, color: Colors.orange),
          Icon(Icons.repeat_one, color: Colors.orange),
        ];
        const cycleModes = [
          AudioServiceRepeatMode.none,
          AudioServiceRepeatMode.all,
          AudioServiceRepeatMode.one,
        ];
        final index = cycleModes.indexOf(loopMode);
        return IconButton(
          icon: icons[index],
          onPressed: () {
            widget.audioHandler.setRepeatMode(cycleModes[(cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
          },
        );
      },
    );
  }

  StreamBuilder<MediaItem?> _buildSkipNextButton() {
    return StreamBuilder<MediaItem?>(
      stream: widget.audioHandler.mediaItem,
      builder: (context, snapshot) {
        final isEnable = widget.audioHandler.mediaItem.value?.id != widget.audioHandler.queue.value.safeGetLast?.id;
        return IconButton(
          icon: Icon(
            Icons.skip_next,
            color: isEnable ? AppColors.subTextColor : AppColors.black,
          ),
          onPressed: isEnable
              ? () {
                  widget.audioHandler.skipToNext();
                }
              : null,
        );
      },
    );
  }

  StreamBuilder<PlaybackState> _buildPlayPauseButton() {
    return StreamBuilder<PlaybackState>(
      stream: widget.audioHandler.playbackState,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (processingState == AudioProcessingState.loading || processingState == AudioProcessingState.buffering) {
          return const SizedBox(
            width: 84.0,
            height: 84.0,
            child: SpinKitCircle(
              color: AppColors.cE30098,
              size: 84.0,
            ),
          );
        } else if (playing != true) {
          return Container(
            padding: const EdgeInsets.all(12.0),
            decoration: _buttonDecoration(),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.play_arrow),
              iconSize: 60.0,
              onPressed: () {
                widget.audioHandler.play();
              },
            ),
          );
        } else if (processingState != AudioProcessingState.completed) {
          return Container(
            padding: const EdgeInsets.all(12.0),
            decoration: _buttonDecoration(),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.pause),
              iconSize: 60.0,
              onPressed: () {
                widget.audioHandler.pause();
              },
            ),
          );
        } else {
          return Container(
            padding: const EdgeInsets.all(12.0),
            decoration: _buttonDecoration(),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.replay),
              iconSize: 60.0,
              onPressed: () => widget.audioHandler.seek(Duration.zero),
            ),
          );
        }
      },
    );
  }

  StreamBuilder<MediaItem?> _buildSkipPreviousButton() {
    return StreamBuilder<MediaItem?>(
      stream: widget.audioHandler.mediaItem,
      builder: (context, snapshot) {
        final isEnable = widget.audioHandler.mediaItem.value?.id != widget.audioHandler.queue.value.safeGet(0)?.id;
        return IconButton(
          icon: Icon(
            Icons.skip_previous,
            color: isEnable ? AppColors.subTextColor : AppColors.black,
          ),
          onPressed: isEnable
              ? () {
                  widget.audioHandler.skipToPrevious();
                }
              : null,
        );
      },
    );
  }

  StreamBuilder<PlaybackState> _buildShuffleButton() {
    return StreamBuilder<PlaybackState>(
      stream: widget.audioHandler.playbackState,
      builder: (context, snapshot) {
        final shuffleModeEnabled = snapshot.data?.shuffleMode != AudioServiceShuffleMode.none;
        return IconButton(
          icon: shuffleModeEnabled ? const Icon(Icons.shuffle, color: Colors.orange) : const Icon(Icons.shuffle, color: Colors.grey),
          onPressed: () async {
            if (shuffleModeEnabled) {
              widget.audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
            } else {
              widget.audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
            }
          },
        );
      },
    );
  }

  void _showSliderDialog({
    required BuildContext context,
    required String title,
    required int divisions,
    required double min,
    required double max,
    String valueSuffix = '',
    required Stream<double> stream,
    required ValueChanged<double> onChanged,
  }) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, textAlign: TextAlign.center),
        content: StreamBuilder<double>(
          stream: stream,
          builder: (context, snapshot) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: const TextStyle(fontFamily: 'Fixed', fontWeight: FontWeight.bold, fontSize: 24.0)),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? 1.0,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buttonDecoration() {
    return const BoxDecoration(
      color: AppColors.cE30098,
      shape: BoxShape.circle,
    );
  }
}
