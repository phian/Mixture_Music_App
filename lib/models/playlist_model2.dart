

import 'package:mixture_music_app/models/song_model.dart';

class PlaylistModel2 {
  int id;
  String title;
  int totalSong;
  String coverURL;
  List<SongModel>? songs;
  
  PlaylistModel2({
    required this.id,
    required this.title,
    required this.totalSong,
    required this.coverURL,
    this.songs,
  });
  
}
