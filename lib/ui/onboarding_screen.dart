import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_constants.dart';

import '../routing/routes.dart';
import '../widgets/base_button.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16.0),
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
                ...List.generate(
                  listSong.length,
                  (index) => Image.network(
                    listSong[index].coverImageUrl,
                    fit: BoxFit.cover,
                  ),
                )
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
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 18.0),
                      Text(
                        "WELCOME TO MIXTURE MUSIC APP",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 30.0,
                            ),
                      ),
                      const SizedBox(height: 24.0),
                      Text("Newest songs around the world",
                          style: Theme.of(context).textTheme.subtitle1),
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
