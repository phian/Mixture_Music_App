

import 'package:mixture_music_app/models/song/song_data.dart';

class Song {
  String id;
  SongData data;
  Song({
    required this.id,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'song_data': data.toMap(),
    };
  }

  factory Song.from({
    required Map<String, dynamic> data,
    required String id,
  }) {
    return Song(
      id: id,
      data: SongData.fromMap(data),
    );
  }
}
