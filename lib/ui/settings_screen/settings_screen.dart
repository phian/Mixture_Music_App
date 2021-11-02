import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/constants/app_text_style.dart';
import 'package:mixture_music_app/ui/settings_screen/constants/settings_screen_constants.dart';
import 'package:mixture_music_app/ui/settings_screen/widgets/setting_tile.dart';
import 'package:mixture_music_app/widgets/base_app_bar.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((value) {
      setState(() {
        print('setState');
        _appVersion = value.version;
      });
    }, onError: (err) {
      print('error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Text(
          'Settings',
          style: AppTextStyles.lightTextTheme.headline4?.copyWith(
            fontSize: 30.0,
            color: AppColors.black,
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
            ...List.generate(
              firstSectionIcons.length,
              (index) => SettingTile(
                leading: Icon(firstSectionIcons[index], size: 30.0),
                title: Text(
                  firstSectionTexts[index],
                  style: AppTextStyles.lightTextTheme.caption?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () {},
                trailing: const Icon(Icons.arrow_forward_ios, size: 20.0),
              ),
            ),
            Container(
              height: 1.0,
              color: AppColors.black12,
              margin: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            ...List.generate(
              secondSectionIcons.length,
              (index) => SettingTile(
                leading: Icon(secondSectionIcons[index], size: 30.0),
                title: Text(
                  secondSectionTexts[index],
                  style: AppTextStyles.lightTextTheme.caption?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: () {},
                trailing: index == 0 ? Text(_appVersion) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
