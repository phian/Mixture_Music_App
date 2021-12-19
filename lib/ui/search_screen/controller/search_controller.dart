import 'package:get/get.dart';
import 'package:mixture_music_app/models/song/song_model.dart';
import 'package:mixture_music_app/repos/song_repo.dart';

class SearchController extends GetxController {
  RxList<String> listRecentSearch = <String>[].obs;
  final SongRepo _songRepo = const SongRepo();
  RxList<SongModel> songs = <SongModel>[].obs;
  RxList<SongModel> searchSongs = <SongModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    listRecentSearch.value = await _songRepo.getRecentSearch() ?? [];
  }

  int limitLengthRecentSearch() {
    return listRecentSearch.length > 6 ? 6 : listRecentSearch.length;
  }

  void saveRecentSearchToHive() async {
    await _songRepo.saveRecentSearch(listRecentSearch);
  }

  void addSearch(String search) {
    if (listRecentSearch.length >= 6) {
      listRecentSearch.removeAt(0);
    }
    if (listRecentSearch.contains(search) == false) {
      listRecentSearch.add(search);
    }
  }

  void removeSearch(int index) {
    listRecentSearch.removeAt(index);
  }

  void getAllSongs() async {
    resetSearchSongs();
    songs.value = await _songRepo.getAllSongs();
  }

  void getSongsByKeyword({required String keyword}) {
    searchSongs.value = List.from(songs.where((p0) => p0.data.title.contains(keyword)));
  }

  void resetSearchSongs() {
    searchSongs.value = [];
  }
}
