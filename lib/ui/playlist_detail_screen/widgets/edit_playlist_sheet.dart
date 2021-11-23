import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/constants/app_constants.dart';
import 'package:mixture_music_app/constants/enums/enums.dart';
import 'package:mixture_music_app/models/playlist_model.dart';
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
  const EditPlaylistSheet({Key? key, required this.playlistModel}) : super(key: key);

  final PlaylistModel playlistModel;

  @override
  _EditPlaylistSheetState createState() => _EditPlaylistSheetState();
}

class _EditPlaylistSheetState extends State<EditPlaylistSheet> {
  Future<XFile?> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final result = await picker.pickImage(source: source);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusWidget(
      child: BottomSheetWrapper(
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
                onTap: () {},
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
              border: Border.symmetric(horizontal: BorderSide(color: Theme.of(context).dividerColor)),
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
                    imageUrls: listSong.map((e) => e.coverImageUrl).toList(),
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
            textFieldConfig: TextFieldConfig(
              controller: TextEditingController(text: widget.playlistModel.playlistName),
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
              border: Border.symmetric(horizontal: BorderSide(color: Theme.of(context).dividerColor)),
            ),
            child: const SizedBox(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: IntrinsicWidth(
              child: InkWellWrapper(
                onTap: () {},
                borderRadius: BorderRadius.circular(4.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.swap_vert),
                      const SizedBox(width: 16.0),
                      Text(
                        'Sorting',
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
              border: Border.symmetric(horizontal: BorderSide(color: Theme.of(context).dividerColor)),
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
                listSong.length,
                (index) => SongTile(
                  key: UniqueKey(),
                  onCheckChanged: (value) {},
                  canChoose: true,
                  canMove: true,
                  songModel: listSong[index],
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
                listSong.insert(newIndex, listSong.removeAt(oldIndex));
              });
            },
          ),
          const SizedBox(height: 32.0),
        ],
        titlePadding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
    );
  }
}
