import 'package:mixture_music_app/models/song/song_model.dart';
import 'package:mixture_music_app/repos/song_repo.dart';

class SongController {
  final _songRepo = SongRepo();

  Future<List<SongModel>> getSuggestedPlaylist(String weatherType) async {
    return await _songRepo.getSuggestedPlaylist(weatherType);
  }
}
