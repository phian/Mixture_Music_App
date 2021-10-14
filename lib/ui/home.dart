import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/models/weather.dart';

import '../controllers/home_controller.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xff323334),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => WeatherCard(
                location: controller.location.value,
                weather: controller.currentWeather.value,
              ),
            ),
            // Center(
            //   child: TextButton(
            //     onPressed: controller.getWeather,
            //     child: Text('Refresh'),
            //   ),
            // ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Song for a rainy day',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    Key? key,
    required this.location,
    required this.weather,
  }) : super(key: key);

  final String location;
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 145,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  weather.current != null ? weather.current!.tempC.round().toString() : "NaN",
                  style: TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  '\u2103',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            bottom: 10,
            child: Text(
              location.isEmpty ? 'locating...' : location,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
          if (weather.current != null)
            Positioned(
              top: 0,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/weather_icons/${weather.current!.isDay}/${weather.current!.condition.code}.png',
                    //'assets/weather_icons/1/1000.png',
                    color: Colors.white70,
                    width: 95,
                    height: 95,
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      weather.current != null ? weather.current!.condition.text : "",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
