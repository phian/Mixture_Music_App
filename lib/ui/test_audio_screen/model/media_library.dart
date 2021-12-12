import 'package:audio_service/audio_service.dart';

class MediaLibrary {
  final _items = <MediaItem>[
    MediaItem(
      // This can be any unique id, but we use the audio URL for convenience.
      id: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
      album: 'Science Friday 1',
      title: 'A Salute To Head-Scratching Science',
      artist: 'Science Friday and WNYC Studios',
      duration: Duration(milliseconds: 5739820),
      artUri: Uri.parse('https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
    ),
    MediaItem(
      id: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      album: 'Science Friday 2',
      title: 'From Cat Rheology To Operatic Incompetence',
      artist: 'Science Friday and WNYC Studios',
      duration: const Duration(milliseconds: 2856950),
      artUri: Uri.parse('https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
    ),
  ];

  List<MediaItem> get items => _items;
}
