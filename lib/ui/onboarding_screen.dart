import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../routing/routes.dart';
import '../widgets/base_app_bar.dart';
import '../widgets/base_button.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                height: MediaQuery.of(context).size.height * 0.5,
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
                      Text(
                        "MUSIC PLAYER",
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      const SizedBox(height: 18.0),
                      Text(
                        "WELCOME TO MIXTURE MUSIC APP",
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 30.0,
                              color: AppColors.white,
                            ),
                      ),
                      const SizedBox(height: 24.0),
                      Text(
                        "Newest songs around the world",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              fontSize: 16,
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
      ),
    );
  }
}
