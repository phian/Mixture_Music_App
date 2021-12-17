import 'dart:developer';

import 'package:get/get.dart';
import 'package:mixture_music_app/controllers/playlist_controller.dart';
import 'package:mixture_music_app/models/playlist/playlist.dart';

class UserDataController extends GetxController {
  var playlists = <Playlist>[].obs;
  final _playlistController = PlaylistController();

  @override
  void onInit() async {
    super.onInit();
    await getAllUserPlaylists();
  }

  Future<void> getAllUserPlaylists() async {
    playlists.value = await _playlistController.getAllUserPlayList();
    log('number of user\'s playlist: ' + playlists.length.toString());
  }
}
