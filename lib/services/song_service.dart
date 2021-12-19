import 'package:cloud_firestore/cloud_firestore.dart';

class SongService {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getSuggestedPlaylist(String weatherType) async {
    var limitSuggestedSong = 10;
    List<QueryDocumentSnapshot<Map<String, dynamic>>> songs = [];
    await FirebaseFirestore.instance
        .collection('songs')
        .where('suitable_weather', arrayContains: weatherType)
        .get()
        .then((value) {
      songs = value.docs;
      songs.shuffle();
      songs = songs.sublist(0, limitSuggestedSong);
    });

    return songs;
  }
}
