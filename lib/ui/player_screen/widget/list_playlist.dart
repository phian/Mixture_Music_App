import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/models/playlist_model2.dart';

import '../../create_playlist_screen.dart';

class ListPlayList extends StatelessWidget {
  ListPlayList({Key? key}) : super(key: key);

  final listPlaylist = [
    PlaylistModel2(
      id: 01,
      title: 'Ngày Mưa',
      totalSong: 14,
      coverURL:
          'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
    ),
    PlaylistModel2(
      id: 01,
      title: 'Ngày Nắng',
      totalSong: 17,
      coverURL:
          'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
    ),
    PlaylistModel2(
      id: 01,
      title: 'Nóng như thế này',
      totalSong: 20,
      coverURL:
          'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: SizedBox(
        height: Get.height * 0.9,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Add to Playlist',
              style: theme.textTheme.headline5!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: theme.backgroundColor,
            elevation: 5,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CupertinoButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return const CreatePlaylistScreen();
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(30),
                  color: theme.primaryColor,
                  child: Text(
                    'New playlist',
                    style: theme.textTheme.headline6,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: listPlaylist.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            listPlaylist[index].coverURL,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        title: Text(
                          listPlaylist[index].title,
                        ),
                        subtitle: Text(
                          listPlaylist[index].totalSong.toString() + ' Tracks',
                        ),
                        trailing: Checkbox(
                          value: true,
                          onChanged: (value) {},
                        ),
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

