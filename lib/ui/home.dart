import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff323334),
      body: SafeArea(
        child: Column(
          children: [
            Obx(() => WeatherCard(location: controller.location.value)),
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
  }) : super(key: key);

  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sunny',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white70,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '24',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      '\u2103',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                Text(
                  location.isEmpty ? 'locating' : location,
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Image.network(
            'https://cdn.weatherapi.com/weather/64x64/day/122.png',
            scale: 0.5,
          ),
        ),
      ],
    );
  }
}
