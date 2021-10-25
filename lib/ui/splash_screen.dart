import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/images/app_images.dart';
import 'package:mixture_music_app/routing/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 500), () {
      Get.offAllNamed(AppRoutes.navigationScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImages.appIcon,
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.5,
        ),
      ),
    );
  }
}
