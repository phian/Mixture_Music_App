import 'package:flutter/material.dart';
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

class _LibraryScreenState extends State<LibraryScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  ViewType _viewType = ViewType.list;

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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your Library",
                          style: AppTextStyles.lightTextTheme.headline4?.copyWith(
                            fontSize: 30.0,
                            color: AppColors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.refresh),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: TabBar(
                        controller: _tabController,
                        onTap: (index) {
                          print(index);
                        },
                        isScrollable: true,
                        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
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
                    SizedBox(height: 24.0),
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
              // LibraryGridViewCard(
              //   libraryModel: LibraryModel(
              //     imageUrl: "https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg",
              //     libraryTitle: "Trời hôm nay nhiều mây cực",
              //   ),
              // ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: List.generate(
                    5,
                    (index) => Container(
                      margin: EdgeInsets.only(
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
                        duration: Duration(milliseconds: 300),
                        child: _viewType == ViewType.list
                            ? _LibraryListView(libraries: libraryExampleModels)
                            : _LibraryGridView(
                                libraries: libraryExampleModels,
                              ),
                      ),
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
    return RefreshIndicator(
      onRefresh: () async {},
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(
              libraries.length,
              (index) => Container(
                margin: EdgeInsets.only(top: 16.0),
                child: LibraryListViewCard(
                  libraryModel: libraries[index],
                  onTap: () {},
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
            SizedBox(height: kBottomNavigationBarHeight + 32.0),
          ],
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
    return RefreshIndicator(
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
                    margin: EdgeInsets.only(top: 16.0),
                    child: LibraryGridViewCard(
                      libraryModel: libraries[index],
                      onTap: () {},
                      imageRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: kBottomNavigationBarHeight + 32.0),
          ],
        ),
      ),
    );
  }
}
