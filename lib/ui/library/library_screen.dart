import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/routing/routes.dart';
import 'package:mixture_music_app/ui/library/views/artists_view.dart';
import 'package:mixture_music_app/ui/library/views/favourite_view.dart';
import 'package:mixture_music_app/ui/library/views/mix_music_view.dart';
import 'package:mixture_music_app/ui/library/views/recent_activity_view.dart';
import 'package:mixture_music_app/ui/test_audio_screen/test_audio_screen.dart';
import 'package:mixture_music_app/widgets/fade_indexed_stack.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_text_style.dart';
import '../../constants/enums/enums.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  ViewType _favouriteViewType = ViewType.list;
  ViewType _artistViewType = ViewType.list;
  ViewType _initSwapViewType = ViewType.list;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: libraryTitle.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const TestAudioScreen());
        },
      ),
      body: SingleChildScrollView(
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
                          style: AppTextStyles.lightTextTheme.headline4?.copyWith(
                            fontSize: 30.0,
                            color: AppColors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.playlistDetailScreen);
                          },
                          icon: const Icon(Icons.add, size: 30.0),
                          tooltip: 'Add',
                        )
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

                            if (_selectedIndex == 0) {
                              _initSwapViewType = _favouriteViewType;
                            } else if (_selectedIndex == 2) {
                              _initSwapViewType = _artistViewType;
                            }
                          });
                        },
                        isScrollable: true,
                        indicatorColor: Theme.of(context).primaryColor,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 3.0,
                        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                        tabs: List.generate(
                          libraryTitle.length,
                              (index) => Tab(
                            icon: Text(
                              libraryTitle[index],
                              style: AppTextStyles.lightTextTheme.subtitle1?.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
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
                  FavouriteView(libraries: libraryExampleModels),
                  const MixMusicView(),
                  ArtistsView(onArtistTap: (artist) {}, artists: artistModels),
                  const Padding(
                    child: RecentActivityView(),
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
