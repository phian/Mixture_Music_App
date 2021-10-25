import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/constants/app_constants.dart';

import 'controller/home_controller.dart';
import 'widget/playlist_header.dart';
import 'widget/refresh_indicator.dart';
import 'widget/song_tile.dart';
import 'widget/weather_infor.dart';


class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final controller = Get.put(HomeController());

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
            physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: Column(
              children: [
                GetBuilder<HomeController>(
                  builder: (c) {
                    if (c.hasLoaded)
                      return WeatherInfor(
                        weatherResponse: c.weatherModel.value!,
                        location: c.location.value,
                      );
                    return SizedBox.shrink();
                  },
                ),
                SizedBox(height: 16),
                Divider(
                  indent: 16,
                  thickness: 0.5,
                  height: 16,
                ),
                PlaylistHeader(coverImageUrl: listSong.map((e) => e.coverImageUrl).toList()),
                Divider(
                  indent: 16,
                  endIndent: 16,
                  thickness: 0.5,
                  height: 16,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  itemCount: listSong.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => SongTile(
                        songModel: listSong[index],
                        isPlaying: index == controller.playingSongIndex.value ? true : false,
                        onTap: () {
                          controller.playingSongIndex.value = index;
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
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

