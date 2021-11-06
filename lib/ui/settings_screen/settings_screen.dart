import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/routing/routes.dart';
import 'package:mixture_music_app/ui/settings_screen/constants/settings_screen_constants.dart';
import 'package:mixture_music_app/ui/settings_screen/widgets/setting_tile.dart';
import 'package:mixture_music_app/widgets/base_app_bar.dart';
import 'package:mixture_music_app/widgets/bottom_sheet_wrapper.dart';
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
            ...List.generate(
              firstSectionIcons.length,
              (index) => SettingTile(
                leading: Icon(firstSectionIcons[index], size: 30.0),
                title: Text(
                  firstSectionTexts[index],
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                      ),
                ),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return BottomSheetWrapper(
                        contentItems: const [],
                        title: Text(
                          secondSectionTexts[index],
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      );
                    },
                  );
                },
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
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                      ),
                ),
                onTap: () {
                  _navigate(index: index);
                },
                trailing: index == 0 ? Text(_appVersion) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigate({required int index}) {
    switch (index) {
      case 0:
        Fluttertoast.showToast(
          msg: 'Current version: $_appVersion',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
          backgroundColor: Colors.grey,
        );
        break;
      case 2:
        Get.toNamed(AppRoutes.feedbackAndBugReport);
        break;
    }
  }
}
