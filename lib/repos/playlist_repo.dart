import 'package:mixture_music_app/models/playlist/playlist.dart';
import 'package:mixture_music_app/services/playlist_service.dart';
import 'package:mixture_music_app/services/share_preference_service.dart';

class PlaylistRepo {
  final _playlistService = PlaylistService();
  final _sharePrefService = SharePrefService();

  Future<List<Playlist>> getAllUserPlayList(String uid) async {
    var playlists = <Playlist>[];
    await _playlistService.getAllUserPlayList(uid).then((value) {
      for (var playlist in value) {
        playlists.add(Playlist.fromSnapshot(playlist));
      }
    });
    return playlists;
  }

  Future<void> createPlaylist(Playlist playlist) async {
    await _playlistService.createPlaylist(playlist);
  }

  Future<void> updatePlaylist(Playlist playlist) async {
    await _playlistService.updatePlaylist(playlist);
  }

  Future<void> deletePlaylist(Playlist playlist) async {
    await _playlistService.deletePlaylist(playlist);
  }

  Future<void> saveLocalShuffleList(List<int> shuffleList) async {
    return await _sharePrefService.saveShuffleList(shuffleList);
  }

  Future<List<int>?> getLocalShuffleList() async {
    return await _sharePrefService.getShuffleList();
  }

  Future<int> clearLocalShuffleList() async {
    return await _sharePrefService.clearShuffleList();
  }
}
