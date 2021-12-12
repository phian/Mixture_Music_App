import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mixture_music_app/ui/test_audio_screen/model/custom_audio_handler.dart';
import 'package:mixture_music_app/ui/test_audio_screen/model/position_data.dart';
import 'package:mixture_music_app/ui/test_audio_screen/sections/control_buttons.dart';
import 'package:mixture_music_app/ui/test_audio_screen/widgets/custom_audio_service_widget.dart';
import 'package:mixture_music_app/ui/test_audio_screen/widgets/seek_bar.dart';
import 'package:rxdart/rxdart.dart';

class TestAudioScreen extends StatefulWidget {
  const TestAudioScreen({Key? key}) : super(key: key);

  @override
  _TestAudioScreenState createState() => _TestAudioScreenState();
}

class _TestAudioScreenState extends State<TestAudioScreen> with WidgetsBindingObserver {
  late final CustomAudioHandler _audioHandler = CustomAudioHandler();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.black));
    initAudioService();
    AudioService.init(builder: () => _audioHandler);
    _audioHandler.init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    _audioHandler.player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _audioHandler.player.stop();
    }
  }

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream => Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioHandler.player.positionStream,
        _audioHandler.player.bufferedPositionStream,
        _audioHandler.player.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position: position,
          bufferedPosition: bufferedPosition,
          duration: duration ?? Duration.zero,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CustomAudioServiceWidget(
      audioHandler: _audioHandler,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display play/pause button and volume/speed sliders.
              ControlButtons(audioHandler: _audioHandler),
              // Display seek bar. Using StreamBuilder, this widget rebuilds
              // each time the position, buffered position or duration changes.
              StreamBuilder<MediaItem?>(
                stream: _audioHandler.mediaItem,
                builder: (context, snapshot) {
                  final duration = snapshot.data?.duration ?? Duration.zero;
                  return StreamBuilder<PlaybackState>(
                    stream: _audioHandler.playbackState,
                    builder: (context, snapshot) {
                      final playbackState = snapshot.data;
                      final positionData = PositionData(
                          position: playbackState?.position ?? Duration.zero, bufferedPosition: playbackState?.bufferedPosition ?? Duration.zero);
                      var position = positionData.position;
                      if (position > duration) {
                        position = duration;
                      }
                      var bufferedPosition = positionData.bufferedPosition;
                      if (bufferedPosition > duration) {
                        bufferedPosition = duration;
                      }
                      return Container(
                        margin: const EdgeInsets.only(top: 32.0),
                        child: SeekBar(
                          duration: duration,
                          position: position,
                          bufferedPosition: bufferedPosition,
                          onChangeEnd: (newPosition) {
                            _audioHandler.seek(newPosition);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
