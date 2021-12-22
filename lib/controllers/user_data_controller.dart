import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/controllers/playlist_controller.dart';
import 'package:mixture_music_app/controllers/song_controller.dart';
import 'package:mixture_music_app/models/playlist/playlist.dart';
import 'package:mixture_music_app/models/song/song_model.dart';

class UserDataController extends GetxController {
  var playlists = <Playlist>[].obs;
  var favorites = <SongModel>[].obs;
  final _playlistController = PlaylistController();
  final _songController = SongController();
  final _user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() async {
    super.onInit();
    await getAllUserPlaylists();
    await getAllUserFavSongs();
  }

  Future<void> getAllUserPlaylists() async {
    playlists.value = await _playlistController.getAllUserPlayList();
    log('number of user\'s playlist: ' + playlists.length.toString());
  }

  Future<void> getAllUserFavSongs() async {
    favorites.value = await _songController.getAllUserFavSongs(_user!.uid);
    log('number of user\'s fav songs: ' + favorites.length.toString());
  }
}
