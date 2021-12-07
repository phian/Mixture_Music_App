import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/images/app_icons.dart';
import 'package:mixture_music_app/images/app_images.dart';
import 'package:mixture_music_app/widgets/base_app_bar.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  final List<String> _faqTitles = const [
    'Why MixtureMusic stop playing music?',
    'Why can not close the music player on notification bar?',
    'Why must have internet to listen the musics?',
    'Why device vibrating or sound the alarm when changing the song and downloaded the song?',
    'Why song is stop when open game or facebook?',
    'Others',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Text(
          'FAQ',
          style: Theme.of(context).textTheme.headline4?.copyWith(
                fontSize: 22.0,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
            color: AppColors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Image.asset(AppIcons.appIcon, width: 80.0, height: 80.0),
                  Container(
                    height: 80.0,
                    width: 2.5,
                    color: AppColors.black12,
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  Expanded(
                    child: Text(
                      'Q & A',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Image.asset(AppImages.faq),
            const SizedBox(height: 24.0),
            ...List.generate(
              _faqTitles.length,
              (index) => Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: ExpansionTile(
                  iconColor: Theme.of(context).primaryColor,
                  collapsedIconColor: Theme.of(context).primaryColor,
                  tilePadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  title: Text(
                    _faqTitles[index],
                    style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
                        ' Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
                        'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
