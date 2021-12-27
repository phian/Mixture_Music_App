import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mixture_music_app/models/song/song_model.dart';
import 'package:mixture_music_app/ui/test_audio_screen/model/queue_state.dart';
import 'package:mixture_music_app/utils/extensions.dart';
import 'package:rxdart/rxdart.dart';

late AudioPlayerHandler audioHandler;

Future<void> initAudioHandler() async {
  audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    ),
  );
}

/// An [AudioHandler] for playing a single item.
class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  List<MediaItem> _items = [];
  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  List<MediaItem> get items => _items;

  /// Initialise our audio handler.
  AudioPlayerHandler() {
    // So that our clients (the Flutter UI and the system notification) know
    // what state to display, here we set up our audio handler to broadcast all
    // playback state changes as they happen via playbackState...
    init();
    // ... and also the current media item via mediaItem.
    // initAudioSource();

    // Load the player.
    // _player.setAudioSource(
    //   ConcatenatingAudioSource(
    //     children: List.generate(_items.length, (index) => AudioSource.uri(Uri.parse(_items[index].id))),
    //   ),
    // );
  }

  void init() {
    // Broadcast media item changes.
    Rx.combineLatest4<int?, List<MediaItem>, bool, List<int>?, MediaItem?>(
        _player.currentIndexStream, queue, _player.shuffleModeEnabledStream, _player.shuffleIndicesStream,
        (index, queue, shuffleModeEnabled, shuffleIndices) {
      final queueIndex = getQueueIndex(index, shuffleModeEnabled, shuffleIndices);
      return (queueIndex != null && queueIndex < queue.length) ? queue[queueIndex] : null;
    }).whereType<MediaItem>().distinct().listen(mediaItem.add);

    // Propagate all events from the audio player to AudioService clients.
    _player.playbackEventStream.listen(_broadcastState);
    _player.shuffleModeEnabledStream.listen((enabled) => _broadcastState(_player.playbackEvent));

    // Listen to current song process
    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        _player.stop();
        _player.seekToNext();
      }
      _broadcastState(_player.playbackEvent);
    });
  }

  void initAudioSource(List<SongModel> songs, {int? index}) async {
    if (songs.isNotEmpty) {
      _items = List.from(songs.convertToMediaItemList());
      mediaItem.add(index != null ? _items[_player.shuffleModeEnabled ? _player.shuffleIndices![index] : index] : _items[0]);
      // Load the player.
      _player.setAudioSource(
        ConcatenatingAudioSource(
          children: List.generate(_items.length, (index) => AudioSource.uri(Uri.parse(_items[index].id))),
        ),
        initialIndex: index ?? 0,
      );
    }
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= _items.length) return;
    // This jumps to the beginning of the queue item at [index].
    mediaItem.add(_items[_player.shuffleModeEnabled ? _player.shuffleIndices![index] : index]);
    _player.seek(Duration.zero, index: _player.shuffleModeEnabled ? _player.shuffleIndices![index] : index);
  }

  @override
  Future<void> updateQueue(List<MediaItem> queue) async {
    _items.clear();
    _items.addAll(queue);
    // await _player.setAudioSource(
    //   ConcatenatingAudioSource(
    //     children: List.generate(queue.length, (index) => AudioSource.uri(Uri.parse(queue[index].id))),
    //   ),
    // );
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    final enabled = shuffleMode == AudioServiceShuffleMode.all;
    if (enabled) {
      await _player.shuffle();
    }
    playbackState.add(playbackState.value.copyWith(shuffleMode: shuffleMode));
    await _player.setShuffleModeEnabled(enabled);
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    playbackState.add(playbackState.value.copyWith(repeatMode: repeatMode));
    await _player.setLoopMode(LoopMode.values[repeatMode.index]);
  }

  @override
  Future<void> skipToNext() {
    _player.seekToNext();
    // if (_player.hasNext) {
    //   if (_player.currentIndex != null) {
    //     mediaItem.add(_items[_player.currentIndex! + 1]);
    //   }
    // }
    return super.skipToNext();
  }

  @override
  Future<void> skipToPrevious() {
    _player.seekToPrevious();
    // if (_player.hasPrevious) {
    //   if (_player.currentIndex != null) {
    //     mediaItem.add(_items[_player.currentIndex! - 1]);
    //   }
    // }
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

  /// Computes the effective queue index taking shuffle mode into account.
  int? getQueueIndex(int? currentIndex, bool shuffleModeEnabled, List<int>? shuffleIndices) {
    final effectiveIndices = _player.effectiveIndices ?? [];
    final shuffleIndicesInv = List.filled(effectiveIndices.length, 0);
    for (var i = 0; i < effectiveIndices.length; i++) {
      shuffleIndicesInv[effectiveIndices[i]] = i;
    }
    return (shuffleModeEnabled && ((currentIndex ?? 0) < shuffleIndicesInv.length)) ? shuffleIndicesInv[currentIndex ?? 0] : currentIndex;
  }

  /// A stream reporting the combined state of the current queue and the current
  /// media item within that queue.
  Stream<QueueState> get queueState => Rx.combineLatest3<List<MediaItem>, PlaybackState, List<int>, QueueState>(
        queue,
        playbackState,
        _player.shuffleIndicesStream.whereType<List<int>>(),
        (queue, playbackState, shuffleIndices) => QueueState(
          queue,
          playbackState.queueIndex,
          playbackState.shuffleMode == AudioServiceShuffleMode.all ? shuffleIndices : null,
          playbackState.repeatMode,
        ),
      ).where((state) => state.shuffleIndices == null || state.queue.length == state.shuffleIndices!.length);

  /// A stream of the current effective sequence from just_audio.
  Stream<List<IndexedAudioSource>> get _effectiveSequence =>
      Rx.combineLatest3<List<IndexedAudioSource>?, List<int>?, bool, List<IndexedAudioSource>?>(
          _player.sequenceStream, _player.shuffleIndicesStream, _player.shuffleModeEnabledStream, (sequence, shuffleIndices, shuffleModeEnabled) {
        if (sequence == null) return [];
        if (!shuffleModeEnabled) return sequence;
        if (shuffleIndices == null) return null;
        if (shuffleIndices.length != sequence.length) return null;
        return shuffleIndices.map((i) => sequence[i]).toList();
      }).whereType<List<IndexedAudioSource>>();

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
        MediaAction.setShuffleMode,
        MediaAction.setRepeatMode,
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

  /// Broadcasts the current state to all clients.
  void _broadcastState(PlaybackEvent event) {
    final playing = _player.playing;
    final queueIndex = getQueueIndex(event.currentIndex, _player.shuffleModeEnabled, _player.shuffleIndices);
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        if (playing) MediaControl.pause else MediaControl.play,
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
      playing: playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: queueIndex,
    ));
  }
}
