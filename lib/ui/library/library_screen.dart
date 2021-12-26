import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mixture_music_app/controllers/user_data_controller.dart';

import 'package:mixture_music_app/ui/library/views/artists_view.dart';
import 'package:mixture_music_app/ui/library/views/favourite_view.dart';
import 'package:mixture_music_app/ui/library/views/mix_music_view.dart';
import 'package:mixture_music_app/ui/library/views/recent_activity_view.dart';
import 'package:mixture_music_app/ui/test_audio_screen/test_audio_screen.dart';
import 'package:mixture_music_app/widgets/fade_indexed_stack.dart';

import '../../constants/app_constants.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  int _selectedIndex = 0;
  final _userDataController = Get.put(UserDataController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: libraryTitle.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const TestAudioScreen());
        },
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _userDataController.getAllUserFavSongs();
          await _userDataController.getAllUserRecents();
          await _userDataController.getAllUserPlaylists();
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16.0,
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your Library',
                            style: theme.textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: TabBar(
                          controller: _tabController,
                          onTap: (index) {
                            setState(() {
                              _selectedIndex = index;
                              _tabController.animateTo(index);
                            });
                          },
                          isScrollable: true,
                          indicatorColor: Theme.of(context).primaryColor,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorWeight: 3.0,
                          physics:
                              const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                          tabs: List.generate(
                            libraryTitle.length,
                            (index) => Tab(
                              icon: Text(
                                libraryTitle[index],
                                style: theme.textTheme.headline6!.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                    ],
                  ),
                ),
                FadeIndexedStack(
                  index: _selectedIndex,
                  children: [
                    const FavouriteView(),
                    Obx(
                      () => PlaylistView(
                        playlists: _userDataController.playlists.value,
                      ),
                    ),
                    ArtistsView(onArtistTap: (artist) {}, artists: artistModels),
                    const RecentActivityView(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
