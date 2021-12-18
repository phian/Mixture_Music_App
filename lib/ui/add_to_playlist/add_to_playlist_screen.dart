import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/controllers/user_data_controller.dart';
import 'package:mixture_music_app/widgets/loading_container.dart';
import '../create_playlist_screen.dart';

class AddToPlaylistSheet extends StatelessWidget {
  AddToPlaylistSheet({Key? key}) : super(key: key);

  final userDataController = Get.find<UserDataController>();

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
                        return CreatePlaylistScreen();
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(30),
                  color: theme.primaryColor,
                  child: Text(
                    'New playlist',
                    style: theme.textTheme.headline6!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Obx(() {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: userDataController.playlists.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: SizedBox(
                            height: 60,
                            width: 60,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount: userDataController
                                            .playlists[index].songs.length >
                                        4
                                    ? 4
                                    : userDataController
                                        .playlists[index].songs.length,
                                itemBuilder: (context, idx) => Image.network(
                                  userDataController
                                      .playlists[index].songs[idx].data.imgURL,
                                  loadingBuilder: (context, child, chunkEvent) {
                                    if (chunkEvent == null) return child;
                                    return const LoadingContainer(
                                        width: 30.0, height: 30.0);
                                  },
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            userDataController.playlists[index].title,
                          ),
                          subtitle: Text(
                            userDataController.playlists[index].songs.length
                                    .toString() +
                                ' Tracks',
                          ),
                          trailing: Checkbox(
                            value: true,
                            onChanged: (value) {},
                          ),
                          onTap: () {},
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
