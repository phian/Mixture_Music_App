import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/constants/app_constants.dart';
import 'package:mixture_music_app/constants/enums/enums.dart';
import 'package:mixture_music_app/controllers/playlist_controller.dart';
import 'package:mixture_music_app/controllers/user_data_controller.dart';
import 'package:mixture_music_app/models/playlist/playlist.dart';
import 'package:mixture_music_app/models/song/song_model.dart';
import 'package:mixture_music_app/ui/edit_profile_screen/widgets/pick_image_dialog.dart';
import 'package:mixture_music_app/widgets/bottom_sheet_wrapper.dart';
import 'package:mixture_music_app/widgets/custom_textfield/config/decoration_config.dart';
import 'package:mixture_music_app/widgets/custom_textfield/config/textfield_config.dart';
import 'package:mixture_music_app/widgets/custom_textfield/custom_textfield.dart';
import 'package:mixture_music_app/widgets/image_grid_widget.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';
import 'package:mixture_music_app/widgets/song_tile.dart';
import 'package:mixture_music_app/widgets/unfocus_widget.dart';

class EditPlaylistSheet extends StatefulWidget {
  const EditPlaylistSheet({
    Key? key,
    required this.playlist,
    this.onDeleteSongButtonTap,
    this.onChanged,
    this.sheetHeight,
  }) : super(key: key);

  final Playlist playlist;
  final void Function(List<SongModel> deleteSongs)? onDeleteSongButtonTap;
  final void Function(List<SongModel> songs)? onChanged;
  final double? sheetHeight;

  @override
  _EditPlaylistSheetState createState() => _EditPlaylistSheetState();
}

class _EditPlaylistSheetState extends State<EditPlaylistSheet> {
  final List<SongModel> _selectedSong = [];

  late final _playlist = widget.playlist;
  late final TextEditingController _playlistNameController =
      TextEditingController(text: widget.playlist.title);
  final List<String> _sortTypes = [
    'Alphabetical',
    'Custom',
    'Data Added (Newest)',
    'Date Added Oldest'
  ];
  String _selectedSortType = 'Sorting';
  final _playlistController = PlaylistController();

  Future<XFile?> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final result = await picker.pickImage(source: source);

    return result;
  }

  final _userDataController = Get.find<UserDataController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.sheetHeight,
      child: UnFocusWidget(
        child: Stack(
          children: [
            BottomSheetWrapper(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    InkWellWrapper(
                      borderRadius: BorderRadius.circular(4.0),
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Cancel',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                fontSize: 16.0,
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Edit Playlist',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    InkWellWrapper(
                      borderRadius: BorderRadius.circular(4.0),
                      onTap: () {
                        if (primaryFocus != null) {
                          primaryFocus!.unfocus();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Save',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                fontSize: 16.0,
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              contentItems: [
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 48.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Theme.of(context).dividerColor)),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      print('Tapped');
                      Get.dialog(
                        Dialog(
                          child: PickImageDialog(
                            onCameraTap: () {
                              _pickImage(ImageSource.camera);
                              Get.back();
                            },
                            onGalleryTap: () {
                              _pickImage(ImageSource.gallery);
                              Get.back();
                            },
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        barrierColor: Colors.transparent,
                      );
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ImageGridWidget(
                          imageUrls: _playlist.songs.map((e) => e.data.imgURL).toList(),
                          gridRadius: BorderRadius.circular(4.0),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(Icons.edit_outlined, color: Colors.white, size: 40.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1.5),
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                CustomTextField(
                  textFieldType: TextFieldType.name,
                  onChanged: (value) {},
                  textFieldConfig: TextFieldConfig(
                    controller: _playlistNameController,
                    textAlign: TextAlign.center,
                  ),
                  decorationConfig: const TextFieldDecorationConfig(
                    prefixIcon: Icon(Icons.edit_outlined),
                    hintText: 'Enter your playlist name',
                    enabledBorder: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(),
                    border: UnderlineInputBorder(),
                    errorBorder: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 32.0),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Theme.of(context).dividerColor)),
                  ),
                  child: const SizedBox(),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  child: IntrinsicWidth(
                    child: InkWellWrapper(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (_) {
                            return BottomSheetWrapper(
                              contentItems: [
                                ...List.generate(
                                  _sortTypes.length,
                                  (index) => InkWellWrapper(
                                    onTap: () {
                                      setState(() {
                                        _selectedSortType = _sortTypes[index];
                                      });
                                    },
                                    borderRadius: BorderRadius.zero,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        border: index == 0
                                            ? Border.symmetric(
                                                horizontal: BorderSide(
                                                    color: Theme.of(context).dividerColor,
                                                    width: 1.5),
                                              )
                                            : Border(
                                                bottom: BorderSide(
                                                    color: Theme.of(context).dividerColor,
                                                    width: 1.5)),
                                      ),
                                      child: Text(
                                        _sortTypes[index],
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
                              bottomSheetRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                            );
                          },
                        );
                      },
                      borderRadius: BorderRadius.circular(4.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.swap_vert),
                            const SizedBox(width: 16.0),
                            Text(
                              _selectedSortType,
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                    fontSize: 16.0,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    border: Border.symmetric(
                        horizontal: BorderSide(color: Theme.of(context).dividerColor)),
                  ),
                  child: const SizedBox(),
                ),
                const SizedBox(height: 8.0),
                ReorderableListView(
                  shrinkWrap: true,
                  dragStartBehavior: DragStartBehavior.start,
                  physics: const ClampingScrollPhysics(),
                  children: <Widget>[
                    ...List.generate(
                      _playlist.songs.length,
                      (index) => SongTile(
                        key: UniqueKey(),
                        onCheckChanged: (value) {
                          print(value);
                          if (value != null &&
                              value == true &&
                              _selectedSong.contains(_playlist.songs[index]) == false) {
                            setState(() {
                              _selectedSong.add(_playlist.songs[index]);
                            });
                          } else {
                            setState(() {
                              _selectedSong.removeWhere(
                                  (element) => element.id == _playlist.songs[index].id);
                            });
                          }
                        },
                        canChoose: true,
                        canMove: true,
                        initialCheck: _selectedSong.contains(_playlist.songs[index]),
                        songModel: _playlist.songs[index],
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        onTap: () {},
                        border: index == 0
                            ? const Border.symmetric(
                                horizontal: BorderSide(color: AppColors.c7A7C81),
                              )
                            : const Border(
                                bottom: BorderSide(color: AppColors.c7A7C81),
                              ),
                      ),
                    )
                  ],
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      _playlist.songs.insert(newIndex, _playlist.songs.removeAt(oldIndex));
                    });
                  },
                ),
                const SizedBox(height: 32.0),
              ],
              titlePadding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Visibility(
                visible: _selectedSong.isNotEmpty,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: InkWellWrapper(
                        color: Theme.of(context).primaryColor,
                        onTap: () {
                          setState(() {
                            _playlist.songs.removeWhere(
                              ((element) => _selectedSong.contains(element)),
                            );
                            _selectedSong.clear();
                          });
                          _playlistController.updatePlaylist(_playlist);
                          _userDataController.getAllUserPlaylists();
                          widget.onDeleteSongButtonTap?.call(_playlist.songs);
                        },
                        borderRadius: BorderRadius.circular(4.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Delete ${_selectedSong.length} tracks',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
