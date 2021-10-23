import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/song_model.dart';

import 'controller/home_controller.dart';
import 'widget/playlist_header.dart';
import 'widget/song_tile.dart';
import 'widget/weather_infor.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final controller = Get.put(HomeController());
  

  final _listSong = [
    SongModel(
      id: 01,
      tilte: 'Trời hôm nay nhiều mây cực',
      artist: 'Đen Vâu',
      coverImageUrl:
          'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
    ),
    SongModel(
      id: 01,
      tilte: 'Gọi mưa',
      artist: 'Trung Quân Idol',
      coverImageUrl:
          'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/0/0/003a856bfc8a2109ca5b5603e2ef5f75_1406285052.jpg',
    ),
    SongModel(
      id: 01,
      tilte: 'Vết mưa',
      artist: 'Vũ Cát Tường',
      coverImageUrl:
          'https://avatar-ex-swe.nixcdn.com/playlist/2013/10/29/e/d/1/2/1383055637469_500.jpg',
    ),
    SongModel(
      id: 01,
      tilte: 'Cơn mưa ngang qua',
      artist: 'Sơn Tùng MTP',
      coverImageUrl:
          'https://avatar-ex-swe.nixcdn.com/song/2018/03/30/b/1/8/8/1522404477634_640.jpg',
    ),
    SongModel(
      id: 01,
      tilte: 'Dấu mưa',
      artist: 'Trung Quân Idol',
      coverImageUrl:
          'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/5/f/5f732a84bfba6ba0230e11ef4e49ba38_1392691168.jpg',
    ),
    SongModel(
      id: 01,
      tilte: 'Trời hôm nay nhiều mây cực',
      artist: 'Đen Vâu',
      coverImageUrl:
          'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
    ),
    SongModel(
      id: 01,
      tilte: 'Gọi mưa',
      artist: 'Trung Quân Idol',
      coverImageUrl:
          'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/0/0/003a856bfc8a2109ca5b5603e2ef5f75_1406285052.jpg',
    ),
    SongModel(
      id: 01,
      tilte: 'Vết mưa',
      artist: 'Vũ Cát Tường',
      coverImageUrl:
          'https://avatar-ex-swe.nixcdn.com/playlist/2013/10/29/e/d/1/2/1383055637469_500.jpg',
    ),
    SongModel(
      id: 01,
      tilte: 'Cơn mưa ngang qua',
      artist: 'Sơn Tùng MTP',
      coverImageUrl:
          'https://avatar-ex-swe.nixcdn.com/song/2018/03/30/b/1/8/8/1522404477634_640.jpg',
    ),
    SongModel(
      id: 01,
      tilte: 'Dấu mưa',
      artist: 'Trung Quân Idol',
      coverImageUrl:
          'https://photo-resize-zmp3.zadn.vn/w240_r1x1_jpeg/covers/5/f/5f732a84bfba6ba0230e11ef4e49ba38_1392691168.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              PlaylistHeader(coverImageUrl: _listSong.map((e) => e.coverImageUrl).toList()),
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
                itemCount: _listSong.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => SongTile(
                      songModel: _listSong[index],
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
    );
  }
}
