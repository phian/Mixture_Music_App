import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mixture_music_app/models/playlist/playlist.dart';

class PlaylistService {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAllUserPlayList(String uid) async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> playlists = [];

    await FirebaseFirestore.instance
        .collection('user_accounts')
        .doc(uid)
        .collection('created_playlists')
        .get()
        .then((value) {
      playlists = value.docs;
    });

    return playlists;
  }

  Future<void> createPlaylist(Playlist playlist) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('user_accounts')
          .doc(user.uid)
          .collection('created_playlists')
          .add(playlist.toMap());
    }
  }

  Future<void> updatePlaylist(Playlist playlist) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('user_accounts')
          .doc(user.uid)
          .collection('created_playlists')
          .doc(playlist.id)
          .set(playlist.toMap());
    }
  }

  Future<void> deletePlaylist(Playlist playlist) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('user_accounts')
          .doc(user.uid)
          .collection('created_playlists')
          .doc(playlist.id)
          .delete();
    }
  }
}
