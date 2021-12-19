import 'package:mixture_music_app/models/song/song_data.dart';
import 'package:mixture_music_app/models/song/song_model.dart';
import 'package:mixture_music_app/services/share_preference_service.dart';
import 'package:mixture_music_app/services/song_service.dart';

class SongRepo {
  const SongRepo();

  final SharePrefService _sharePrefService = const SharePrefService();
  final SongService _songService = const SongService();

  Future<List<String>?> getRecentSearch() async {
    return await _sharePrefService.getRecentSearch();
  }

  Future<void> saveRecentSearch(List<String> recentSearches) async {
    return await _sharePrefService.saveRecentSearch(recentSearches);
  }

  Future<List<SongModel>> getAllSongs() async {
    List<SongModel> songs = [];

    var result = await _songService.getAllSongs();
    for (int i = 0; i < result.docs.length; i++) {
      songs.add(SongModel(id: result.docs[i].id, data: SongData.fromMap(result.docs[i].data())));
    }

    return songs;
  }
}
