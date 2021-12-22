
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
      'data': data.toMap(),
    };
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      id: map['id'] ?? '',
      data: SongData.fromMap(map['data']),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SongModel && other.id == id && other.data == data;
  }

  @override
  int get hashCode => id.hashCode ^ data.hashCode;
}
