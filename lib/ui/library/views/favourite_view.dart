import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/constants/enums/enums.dart';
import 'package:mixture_music_app/controllers/user_data_controller.dart';
import 'package:mixture_music_app/images/app_images.dart';
import 'package:mixture_music_app/ui/library/widgets/library_grid_view_card.dart';
import 'package:mixture_music_app/ui/library/widgets/shuffle_and_swap_view.dart';
import 'package:mixture_music_app/ui/player_screen/controller/music_player_controller.dart';
import 'package:mixture_music_app/widgets/song_tile.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({Key? key}) : super(key: key);

  @override
  _FavouriteViewState createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  ViewType _viewType = ViewType.list;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ShuffleAndSwapView(
            onShuffleTap: () {},
            onSwapViewTap: (viewType) {
              setState(() {
                _viewType = viewType;
              });
            },
            visibleSwapViewIcon: true,
          ),
        ),
        AnimatedCrossFade(
          firstChild: const _LibraryListView(),
          secondChild: const _LibraryGridView(),
          crossFadeState:
              _viewType == ViewType.list ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}

class _LibraryListView extends StatefulWidget {
  const _LibraryListView({Key? key}) : super(key: key);

  @override
  State<_LibraryListView> createState() => _LibraryListViewState();
}

class _LibraryListViewState extends State<_LibraryListView> {
  final _userDataController = Get.put(UserDataController());
  final _musicController = Get.put(MusicPlayerController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Align(
        alignment: Alignment.topCenter,
        child: _userDataController.favorites.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    Image.asset(
                      AppImages.playlist,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.width * 0.3,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'You have no favorites',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _userDataController.favorites.length,
                itemBuilder: (context, index) {
                  return SongTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 32,
                    ),
                    songModel: _userDataController.favorites[index],
                    isPlaying: _musicController.playingSong.value != null
                        ? _musicController.playingSong.value!.id ==
                                _userDataController.favorites[index].id
                            ? true
                            : false
                        : false,
                    onTap: () async {
                      _musicController.setSong(
                        _userDataController.favorites[index],
                      );
                    },
                    isFavorite: _userDataController.favorites.contains(
                      _userDataController.favorites[index],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  thickness: 0.5,
                ),
              ),
      ),
    );
  }
}

class _LibraryGridView extends StatefulWidget {
  const _LibraryGridView({Key? key}) : super(key: key);

  @override
  State<_LibraryGridView> createState() => _LibraryGridViewState();
}

class _LibraryGridViewState extends State<_LibraryGridView> {
  final _userDataController = Get.put(UserDataController());
  final _musicController = Get.put(MusicPlayerController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Align(
        alignment: Alignment.topCenter,
        child: _userDataController.favorites.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    Image.asset(
                      AppImages.playlist,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.width * 0.3,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'You have no favorites',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    spacing: 24.0,
                    runSpacing: 8.0,
                    children: [
                      ...List.generate(
                        _userDataController.favorites.length,
                        (index) => Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          child: LibraryGridViewCard(
                            songModel: _userDataController.favorites[index],
                            onTap: () {
                              _musicController.setSong(
                                _userDataController.favorites[index],
                              );
                            },
                            imageRadius: BorderRadius.circular(16.0),
                            isPlaying: _musicController.playingSong.value != null
                                ? _musicController.playingSong.value!.id ==
                                        _userDataController.favorites[index].id
                                    ? true
                                    : false
                                : false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
