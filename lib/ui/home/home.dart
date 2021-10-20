import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import 'widget/playlist_header.dart';
import 'widget/song_tile.dart';
import 'widget/weather_infor.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final controller = Get.put(HomeController());
  final List<String> _listImage = [
    'https://photo-resize-zmp3.zadn.vn/w360_r1x1_jpeg/avatars/9/0/2/2/90223f08b220e52a78ac5c0dd739256f.jpg',
    'https://static.wikia.nocookie.net/rapviet/images/8/8c/Soobin.jpg/revision/latest?cb=20180626075535&path-prefix=vi',
    'https://avatar-ex-swe.nixcdn.com/singer/avatar/2020/11/05/2/2/0/3/1604563630516_600.jpg',
    'https://i.scdn.co/image/ab6761610000e5ebc48716f91b7bf3016f5b6fbe'
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
                      weatherResponse: c.weatherResponse.value!,
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
              PlaylistHeader(listImage: _listImage),
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
                itemCount: 20,
                itemBuilder: (context, index) {
                  return SongTile(
                    imageUrl: _listImage[0],
                    isPlaying: index == 1 ? true : false,
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


