import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/constants/enums/enums.dart';
import 'package:mixture_music_app/controllers/user_data_controller.dart';
import 'package:mixture_music_app/models/playlist/playlist.dart';
import 'package:mixture_music_app/models/song/song_model.dart';
import 'package:mixture_music_app/ui/playlist_detail_screen/widgets/add_song_card.dart';
import 'package:mixture_music_app/widgets/custom_textfield/config/decoration_config.dart';
import 'package:mixture_music_app/widgets/custom_textfield/config/textfield_config.dart';
import 'package:mixture_music_app/widgets/custom_textfield/custom_textfield.dart';

class AddSongSheet extends StatefulWidget {
  const AddSongSheet({
    Key? key,
    required this.playlist,
    required this.onAddingSongs,
    this.sheetHeight,
    this.sheetRadius,
  }) : super(key: key);

  /// playlist to add songs to
  final Playlist playlist;

  final double? sheetHeight;
  final void Function(SongModel songs) onAddingSongs;
  final BorderRadius? sheetRadius;

  @override
  _AddSongSheetState createState() => _AddSongSheetState();
}

class _AddSongSheetState extends State<AddSongSheet> {
  
  //late final List<SongModel> _songs = widget.songs;
  int _playingIndex = -1;
  final _userDataController = Get.find<UserDataController>();
  late List<SongModel> _favorites;
  late List<SongModel> _recentlyPlayed;

  @override
  void initState() {
    super.initState();
    _favorites = List.from(_userDataController.favorites);
    _favorites.removeWhere((element) => widget.playlist.songs.contains(element));
    _recentlyPlayed = List.from(_userDataController.recents);
    _recentlyPlayed.removeWhere((element) => widget.playlist.songs.contains(element));
  }

  Widget _listSong(List<SongModel> songs, String title) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: AppColors.black12.withOpacity(0.05),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 78.0),
              child: Column(
                children: [
                  ...List.generate(
                    songs.length,
                    (index) => Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      child: AddSongCard(
                        song: songs[index],
                        isPlaying: _playingIndex == index,
                        onAddButtonTap: (song) {
                          setState(() {
                            widget.onAddingSongs.call(song);
                            songs.removeWhere((element) => element.id == song.id);
                            Fluttertoast.showToast(
                              msg: 'Added',
                              fontSize: 18.0,
                              textColor: AppColors.white,
                              backgroundColor: Theme.of(context).primaryColor,
                            );
                          });
                        },
                        onPlayTap: (isPlaying) {
                          if (isPlaying) {
                            setState(() {
                              _playingIndex = index;
                            });
                          }
                        },
                        imageRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.0),
                topLeft: Radius.circular(16.0),
              ),
              color: Colors.grey,
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.sheetHeight,
      decoration: BoxDecoration(
        borderRadius: widget.sheetRadius ?? BorderRadius.zero,
        color: Colors.white,
      ),
      child: Column(
        children: [
          const SizedBox(height: 16.0),
          Text(
            'Add songs',
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 32.0),
            child: CustomTextField(
              textFieldType: TextFieldType.name,
              onChanged: (value) {},
              textFieldConfig: TextFieldConfig(
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(fontSize: 20.0, fontWeight: FontWeight.w500, color: AppColors.black),
              ),
              decorationConfig: TextFieldDecorationConfig(
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                errorBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                filled: true,
                fillColor: AppColors.black12.withOpacity(0.1),
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                hintStyle: Theme.of(context).textTheme.headline5?.copyWith(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: AppColors.subTextColor,
                    ),
              ),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: false,
              aspectRatio: 2.0,
              enlargeCenterPage: false,
              height: MediaQuery.of(context).size.height * 0.65,
              viewportFraction: 1.0,
            ),
            items: [
              _listSong(_favorites, 'Favorites'),
              _listSong(_recentlyPlayed, 'Recently played'),
            ],
          ),
        ],
      ),
    );
  }
}
