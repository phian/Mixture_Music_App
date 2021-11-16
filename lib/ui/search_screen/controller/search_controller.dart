import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SearchController extends GetxController {
  RxList<String> listRecentSearch = <String>[].obs;
  late Box<List<String>?> recentSearchBox;

  @override
  void onInit() async {
    super.onInit();
    recentSearchBox = await Hive.openBox<List<String>?>('recentSearch');
    listRecentSearch.value = recentSearchBox.get('listRecentSearch') ?? [];
  }

  int limitLenghtRecentSearch() {
    return listRecentSearch.length > 6 ? 6 : listRecentSearch.length;
  }

  void saveRecentSearchToHive() {
    recentSearchBox.put('listRecentSearch', listRecentSearch);
  }

  void addSearch(String search) {
    if (listRecentSearch.length >= 6) {
      listRecentSearch.removeAt(0);
    }
    listRecentSearch.add(search);
  }

  void removeSearch(int index) {
    listRecentSearch.removeAt(index);
  }
}
