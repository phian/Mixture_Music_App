// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mixture_music_app/models/song/song_model.dart';

class SongService {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getSuggestedSongs(
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
        .where('id', isEqualTo: song.id)
        .get()
        .then(
      (value) async {
        if (value.docs.isEmpty) {
          await FirebaseFirestore.instance
              .collection('user_accounts')
              .doc(uid)
              .collection('favorite_songs')
              .add(song.toMap());
        }
      },
    );
  }

  Future<void> removeSongFromFav(String uid, SongModel song) async {
    await FirebaseFirestore.instance
        .collection('user_accounts')
        .doc(uid)
        .collection('favorite_songs')
        .where('id', isEqualTo: song.id)
        .get()
        .then((value) => value.docs.forEach((doc) {
              FirebaseFirestore.instance
                  .collection('user_accounts')
                  .doc(uid)
                  .collection('favorite_songs')
                  .doc(doc.id)
                  .delete();
            }));
  }

  Future<void> addSongToRecents(String uid, SongModel song) async {
    var map = song.toMap();
    map['time'] = Timestamp.now();

    // check if song is already in history
    await FirebaseFirestore.instance
        .collection('user_accounts')
        .doc(uid)
        .collection('recents')
        .where('id', isEqualTo: song.id)
        .get()
        .then(
      (value) {
        if (value.docs.isEmpty) {
          return FirebaseFirestore.instance
              .collection('user_accounts')
              .doc(uid)
              .collection('recents')
              .add(map);
        }

        return FirebaseFirestore.instance
            .collection('user_accounts')
            .doc(uid)
            .collection('recents')
            .doc(value.docs[0].id)
            .set(map);
      },
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUserRecents(String uid) async {
    return await FirebaseFirestore.instance
        .collection('user_accounts')
        .doc(uid)
        .collection('recents')
        .orderBy('time', descending: true)
        .limit(25)
        .get();
  }
}
