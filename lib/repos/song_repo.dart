import 'package:mixture_music_app/models/song/song_data.dart';
import 'package:mixture_music_app/models/song/song_model.dart';
import 'package:mixture_music_app/services/share_preference_service.dart';
import 'package:mixture_music_app/services/song_service.dart';

class SongRepo {

  final _sharePrefService = const SharePrefService();
  final _songService = SongService();

  Future<List<SongModel>> getSuggestedPlaylist(String weatherType) async {
    var playlist = <SongModel>[];

    await _songService.getSuggestedPlaylist(weatherType).then((songs) {
      for (var song in songs) {
        playlist.add(
          SongModel(
            data: SongData.fromMap(song.data()),
            id: song.id,
          ),
        );
      }
    });
    return playlist;
  }

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
      songs.add(SongModel(
          id: result.docs[i].id,
          data: SongData.fromMap(result.docs[i].data())));
    }

    return songs;
  }
}
