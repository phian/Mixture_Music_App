import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mixture_music_app/models/song/song_data.dart';
import 'package:mixture_music_app/models/song/song_model.dart';

class Playlist {
  String? id;
  Timestamp createdTime;
  String title;
  List<SongModel> songs;

  Playlist({
    required this.createdTime,
    required this.title,
    required this.songs,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'created_time': createdTime,
      'title': title,
      'songs': songs.map((x) => x.toMap()).toList(),
    };
  }

  factory Playlist.fromSnapshot(DocumentSnapshot snapshot) {
    return Playlist(
      id: snapshot.id,
      createdTime: snapshot['created_time'] as Timestamp,
      title: snapshot['title'] ?? 'Untitled',
      songs: List<SongModel>.from(
        snapshot['songs'].map(
          (x) => SongModel(id: x['id'], data: SongData.fromMap(x['data'])),
        ),
      ),
    );
  }
}
