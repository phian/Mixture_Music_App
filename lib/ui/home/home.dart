import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/controllers/song_controller.dart';

import '../../widgets/song_tile.dart';
import '../player_screen/controller/music_player_controller.dart';
import 'controller/home_controller.dart';
import 'widget/playlist_header.dart';
import 'widget/refresh_indicator.dart';
import 'widget/weather_infor.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final controller = Get.put(HomeController());
  final musicController = Get.put(MusicPlayerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomRefreshIndicator(
          builder: (
            BuildContext context,
            Widget child,
            IndicatorController indiController,
          ) {
            return MRefreshIndicator(
              context: context,
              child: child,
              controller: indiController,
            );
          },
          onRefresh: () async {
            await controller.onPullToRefresh();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              children: [
                Obx(() {
                  if (controller.weatherModel.value != null) {
                    return WeatherInfo(
                      weatherResponse: controller.weatherModel.value!,
                      location: controller.location.value,
                    );
                  }
                  return const SizedBox.shrink();
                }),
                const SizedBox(height: 16),
                const Divider(
                  indent: 16,
                  thickness: 0.5,
                  height: 16,
                ),
                Obx(() {
                  return PlaylistHeader(
                    coverImageUrl: controller.suggestedPlaylist
                        .map((e) => e.imgURL)
                        .toList(),
                  );
                }),

                // return const SizedBox.shrink();

                const Divider(
                  indent: 16,
                  endIndent: 16,
                  thickness: 0.5,
                  height: 1,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  itemCount: controller.suggestedPlaylist.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => SongTile(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        songModel: controller.suggestedPlaylist[index],
                        isPlaying: musicController.playingSong.value != null
                            ? musicController.playingSong.value!.id ==
                                    controller.suggestedPlaylist[index].id
                                ? true
                                : false
                            : false,
                        onTap: () {
                          controller.playingSongIndex.value = index;
                          musicController.setSong(
                            controller.suggestedPlaylist[index],
                          );
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    thickness: 0.5,
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
