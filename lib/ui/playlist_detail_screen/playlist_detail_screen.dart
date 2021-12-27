import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/controllers/playlist_controller.dart';
import 'package:mixture_music_app/controllers/user_data_controller.dart';
import 'package:mixture_music_app/models/playlist/playlist.dart';
import 'package:mixture_music_app/ui/player_screen/controller/music_player_controller.dart';
import 'package:mixture_music_app/ui/playlist_detail_screen/widgets/add_song_sheet.dart';
import 'package:mixture_music_app/ui/playlist_detail_screen/widgets/delete_dialog.dart';
import 'package:mixture_music_app/ui/playlist_detail_screen/widgets/edit_playlist_sheet.dart';
import 'package:mixture_music_app/ui/playlist_detail_screen/widgets/share_dialog.dart';
import 'package:mixture_music_app/ui/test_audio_screen/service/audio_player_handler.dart';
import 'package:mixture_music_app/widgets/base_app_bar.dart';
import 'package:mixture_music_app/widgets/bottom_sheet_wrapper.dart';
import 'package:mixture_music_app/widgets/image_grid_widget.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';
import 'package:mixture_music_app/widgets/song_tile.dart';

class PlayListDetailScreen extends StatefulWidget {
  const PlayListDetailScreen({Key? key}) : super(key: key);

  @override
  _PlayListDetailScreenState createState() => _PlayListDetailScreenState();
}

class _PlayListDetailScreenState extends State<PlayListDetailScreen> {
  final List<IconData> _actionIcons = [Icons.add, Icons.edit, Icons.share, Icons.delete];
  final List<String> _menuTexts = ['Add tracks', 'Edit playlist', 'Share playlist', 'Delete playlist'];
  late Playlist _playlist;

