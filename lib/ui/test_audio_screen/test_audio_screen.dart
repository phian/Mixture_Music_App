import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mixture_music_app/controllers/playlist_controller.dart';
import 'package:mixture_music_app/ui/test_audio_screen/model/media_state.dart';
import 'package:mixture_music_app/ui/test_audio_screen/service/audio_player_handler.dart';
import 'package:mixture_music_app/ui/test_audio_screen/widgets/seek_bar.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class TestAudioScreen extends StatefulWidget {
  const TestAudioScreen({Key? key}) : super(key: key);

  @override
  State<TestAudioScreen> createState() => _TestAudioScreenState();
}

class _TestAudioScreenState extends State<TestAudioScreen> {
  final PlaylistController _playlistController = PlaylistController();

  @override
  void initState() {
    super.initState();
    _getUserSongs();
  }

  void _getUserSongs() async {
    var playlists = await _playlistController.getAllUserPlayList(
      FirebaseAuth.instance.currentUser!.uid,
    );
    audioHandler.initAudioSource(playlists[0].songs);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Service Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Show media item title
            StreamBuilder<MediaItem?>(
              stream: audioHandler.mediaItem,
              builder: (context, snapshot) {
                final mediaItem = snapshot.data;
                return Text(mediaItem?.title ?? '');
              },
            ),
            // Play/pause/stop buttons.
            StreamBuilder<bool>(
              stream: audioHandler.playbackState.map((state) => state.playing).distinct(),
              builder: (context, snapshot) {
                final playing = snapshot.data ?? false;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _button(Icons.skip_previous, audioHandler.skipToPrevious),
                    if (playing)
                      _button(Icons.pause, audioHandler.pause)
                    else
                      _button(Icons.play_arrow, audioHandler.play),
                    _button(Icons.stop, audioHandler.stop),
                    _button(Icons.skip_next, audioHandler.skipToNext),
                  ],
                );
              },
            ),
            // A seek bar.
            StreamBuilder<MediaState>(
              stream: _mediaStateStream,
              builder: (context, snapshot) {
                final mediaState = snapshot.data;
                return SeekBar(
                  duration: mediaState?.mediaItem?.duration ?? Duration.zero,
                  position: mediaState?.position ?? Duration.zero,
                  onChangeEnd: (newPosition) {
                    audioHandler.seek(newPosition);
                  },
                );
              },
            ),
            // Display the processing state.
            StreamBuilder<AudioProcessingState>(
              stream: audioHandler.playbackState.map((state) => state.processingState).distinct(),
              builder: (context, snapshot) {
                final processingState = snapshot.data ?? AudioProcessingState.idle;
                return Text('Processing state: ${describeEnum(processingState)}');
              },
            ),
          ],
        ),
      ),
    );
  }

  /// A stream reporting the combined state of the current media item and its
  /// current position.
  Stream<MediaState> get _mediaStateStream =>
      rxdart.Rx.combineLatest2<MediaItem?, Duration, MediaState>(
        audioHandler.mediaItem,
        AudioService.position,
        (mediaItem, position) => MediaState(mediaItem, position),
      );

  IconButton _button(IconData iconData, VoidCallback onPressed) => IconButton(
        icon: Icon(iconData),
        iconSize: 64.0,
        onPressed: onPressed,
      );
}
