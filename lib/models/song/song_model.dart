

import 'package:mixture_music_app/models/song/song_data.dart';

class SongModel {
  String id;
  SongData data;
  SongModel({
    required this.id,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'song_data': data.toMap(),
    };
  }

  factory SongModel.from({
    required Map<String, dynamic> data,
    required String id,
  }) {
    return SongModel(
      id: id,
      data: SongData.fromMap(data),
    );
  }
}