  final DateFormat formatter = DateFormat('MMM dd, yyyy');
  final _userDataController = Get.find<UserDataController>();
  final _playlistController = PlaylistController();
  final _musicPlayerController = Get.find<MusicPlayerController>();

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      _playlist = Get.arguments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BaseAppBar(
        backgroundColor: Colors.transparent,
        leading: InkWellWrapper(
          onTap: () {
            Get.back();
          },
          borderRadius: BorderRadius.circular(90.0),
          child: Container(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(Icons.arrow_back_ios, color: Theme.of(context).iconTheme.color),
          ),
        ),
        actions: [
          InkWellWrapper(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (_) {
                    return BottomSheetWrapper(
                      contentItems: [
                        ...List.generate(
                          _menuTexts.length,
                              (index) => InkWellWrapper(
                            onTap: () {
                              Get.back();
                              _openMenuSection(index);
                            },
                            borderRadius: BorderRadius.zero,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 24.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: index == 0
                                    ? Border.symmetric(
                                        horizontal: BorderSide(color: Theme.of(context).dividerColor, width: 1.5),
                                      )
                                    : Border(bottom: BorderSide(color: Theme.of(context).dividerColor, width: 1.5)),
                              ),
                              child: Text(
                                _menuTexts[index],
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.caption?.copyWith(
                                      fontSize: 18.0,
                                    ),
                              ),
                            ),
                          ),
                        )
                      ],
                      dividerThickness: 0.0,
                      bottomSheetRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                    );
                  });
            },
            borderRadius: BorderRadius.circular(90.0),
            child: Container(
              width: kToolbarHeight,
              height: kToolbarHeight,
              alignment: Alignment.center,
              child: Icon(
                Icons.keyboard_control,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.15),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageGridWidget(
                imageUrls: _playlist.songs.map((e) => e.data.imgURL).toList(),
                gridRadius: BorderRadius.circular(4.0),
              ),
              const SizedBox(height: 32.0),
              Text(
                _playlist.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Created ' + formatter.format(_playlist.createdTime.toDate()) + ' - ${_playlist.songs.length} tracks',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 20.0, color: AppColors.c7A7C81),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _actionIcons.length,
                      (index) => Padding(
                    padding: EdgeInsets.only(left: index == 0 ? 0.0 : 16.0),
                    child: InkWellWrapper(
                      onTap: () {
                        _openMenuSection(index);
                      },
                      borderRadius: BorderRadius.circular(90.0),
                      color: Theme.of(context).primaryColor.withOpacity(0.15),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(_actionIcons[index], size: 25.0, color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48.0),
              IntrinsicWidth(
                child: InkWellWrapper(
                  onTap: () async {
                    if (listEquals(_userDataController.currentPlaylist, _playlist.songs) == false) {
                      _initAudioSource();
                    }

                    await audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
                    _musicPlayerController.isShuffle.value = true;
                    if (listEquals(_musicPlayerController.shuffleList, audioHandler.player.shuffleIndices) == false) {
                      _musicPlayerController.shuffleList.value = List.from(audioHandler.player.shuffleIndices ?? []);
                    }

                    Random rand = Random();
                    var index = rand.nextInt(_musicPlayerController.shuffleList.length - 1);
                    await audioHandler.skipToQueueItem(index);
                    audioHandler.play();

                    _musicPlayerController.playingSong.value = _playlist.songs[_musicPlayerController.shuffleList[index]];
                  },
                  borderRadius: BorderRadius.circular(4.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.shuffle),
                        SizedBox(width: 16.0),
                        Text('Shuffle Play'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...List.generate(
                    _playlist.songs.length,
                        (index) => Obx(
                          () => SongTile(
                        songModel: _playlist.songs[index],
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        isPlaying: _musicPlayerController.playingSong.value != null
                            ? _musicPlayerController.playingSong.value!.id == _playlist.songs[index].id
                                ? true
                                : false
                            : false,
                        onTap: () {
                          _initAudioSource(index: index);
                          _updatePlayingItem(index);
                        },
                        isFavorite: _userDataController.favorites.contains(_playlist.songs[index]),
                      ),
                    ),
                  ),
                  const SizedBox(height: kBottomNavigationBarHeight + 32.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openMenuSection(int index) {
    switch (index) {
      case 0:
        showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (_) {
              return AddSongSheet(
                playlist: _playlist,
                sheetHeight: MediaQuery.of(context).size.height * 0.9,
                sheetRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                onAddingSongs: (song) {
                  setState(() {
                    _playlist.songs.add(song);
                    _playlistController.updatePlaylist(_playlist);
                  });
                },
              );
            });
        break;
      case 1:
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (_) {
            return EditPlaylistSheet(
              playlist: _playlist,
              sheetHeight: MediaQuery.of(context).size.height * 0.9,
              onDeleteSongButtonTap: (listSong) {
                setState(() {
                  _playlist.songs = listSong;
                });
              },
            );
          },
        );
        break;
      case 2:
        Get.dialog(
          ShareDialog(
            playlistId: 'PlaylistId',
            playListName: 'Playlist name',
            contentPadding: const EdgeInsets.all(16.0),
            playlistNameStyle: Theme.of(context).textTheme.headline5?.copyWith(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
            titleStyle: Theme.of(context).textTheme.headline5?.copyWith(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
            subtitleStyle: Theme.of(context).textTheme.caption?.copyWith(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
            ),
          ),
        );
        break;
      case 3:
        Get.dialog(
          DeleteDialog(
            onCancelButtonTap: () {
              Get.back();
            },
            onDeleteButtonTap: () async {
              await _playlistController.deletePlaylist(_playlist);
              _userDataController.getAllUserPlaylists();
              Get.back();
              Get.back();
            },
          ),
        );
        break;
    }
  }

  void _updatePlayingItem(int index) async {
    if (_musicPlayerController.playingSong.value?.id != _playlist.songs[index].id) {
      audioHandler.skipToQueueItem(index);
      audioHandler.play();

      _musicPlayerController.setSong(
        _playlist.songs[index],
      );
      _userDataController.getAllUserRecents();

      if (audioHandler.player.shuffleModeEnabled) {
        _musicPlayerController.currentShuffleIndex.value = audioHandler.player.shuffleIndices!.indexWhere((element) => element == index);
        _musicPlayerController.shuffleList.value = List.from(audioHandler.player.shuffleIndices ?? []);
      }
    } else {
      _checkPlayerState();
    }
  }

  void _initAudioSource({int? index}) {
    audioHandler.initAudioSource(_playlist.songs, index: index);
    _userDataController.currentPlaylistType.value = 'playlist';
    _userDataController.currentPlaylist.value = List.from(_playlist.songs);
  }

  void _checkPlayerState() {
    if (audioHandler.player.playing == false) {
      audioHandler.play();
    } else {
      audioHandler.pause();
    }
  }
}
