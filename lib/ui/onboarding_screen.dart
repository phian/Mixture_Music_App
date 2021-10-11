import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/widgets/base_app_bar.dart';
import 'package:mixture_music_app/widgets/base_button.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c0B0B1F,
      appBar: BaseAppBar(),
      body: Stack(
        children: [
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
                      onTap: () {},
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
