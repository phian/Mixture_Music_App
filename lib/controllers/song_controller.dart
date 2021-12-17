import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mixture_music_app/models/song/song_data.dart';
import 'package:mixture_music_app/models/song/song_model.dart';

class SongController {
  final limitSuggestedSong = 10;

  Future<List<SongModel>> getSuggestedPlaylist(String weatherType) async {
    var playlist = <SongModel>[];

    await FirebaseFirestore.instance
        .collection('songs')
        .where('suitable_weather', arrayContains: weatherType)
        .get()
        .then((value) {
      var songs = value.docs;
      songs.shuffle();
      songs = songs.sublist(0, limitSuggestedSong);

      for (var song in songs) {
        playlist.add(
          SongModel(
            data: SongData.fromMap(song.data()),
            id: song.id,
          ),
        );
      }
    });
    return playlist;
  }
}
