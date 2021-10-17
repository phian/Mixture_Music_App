import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/controllers/home_controller.dart';

import 'widget/weather_infor.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
          ],
        ),
      ),
    );
  }
}
