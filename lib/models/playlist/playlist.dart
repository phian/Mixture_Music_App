import 'package:mixture_music_app/models/song/song_data.dart';
import 'package:mixture_music_app/models/song/song_model.dart';

class Playlist {
  int createdTime;
  String title;
  List<SongModel> songs;

  Playlist({
    required this.createdTime,
    required this.title,
    required this.songs,
  });

  Map<String, dynamic> toMap() {
    return {
      'created_time': createdTime,
      'title': title,
      'songs': songs.map((x) => x.toMap()).toList(),
    };
  }

  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      createdTime: map['created_time']?.toInt() ?? 0,
      title: map['title'] ?? 'Untitled',
      songs: List<SongModel>.from(
        map['songs']?.map((x) => SongModel.from(id: x['id'], data: x['data'])),
      ),
    );
  }
}
