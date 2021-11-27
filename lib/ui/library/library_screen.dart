import 'package:flutter/material.dart';
import 'package:mixture_music_app/ui/library/views/mix_music_view.dart';
import 'package:mixture_music_app/widgets/fade_indexed_stack.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_text_style.dart';
import '../../constants/enums/enums.dart';
import '../../models/library_model.dart';
import 'widgets/library_grid_view_card.dart';
import 'widgets/library_list_view_card.dart';
import 'widgets/shuffle_and_swap_view.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  ViewType _viewType = ViewType.list;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: libraryTitle.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          style:
                              AppTextStyles.lightTextTheme.headline4?.copyWith(
                            fontSize: 30.0,
                            color: AppColors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
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
                          print(index);
                          setState(() {
                            _selectedIndex = index;
                            _tabController.animateTo(index);
                          });
                        },
                        isScrollable: true,
                        indicatorColor: Theme.of(context).primaryColor,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 3.0,
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        tabs: List.generate(
                          libraryTitle.length,
                          (index) => Tab(
                            icon: Text(
                              libraryTitle[index],
                              style: AppTextStyles.lightTextTheme.subtitle1
                                  ?.copyWith(
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
                    ShuffleAndSwapView(
                      onShuffleTap: () {},
                      onSwapViewTap: (viewType) {
                        setState(() {
                          _viewType = viewType;
                        });
                      },
                    ),
                  ],
                ),
              ),
              FadeIndexedStack(
                index: _selectedIndex,
                children: List.generate(
                  libraryTitle.length,
                  (index) => index == 1
                      ? const MixMusicView()
                      : Container(
                          margin: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: AnimatedSwitcher(
                            transitionBuilder: (child, anim) {
                              return FadeTransition(
                                opacity: anim,
                                child: ScaleTransition(
                                  scale: anim,
                                  child: child,
                                ),
                              );
                            },
                            duration: const Duration(milliseconds: 300),
                            child: _viewType == ViewType.list
                                ? _LibraryListView(
                                    libraries: libraryExampleModels)
                                : _LibraryGridView(
                                    libraries: libraryExampleModels),
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

class _LibraryListView extends StatelessWidget {
  const _LibraryListView({required this.libraries});

  final List<LibraryModel> libraries;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.generate(
                libraries.length,
                (index) => Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: LibraryListViewCard(
                    libraryModel: libraries[index],
                    onTap: (isPlaying) {},
                    isPlaying: true,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              const SizedBox(height: kBottomNavigationBarHeight + 32.0),
            ],
          ),
        ),
      ),
    );
  }
}

class _LibraryGridView extends StatelessWidget {
  const _LibraryGridView({required this.libraries});

  final List<LibraryModel> libraries;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                spacing: 24.0,
                runSpacing: 8.0,
                children: [
                  ...List.generate(
                    libraries.length,
                    (index) => Container(
                      margin: const EdgeInsets.only(top: 16.0),
                      child: LibraryGridViewCard(
                        libraryModel: libraries[index],
                        onTap: (isPlaying) {},
                        imageRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kBottomNavigationBarHeight + 32.0),
            ],
          ),
        ),
      ),
    );
  }
}
