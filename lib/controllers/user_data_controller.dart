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
  var recents = <SongModel>[].obs;
  var currentPlaylistType = ''.obs;
  var currentPlaylist = <SongModel>[].obs;

  final _playlistController = PlaylistController();
  final _songController = SongController();
  final _user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() async {
    super.onInit();
    await getAllUserPlaylists();
    await getAllUserFavSongs();
    await getAllUserRecents();
  }

  Future<void> getAllUserPlaylists() async {
    if (_user != null) {
      playlists.value = await _playlistController.getAllUserPlayList(_user!.uid);
      log('number of user\'s playlist: ' + playlists.length.toString());
    }
  }

  Future<void> getAllUserFavSongs() async {
    if (_user != null) {
      favorites.value = await _songController.getAllUserFavSongs(_user!.uid);
      log('number of user\'s favorites: ' + favorites.length.toString());
    }
  }

  Future<void> getAllUserRecents() async {
    if (_user != null) {
      recents.value = await _songController.getAllUserRecents(_user!.uid);
      log('number of user\'s recents: ' + recents.length.toString());
    }
  }

  void setCurrentPlaylistType(String playlist) {
    if (currentPlaylistType.value != playlist) {
      currentPlaylistType.value = playlist;
    }
  }
}
