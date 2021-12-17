import 'package:get/get.dart';
import '../../../models/song/song_model.dart';

class MusicPlayerController extends GetxController {
  var playingSong = Rxn<SongModel>();
  

  void setSong(SongModel songModel) {
    playingSong.value = songModel;
  }
}
