import 'package:get/get.dart';
import '../../../models/song_model.dart';

class MusicPlayerController extends GetxController {
  var selectedSong = Rxn<SongModel>();
  

  void setSong(SongModel songModel) {
    selectedSong.value = songModel;
  }
}
