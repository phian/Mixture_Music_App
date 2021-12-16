import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            await controller.getLocationAndWeather();
            await controller.getSuggestPlaylist();
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
                  height: 16,
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
                        songModel: controller.suggestedPlaylist[index],
                        isPlaying: index == controller.playingSongIndex.value
                            ? true
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
                    height: 16,
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
