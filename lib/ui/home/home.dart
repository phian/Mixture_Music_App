import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_constants.dart';

import '../player_screen/controller/music_player_controller.dart';
import 'controller/home_controller.dart';
import 'widget/playlist_header.dart';
import 'widget/refresh_indicator.dart';
import '../../widgets/song_tile.dart';
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
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              children: [
                GetBuilder<HomeController>(
                  builder: (c) {
                    if (c.hasLoaded) {
                      return WeatherInfo(
                        weatherResponse: c.weatherModel.value!,
                        location: c.location.value,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 16),
                const Divider(
                  indent: 16,
                  thickness: 0.5,
                  height: 16,
                ),
                PlaylistHeader(coverImageUrl: listSong.map((e) => e.coverImageUrl).toList()),
                const Divider(
                  indent: 16,
                  endIndent: 16,
                  thickness: 0.5,
                  height: 16,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  itemCount: listSong.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => SongTile(
                        songModel: listSong[index],
                        isPlaying: index == controller.playingSongIndex.value ? true : false,
                        onTap: () {
                          controller.playingSongIndex.value = index;
                          musicController.setSong(listSong[index]);
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
