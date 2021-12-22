import 'package:mixture_music_app/models/playlist/playlist.dart';
import 'package:mixture_music_app/models/song/song_data.dart';
import 'package:mixture_music_app/models/song/song_model.dart';
import 'package:mixture_music_app/services/playlist_service.dart';

class PlaylistRepo {
  final _playlistService = PlaylistService();

  Future<List<Playlist>> getAllUserPlayList() async {
    var playlists = <Playlist>[];
    await _playlistService.getAllUserPlayList().then((value) {
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

  Future<List<Playlist>> getUserPlaylists(String userId) async {
    List<Playlist> playlists = [];

    var result = await _playlistService.getUserPlaylists(userId);
    print('docs length: ${result.docs.length}');
    if (result.docs.isNotEmpty) {
      for (int i = 0; i < result.docs.length; i++) {
        var data = result.docs[i].data();
        List<Map<String, dynamic>> songs = List.from(data['songs']);

        print('songs: ${songs.length}');

        playlists.add(
          Playlist(
            createdTime: data['created_time'],
            title: data['title'],
            songs: songs.map((e) => SongModel(data: SongData.fromMap(e['data']), id: e['id'])).toList(),
          ),
        );
      }
    }

    return playlists;
  }
}
