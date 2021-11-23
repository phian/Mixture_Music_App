import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/constants/app_constants.dart';
import 'package:mixture_music_app/models/playlist_model.dart';
import 'package:mixture_music_app/ui/playlist_detail_screen/sections/edit_playlist_sheet.dart';
import 'package:mixture_music_app/ui/playlist_detail_screen/widgets/delete_dialog.dart';
import 'package:mixture_music_app/ui/playlist_detail_screen/widgets/share_dialog.dart';
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
                imageUrls: listSong.map((e) => e.coverImageUrl).toList(),
                gridRadius: BorderRadius.circular(4.0),
              ),
              const SizedBox(height: 32.0),
              Text(
                'Playlist name',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Created ${DateTime.now().month} ${DateTime.now().day}, ${DateTime.now().year} - ${listSong.length} tracks',
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
                  onTap: () {},
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
                    listSong.length,
                    (index) => SongTile(
                      songModel: listSong[index],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      onTap: () {},
                      border: index == 0
                          ? const Border.symmetric(
                              horizontal: BorderSide(color: AppColors.c7A7C81),
                            )
                          : const Border(
                              bottom: BorderSide(color: AppColors.c7A7C81),
                            ),
                    ),
                  ),
                  const SizedBox(height: kBottomNavigationBarHeight + 32.0),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _openMenuSection(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (_) {
            return EditPlaylistSheet(
              playlistModel: PlaylistModel(
                playlistName: 'Playlist name',
              ),
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
            playlistNameStyle: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 30.0, fontWeight: FontWeight.bold),
            titleStyle: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        );
        break;
      case 3:
        Get.dialog(
          DeleteDialog(
            onCancelButtonTap: () {
              Get.back();
            },
            onDeleteButtonTap: () {
              Get.back();
            },
          ),
        );
        break;
    }
  }
}
