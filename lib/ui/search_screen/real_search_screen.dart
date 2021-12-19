import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/ui/player_screen/controller/music_player_controller.dart';
import 'package:mixture_music_app/ui/search_screen/controller/search_controller.dart';

class RealSearchScreen extends StatefulWidget {
  const RealSearchScreen({
    Key? key,
    this.searchKeyWord,
  }) : super(key: key);

  final String? searchKeyWord;

  @override
  State<RealSearchScreen> createState() => _RealSearchScreenState();
}

class _RealSearchScreenState extends State<RealSearchScreen> {
  final TextEditingController searchController = TextEditingController();
  final musicPlayerController = Get.put(MusicPlayerController());
  final controller = Get.put(SearchController());

  @override
  void initState() {
    super.initState();
    searchController.text = widget.searchKeyWord ?? '';
    controller.getAllSongs();
  }

  @override
  Widget build(BuildContext context) {
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
                          onTap: () async {
                            searchController.text = '';
                            await Future.delayed(const Duration(milliseconds: 500));
                            controller.resetSearchSongs();
                          },
                          child: const Icon(Icons.clear),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: theme.colorScheme.brightness == Brightness.light ? Colors.grey[200] : Colors.white24,
                      ),
                      onChanged: (value) async {
                        await Future.delayed(const Duration(milliseconds: 500));
                        if (value.isEmpty) {
                          controller.resetSearchSongs();
                        } else {
                          controller.getSongsByKeyword(keyword: value);
                        }
                      },
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
                      'Cancel',
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
              Expanded(
                child: Obx(
                  () => RefreshIndicator(
                    onRefresh: () async {
                      searchController.text = '';
                      controller.resetSearchSongs();
                    },
                    child: ListView.separated(
                      itemCount: controller.searchSongs.isEmpty ? controller.songs.length : controller.searchSongs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SongTile(
                          songModel: controller.searchSongs.isEmpty ? controller.songs[index] : controller.searchSongs[index],
                          onTap: () {
                            musicPlayerController.setSong(
                              controller.searchSongs.isEmpty ? controller.songs[index] : controller.searchSongs[index],
                            );
                            Get.back();
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
