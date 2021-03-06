import 'package:mixture_music_app/models/song/song_model.dart';
import 'package:mixture_music_app/repos/song_repo.dart';

class SongController {
  final _songRepo = SongRepo();

  Future<List<SongModel>> getSuggestedSongs(String weatherType) async {
    return await _songRepo.getSuggestedSongs(weatherType);
  }

  Future<List<SongModel>> getAllUserFavSongs(String uid) async {
    return _songRepo.getAllUserFavSongs(uid);
  }

  Future<void> addSongToFav(String uid, SongModel song) async {
    return await _songRepo.addSongToFav(uid, song);
  }

  Future<void> removeSongFromFav(String uid, SongModel song) async {
    return await _songRepo.removeSongFromFav(uid, song);
  }

  Future<void> addSongToRecents(String uid, SongModel song) async {
    return await _songRepo.addSongToRecents(uid, song);
  }

  Future<List<SongModel>> getAllUserRecents(String uid) async {
    return await _songRepo.getAllUserRecents(uid);
  }
}
