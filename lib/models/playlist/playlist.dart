

import 'package:mixture_music_app/models/song/song_data.dart';

class Playlist {
  int createdTime;
  String title;
  List<SongData> songs;

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

  // factory Playlist.fromMap(Map<String, dynamic> map) {
  //   return Playlist(
  //     createdTime: map['createdTime']?.toInt() ?? 0,
  //     title: map['title'] ?? 'Untitled',
  //     songs: List<SongData>.from(
  //         map['songs']?.map((x) => SongData.fromMap(x['data'], x['id']))),
  //   );
  // }
}
