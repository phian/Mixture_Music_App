import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/ui/player_screen/controller/music_player_controller.dart';
import 'package:mixture_music_app/ui/search_screen/controller/search_controller.dart';

class RealSearchScreen extends StatelessWidget {
  RealSearchScreen({
    Key? key,
    this.searchKeyWord,
  }) : super(key: key);

  final String? searchKeyWord;
  final TextEditingController searchController = TextEditingController();
  final musicPlayerController = Get.put(MusicPlayerController());
  final controller = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    searchController.text = searchKeyWord ?? '';
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      autofocus: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            searchController.text = '';
                          },
                          child: const Icon(Icons.clear),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: theme.colorScheme.brightness == Brightness.light
                            ? Colors.grey[200]
                            : Colors.white24,
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          controller.addSearch(value);
                          controller.saveRecentSearchToHive();
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: Text(
                      'Cancle',
                      style: theme.textTheme.bodyText2!.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Expanded(
              //   child: ListView.separated(
              //     itemCount: listSong.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return SongTile(
              //         songModel: listSong[index],
              //         onTap: () {
              //           musicPlayerController.setSong(listSong[index]);
              //           Get.back();
              //         },
              //       );
              //     },
              //     separatorBuilder: (BuildContext context, int index) {
              //       return const Divider();
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
