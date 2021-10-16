import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/routing/routes.dart';
import 'package:mixture_music_app/widgets/base_app_bar.dart';
import 'package:mixture_music_app/widgets/base_button.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c0B0B1F,
      appBar: const BaseAppBar(),
      body: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              height: MediaQuery.of(context).size.height * 0.45,
            ),
            items: [
              Container(
                color: Colors.red,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "MUSIC PLAYER",
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        color: AppColors.cEF01A0,
                      ),
                    ),
                    const SizedBox(height: 18.0),
                    const Text(
                      "WELCOME TO MIXTURE MUSIC APP",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 30.0,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    const Text(
                      "Newest songs around the world",
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 64.0),
                    BaseButton(
                      content: "GET STARTED",
                      onTap: () {
                        Get.toNamed(AppRoutes.signIn);
                      },
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
