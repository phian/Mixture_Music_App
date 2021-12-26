import 'package:audio_service/audio_service.dart';
import 'package:mixture_music_app/models/song/song_model.dart';

extension ListExtensions<E> on List<E> {
  E? safeGet(int index) => isEmpty || length <= index ? null : this[index];

  E? get safeGetLast => isEmpty ? null : this[length - 1];
}

extension ConvertSongModel on List<SongModel> {
  List<MediaItem> convertToMediaItemList() {
    List<MediaItem> items = [];

    for (int i = 0; i < length; i++) {
      items.add(
        MediaItem(
          id: this[i].data.audioURL,
          title: this[i].data.title,
          artist: this[i].data.artist,
          artUri: Uri.tryParse(this[i].data.imgURL),
        ),
      );
    }

    return items;
  }
}
