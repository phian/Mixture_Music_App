import 'package:get/get.dart';
import 'package:mixture_music_app/models/song/song_model.dart';


class MusicPlayerController extends GetxController {
  var playingSong = Rxn<Song>();
  

  void setSong(Song songModel) {
    playingSong.value = songModel;
  }
}
