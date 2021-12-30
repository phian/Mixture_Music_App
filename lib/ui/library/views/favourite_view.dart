import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/constants/enums/enums.dart';
import 'package:mixture_music_app/controllers/user_data_controller.dart';
import 'package:mixture_music_app/images/app_images.dart';
import 'package:mixture_music_app/ui/library/widgets/library_grid_view_card.dart';
import 'package:mixture_music_app/ui/library/widgets/shuffle_and_swap_view.dart';
import 'package:mixture_music_app/ui/player_screen/controller/music_player_controller.dart';
import 'package:mixture_music_app/ui/test_audio_screen/service/audio_player_handler.dart';
import 'package:mixture_music_app/widgets/song_tile.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({Key? key}) : super(key: key);

  @override
  _FavouriteViewState createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  ViewType _viewType = ViewType.list;
  final _userDataController = Get.put(UserDataController());
  final _musicController = Get.put(MusicPlayerController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Obx(
            () => ShuffleAndSwapView(
              onShuffleTap: () {},
              onSwapViewTap: _userDataController.favorites.isEmpty
                  ? null
                  : (viewType) {
                      setState(() {
                        _viewType = viewType;
                      });
                    },
              visibleSwapViewIcon: true,
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: _LibraryListView(musicController: _musicController, userDataController: _userDataController),
          secondChild: _LibraryGridView(musicController: _musicController, userDataController: _userDataController),
          crossFadeState: _viewType == ViewType.list ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}

class _LibraryListView extends StatefulWidget {
  const _LibraryListView({
    Key? key,
    required this.musicController,
    required this.userDataController,
  }) : super(key: key);

  final MusicPlayerController musicController;
  final UserDataController userDataController;

  @override
  State<_LibraryListView> createState() => _LibraryListViewState();
}

class _LibraryListViewState extends State<_LibraryListView> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Align(
        alignment: Alignment.topCenter,
        child: widget.userDataController.favorites.isEmpty
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
                      'You have no favorite songs',
                      style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.userDataController.favorites.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => SongTile(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 32,
                      ),
                      songModel: widget.userDataController.favorites[index],
                      isPlaying: widget.musicController.playingSong.value != null
                          ? widget.musicController.playingSong.value!.id == widget.userDataController.favorites[index].id
                              ? true
                              : false
                          : false,
                      onTap: () async {
                        widget.userDataController.setCurrentPlaylistType('favourite');
                        _initAudioSource(index: index);
                        if (widget.musicController.indexList.isEmpty) {
                          for (int i = 0; i < widget.userDataController.currentPlaylist.length; i++) {
                            widget.musicController.indexList.add(i);
                          }
                        }
                        _updatePlayingItem(index);
                      },
                      isFavorite: widget.userDataController.favorites.contains(
                        widget.userDataController.favorites[index],
                      ),
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

  void _updatePlayingItem(int index) async {
    if (widget.musicController.playingSong.value?.id != widget.userDataController.favorites[index].id) {
      audioHandler.skipToQueueItem(index);
      audioHandler.play();

      widget.musicController.indexIndexList.value = index;

      widget.musicController.setSong(
        widget.userDataController.favorites[index],
      );

      widget.userDataController.getAllUserRecents();
    } else {
      _checkPlayerState();
    }
  }

  void _initAudioSource({int? index}) {
    audioHandler.initAudioSource(widget.userDataController.favorites, index: index);
    widget.userDataController.currentPlaylistType.value = 'favourite';
    widget.userDataController.currentPlaylist.value = List.from(widget.userDataController.favorites);
  }

  void _checkPlayerState() {
    if (audioHandler.player.playing == false) {
      audioHandler.play();
    } else {
      audioHandler.pause();
    }
  }
}

class _LibraryGridView extends StatefulWidget {
  const _LibraryGridView({
    Key? key,
    required this.musicController,
    required this.userDataController,
  }) : super(key: key);

  final MusicPlayerController musicController;
  final UserDataController userDataController;

  @override
  State<_LibraryGridView> createState() => _LibraryGridViewState();
}

class _LibraryGridViewState extends State<_LibraryGridView> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Align(
        alignment: Alignment.topCenter,
        child: widget.userDataController.favorites.isEmpty
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
                      'You have no favorite songs',
                      style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400),
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
                        widget.userDataController.favorites.length,
                        (index) => Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          child: LibraryGridViewCard(
                            songModel: widget.userDataController.favorites[index],
                            onTap: () {
                              _initAudioSource(index: index);
                              widget.userDataController.setCurrentPlaylistType('favourite');
                              if (widget.musicController.indexList.isEmpty) {
                                for (int i = 0; i < widget.userDataController.currentPlaylist.length; i++) {
                                  widget.musicController.indexList.add(i);
                                }
                              }
                              _updatePlayingItem(index);
                            },
                            imageRadius: BorderRadius.circular(16.0),
                            isPlaying: widget.musicController.playingSong.value != null
                                ? widget.musicController.playingSong.value!.id == widget.userDataController.favorites[index].id
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

  void _updatePlayingItem(int index) async {
    if (widget.musicController.playingSong.value?.id != widget.userDataController.favorites[index].id) {
      audioHandler.skipToQueueItem(index);
      audioHandler.play();

      widget.musicController.indexIndexList.value = index;

      widget.musicController.setSong(
        widget.userDataController.favorites[index],
      );
      widget.userDataController.getAllUserRecents();

      widget.musicController.playingSong.value = widget.userDataController.favorites[index];
    } else {
      _checkPlayerState();
    }
  }

  void _initAudioSource({int? index}) {
    audioHandler.initAudioSource(widget.userDataController.favorites, index: index);
    widget.userDataController.currentPlaylistType.value = 'favourite';
    widget.userDataController.currentPlaylist.value = List.from(widget.userDataController.favorites);
  }

  void _checkPlayerState() {
    if (audioHandler.player.playing == false) {
      audioHandler.play();
    } else {
      audioHandler.pause();
    }
  }
}
