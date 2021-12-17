import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

/// An [AudioHandler] for playing a single item.
class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  final List<MediaItem> _items = [
    MediaItem(
      // This can be any unique id, but we use the audio URL for convenience.
      id: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
      album: 'Science Friday 1',
      title: 'A Salute To Head-Scratching Science',
      artist: 'Science Friday and WNYC Studios',
      duration: const Duration(milliseconds: 5739820),
      artUri: Uri.parse('https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
    ),
    MediaItem(
      id: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      album: 'Science Friday 2',
      title: 'From Cat Rheology To Operatic Incompetence',
      artist: "Science Friday and NYC Studios",
      duration: const Duration(milliseconds: 2856950),
      artUri: Uri.parse('https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
    ),
  ];

  final _player = AudioPlayer();

  /// Initialise our audio handler.
  AudioPlayerHandler() {
    // So that our clients (the Flutter UI and the system notification) know
    // what state to display, here we set up our audio handler to broadcast all
    // playback state changes as they happen via playbackState...
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    // ... and also the current media item via mediaItem.
    mediaItem.add(_items[0]);

    // Load the player.
    _player.setAudioSource(
      ConcatenatingAudioSource(
        children: List.generate(_items.length, (index) => AudioSource.uri(Uri.parse(_items[index].id))),
      ),
    );
  }

  @override
  Future<void> skipToNext() {
    _player.seekToNext();
    if (_player.hasNext) {
      if (_player.currentIndex != null) {
        mediaItem.add(_items[_player.currentIndex! + 1]);
      }
    }
    return super.skipToNext();
  }

  @override
  Future<void> skipToPrevious() {
    _player.seekToPrevious();
    if (_player.hasPrevious) {
      if (_player.currentIndex != null) {
        mediaItem.add(_items[_player.currentIndex! - 1]);
      }
    }
    return super.skipToPrevious();
  }

  // In this simple example, we handle only 4 actions: play, pause, seek and
  // stop. Any button press from the Flutter UI, notification, lock screen or
  // headset will be routed through to these 4 methods so that you can handle
  // your audio playback logic in one place.

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() => _player.stop();

  /// Transform a just_audio event into an audio_service state.
  ///
  /// This method is used from the constructor. Every event received from the
  /// just_audio player will be transformed into an audio_service state so that
  /// it can be broadcast to audio_service clients.
  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.skipToPrevious,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }
}
