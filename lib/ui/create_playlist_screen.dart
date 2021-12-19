import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/controllers/playlist_controller.dart';
import 'package:mixture_music_app/controllers/user_data_controller.dart';
import 'package:mixture_music_app/models/playlist/playlist.dart';

class CreatePlaylistScreen extends StatelessWidget {
  CreatePlaylistScreen({
    Key? key,
  }) : super(key: key);

  final _playlistController = PlaylistController();
  final _playlistTitleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _userDataController = Get.find<UserDataController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Material(
        child: SizedBox(
          height: Get.height * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Give your playlist a name',
                    style: theme.textTheme.headline5,
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    controller: _playlistTitleController,
                    style: theme.textTheme.headline3,
                    autofocus: true,
                    textAlign: TextAlign.center,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 50),
                  CupertinoButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var playlist = Playlist(
                          createdTime: Timestamp.now(),
                          title: _playlistTitleController.text,
                          songs: [],
                        );
                        await _playlistController.createPlaylist(playlist).then(
                              (value) =>
                                  _userDataController.getAllUserPlaylists(),
                            );
                        Get.back();
                      }
                    },
                    borderRadius: BorderRadius.circular(30),
                    color: theme.primaryColor,
                    child: Text(
                      'Create',
                      style: theme.textTheme.headline6!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
