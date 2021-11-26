import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/images/app_icons.dart';

import '../routing/routes.dart';
import 'home/controller/home_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    fetchData().then((value) => Get.offAllNamed(AppRoutes.onBoarding));
  }

  Future<void> fetchData() async {
    await controller.getLocationAndWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppIcons.appIcon,
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
        ),
      ),
    );
  }
}
