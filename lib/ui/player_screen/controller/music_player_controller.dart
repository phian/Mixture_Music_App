import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/controllers/song_controller.dart';
import 'package:mixture_music_app/models/song/song_model.dart';

class MusicPlayerController extends GetxController {
  var playingSong = Rxn<SongModel>();
  final _songController = SongController();

  RxList<int> indexList = <int>[].obs;

  RxInt indexIndexList = 0.obs;

  RxBool isShuffle = false.obs;

  Future<void> setSong(SongModel songModel) async {
    playingSong.value = songModel;
    await _songController.addSongToRecents(FirebaseAuth.instance.currentUser!.uid, songModel);
  }

  Future<void> addSongToFav() async {
    return await _songController.addSongToFav(
      FirebaseAuth.instance.currentUser!.uid,
      playingSong.value!,
    );
  }

  Future<void> removeSongFromFav() async {
    return await _songController.removeSongFromFav(
      FirebaseAuth.instance.currentUser!.uid,
      playingSong.value!,
    );
  }
}
