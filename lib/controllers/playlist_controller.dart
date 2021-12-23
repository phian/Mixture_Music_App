import 'package:mixture_music_app/models/playlist/playlist.dart';
import 'package:mixture_music_app/repos/playlist_repo.dart';

class PlaylistController {
  final _playlistRepo = PlaylistRepo();

  Future<List<Playlist>> getAllUserPlayList(String uid) async {
    return await _playlistRepo.getAllUserPlayList(uid);
  }

  Future<void> createPlaylist(Playlist playlist) async {
    await _playlistRepo.createPlaylist(playlist);
  }

  Future<void> updatePlaylist(Playlist playlist) async {
    await _playlistRepo.updatePlaylist(playlist);
  }
}
