import 'package:mixture_music_app/models/song/song_data.dart';
import 'package:mixture_music_app/models/song/song_model.dart';
import 'package:mixture_music_app/services/song_service.dart';

class SongRepo {
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
}
