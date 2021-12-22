
import 'package:mixture_music_app/models/playlist/playlist.dart';
import 'package:mixture_music_app/repos/playlist_repo.dart';

class PlaylistController {
  final _playlistRepo = PlaylistRepo();

  Future<List<Playlist>> getAllUserPlayList() async {
    return await _playlistRepo.getAllUserPlayList();
  }

  Future<void> createPlaylist(Playlist playlist) async {
    await _playlistRepo.createPlaylist(playlist);
  }

  Future<void> updatePlaylist(Playlist playlist) async {
    await _playlistRepo.updatePlaylist(playlist);
  }

  Future<List<Playlist>> getUserPlaylists(String userId) async {
    return await _playlistRepo.getUserPlaylists(userId);
  }
}
