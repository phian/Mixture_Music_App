import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mixture_music_app/models/song/song_data.dart';
import 'package:mixture_music_app/models/song/song_model.dart';

class Playlist {
  Timestamp createdTime;
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
      createdTime: map['created_time'] as Timestamp,
      title: map['title'] ?? 'Untitled',
      songs: List<SongModel>.from(
        map['songs'].map(
          (x) => SongModel(id: x['id'], data: SongData.fromMap(x['data'])),
        ),
      ),
    );
  }
}
