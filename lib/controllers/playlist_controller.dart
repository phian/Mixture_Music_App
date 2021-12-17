import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mixture_music_app/models/playlist/playlist.dart';

class PlaylistController {
  Future<List<Playlist>> getAllUserPlayList() async {
    var playlists = <Playlist>[];
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('user_account')
          .doc(user.uid)
          .collection('created_playlists')
          .orderBy('title')
          .get()
          .then((value) {
        for (var playlist in value.docs) {
          playlists.add(Playlist.fromMap(playlist.data()));
        }
      });
    }
    return playlists;
  }

  
}
