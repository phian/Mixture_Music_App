import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mixture_music_app/models/song/song_model.dart';

class SongService {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getSuggestedPlaylist(
      String weatherType) async {
    var limitSuggestedSong = 10;
    List<QueryDocumentSnapshot<Map<String, dynamic>>> songs = [];
    await FirebaseFirestore.instance
        .collection('songs')
        .where('suitable_weather', arrayContains: weatherType)
        .get()
        .then((value) {
      songs = value.docs;
      songs.shuffle();
      songs = songs.sublist(0, limitSuggestedSong);
    });
    return songs;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllSongs() async {
    return await FirebaseFirestore.instance
        .collection('songs')
        .orderBy('title')
        // .where('title', isGreaterThanOrEqualTo: keyword)
        // .where('title', isLessThan: keyword + 'z')
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUserFavSongs(String uid) async {
    return await FirebaseFirestore.instance
        .collection('user_accounts')
        .doc(uid)
        .collection('favorite_songs')
        .get();
  }

  Future<void> addSongToFav(String uid, SongModel song) async {
    await FirebaseFirestore.instance
        .collection('user_accounts')
        .doc(uid)
        .collection('favorite_songs')
        .add(song.toMap());
  }
}
