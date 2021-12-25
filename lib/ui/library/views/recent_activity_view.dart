import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/controllers/user_data_controller.dart';
import 'package:mixture_music_app/images/app_images.dart';
import 'package:mixture_music_app/ui/player_screen/controller/music_player_controller.dart';
import 'package:mixture_music_app/widgets/song_tile.dart';

class RecentActivityView extends StatefulWidget {
  const RecentActivityView({Key? key}) : super(key: key);

  @override
  _RecentActivityViewState createState() => _RecentActivityViewState();
}

class _RecentActivityViewState extends State<RecentActivityView> {
  final _userDataController = Get.put(UserDataController());
  final _musicController = Get.put(MusicPlayerController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _userDataController.recents.isNotEmpty
          ? ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _userDataController.recents.length,
              itemBuilder: (context, index) {
                return Obx(
                  () => SongTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 32,
                    ),
                    songModel: _userDataController.recents[index],
                    isPlaying: _musicController.playingSong.value != null
                        ? _musicController.playingSong.value!.id ==
                                _userDataController.recents[index].id
                            ? true
                            : false
                        : false,
                    onTap: () async {
                      _musicController.setSong(
                        _userDataController.recents[index],
                      );
                    },
                    isFavorite: _userDataController.favorites.contains(
                      _userDataController.recents[index],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                thickness: 0.5,
              ),
            )
          : Center(
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
                    'Your recent activity is empty',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontSize: 18.0, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
    );
  }
}
