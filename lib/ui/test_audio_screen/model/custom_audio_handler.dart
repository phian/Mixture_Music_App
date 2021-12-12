import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mixture_music_app/images/app_icons.dart';
import 'package:mixture_music_app/ui/test_audio_screen/model/media_library.dart';
import 'package:mixture_music_app/ui/test_audio_screen/model/seeker.dart';

Future<AudioHandler> initAudioService() async {
  return await AudioService.init(
    builder: () => CustomAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.mixture.music.mixture_music_app',
      androidNotificationChannelName: 'Mixture Music Notification Channel',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
      androidNotificationIcon: AppIcons.appIcon,
    ),
  );
}

// mix in default queue callback implementations
class CustomAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;
  AudioProcessingState? _skipState;
  final MediaLibrary _mediaLibrary = MediaLibrary(); // Fake data
  late StreamSubscription<PlaybackEvent> _eventSubscription;
  Seeker? _seeker;

  void init() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    // Broadcast media item changes.
    _player.currentIndexStream.listen((index) {
      if (index != null) mediaItem.value = queue.value[index];
    });

    // Listen to errors during playback.
    _eventSubscription = _player.playbackEventStream.listen((event) {}, onError: (Object e, StackTrace stackTrace) {
      broadcastState();
      print('A stream error occurred: $e');
    });

    // Special processing for state transitions.
    _player.processingStateStream.listen((state) {
      switch (state) {
        case ProcessingState.completed:
          // In this example, the service stops when reaching the end.
          stop();
          break;
        case ProcessingState.ready:
          // If we just came from skipping between tracks, clear the skip
          // state now that we're ready to play.
          _skipState = null;
          break;
        default:
          break;
      }
    });

    // Try to load audio from a source and catch any errors.
    queue.add(_mediaLibrary.items);
    updateQueue(queue.value);
    try {
      await _player.setAudioSource(
        ConcatenatingAudioSource(
          children: queue.value.map((item) => AudioSource.uri(Uri.parse(item.id))).toList(),
        ),
      );
    } catch (e) {
      print('Error loading audio source: $e');
      stop();
    }
  }

  Future<void> broadcastState() async {
    playbackState.add(
      PlaybackState(
        // Which buttons should appear in the notification now
        controls: [
          MediaControl.skipToPrevious,
          MediaControl.pause,
          MediaControl.stop,
          MediaControl.skipToNext,
        ],
        // Which other actions should be enabled in the notification
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        // Which controls to show in Android's compact view.
        androidCompactActionIndices: const [0, 1, 3],
        // Whether audio is ready, buffering, ...
        processingState: _getProcessingState(),
        // Whether audio is playing
        playing: true,
        // The current position as of this update. You should not broadcast
        // position changes continuously because listeners will be able to
        // project the current position after any elapsed time based on the
        // current speed and whether audio is playing and ready. Instead, only
        // broadcast position updates when they are different from expected (e.g.
        // buffering, or seeking).
        updatePosition: const Duration(milliseconds: 54321),
        // The current buffered position as of this update
        bufferedPosition: const Duration(milliseconds: 65432),
        // The current speed
        speed: 1.0,
        // The current queue position
        queueIndex: 0,
      ),
    );
  }

  /// Jumps away from the current position by [offset].
  Future<void> _seekRelative(Duration offset) async {
    var newPosition = _player.position + offset;
    // Make sure we don't jump out of bounds.
    if (newPosition < Duration.zero) newPosition = Duration.zero;
    if (mediaItem.value != null && mediaItem.value!.duration != null) {
      if (newPosition > mediaItem.value!.duration!) newPosition = mediaItem.value!.duration!;
    }
    // Perform the jump via a seek.
    await _player.seek(newPosition);
  }

  /// Begins or stops a continuous seek in [direction]. After it begins it will
  /// continue seeking forward or backward by 10 seconds within the audio, at
  /// intervals of 1 second in app time.
  void _seekContinuously(bool begin, int direction) {
    _seeker?.stop();
    if (begin) {
      _seeker = Seeker(_player, Duration(seconds: 10 * direction), const Duration(seconds: 1), mediaItem.value!)..start();
    }
  }

  /// Maps just_audio's processing state into into audio_service's playing
  /// state. If we are in the middle of a skip, we use [_skipState] instead.
  AudioProcessingState _getProcessingState() {
    if (_skipState != null) return _skipState!;
    switch (_player.processingState) {
      case ProcessingState.idle:
        return AudioProcessingState.completed;
      case ProcessingState.loading:
        return AudioProcessingState.loading;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
      default:
        throw Exception('Invalid state: ${_player.processingState}');
    }
  }

  @override
  Future<void> updateQueue(List<MediaItem> newQueue) async {
    await _player.setAudioSource(
      ConcatenatingAudioSource(
        children: queue.value.map((item) => AudioSource.uri(Uri.parse(item.id))).toList(),
      ),
    );
    return super.updateQueue(newQueue);
  }

  // mix in default seek callback implementations
  // The most common callbacks:
  @override
  Future<void> play() async {
    // All 'play' requests from all origins route to here. Implement this
    // callback to start playing audio appropriate to your app. e.g. music.
    return _player.play();
  }

  @override
  Future<void> pause() async {
    return _player.pause();
  }

  @override
  Future<void> stop() async {
    await _player.dispose();
    _eventSubscription.cancel();
    // It is important to wait for this state to be broadcast before we shut
    // down the task. If we don't, the background task will be destroyed before
    // the message gets sent to the UI.
    await broadcastState();
    // Shut down this task

    await super.stop();
  }

  @override
  Future<void> seek(Duration position) async {
    return _player.seek(position);
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index == -1) return;

    // During a skip, the player may enter the buffering state. We could just
    // propagate that state directly to AudioService clients but AudioService
    // has some more specific states we could use for skipping to next and
    // previous. This variable holds the preferred state to send instead of
    // buffering during a skip, and it is cleared as soon as the player exits
    // buffering (see the listener in onStart).
    // This jumps to the beginning of the queue item at newIndex.
    _player.seek(Duration.zero, index: index);
    // Demonstrate custom events.
    customEvent.add('skip to $index');
  }

  @override
  Future<void> fastForward() async {
    _seekRelative(const Duration(seconds: 10));
  }

  @override
  Future<void> rewind() async {
    _seekRelative(-(const Duration(seconds: 10)));
  }

  @override
  Future<void> seekBackward(bool begin) async {
    _seekContinuously(begin, -1);
  }

  @override
  Future<void> seekForward(bool begin) async {
    _seekContinuously(begin, 1);
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    switch (repeatMode) {
      case AudioServiceRepeatMode.none:
        _player.setLoopMode(LoopMode.off);
        break;
      case AudioServiceRepeatMode.one:
        _player.setLoopMode(LoopMode.one);
        break;
      case AudioServiceRepeatMode.all:
        _player.setLoopMode(LoopMode.all);
        break;
      case AudioServiceRepeatMode.group:
        _player.setLoopMode(LoopMode.all);
        break;
    }
    playbackState.add(PlaybackState(repeatMode: repeatMode));
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    switch (shuffleMode) {
      case AudioServiceShuffleMode.none:
        _player.setShuffleModeEnabled(false);
        break;
      case AudioServiceShuffleMode.all:
        _player.setShuffleModeEnabled(true);
        break;
      case AudioServiceShuffleMode.group:
        _player.setShuffleModeEnabled(true);
        break;
    }
    playbackState.add(PlaybackState(shuffleMode: shuffleMode));
  }

  @override
  Future<void> setSpeed(double speed) async {
    _player.setSpeed(speed);
  }

  @override
  Future<void> skipToNext() async {
    _player.seekToNext();
  }

  @override
  Future<void> skipToPrevious() async {
    _player.seekToPrevious();
  }
}
