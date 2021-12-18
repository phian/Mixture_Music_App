import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mixture_music_app/models/playlist/playlist.dart';

class PlaylistController {
  Future<List<Playlist>> getAllUserPlayList() async {
    var playlists = <Playlist>[];
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('user_accounts')
          .doc(user.uid)
          .collection('created_playlists')
          .get()
          .then((value) {
        for (var playlist in value.docs) {
          playlists.add(Playlist.fromMap(playlist.data()));
          print(playlist.data());
        }
      });
      print(playlists.length);
    }

    return playlists;
  }

  Future<void> createPlaylist(Playlist playlist) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('user_accounts')
          .doc(user.uid)
          .collection('created_playlists').add(playlist.toMap());
    }
  }
}
