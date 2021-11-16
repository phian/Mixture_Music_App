import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/models/facebook/facebook_user_model.dart';
import 'package:mixture_music_app/routing/routes.dart';
import 'package:mixture_music_app/ui/settings_screen/constants/settings_screen_constants.dart';
import 'package:mixture_music_app/ui/settings_screen/widgets/setting_tile.dart';
import 'package:mixture_music_app/widgets/bottom_sheet_wrapper.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key, required this.userModel}) : super(key: key);
  final FacebookUserModel userModel;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 16.0),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Settings',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontSize: 30.0,
                      color: AppColors.black,
                    ),
              ),
            ),
            const SizedBox(height: 24.0),
            InkWellWrapper(
              color: Colors.transparent,
              onTap: () {
                Get.toNamed(AppRoutes.editProfile);
              },
              borderRadius: BorderRadius.zero,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        widget.userModel.picture!.url!,
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.width * 0.25,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.userModel.name!,
                            style: Theme.of(context).textTheme.headline5?.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            widget.userModel.email!,
                            style: Theme.of(context).textTheme.caption?.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 15.0,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Align(
                        child: Icon(Icons.arrow_forward_ios, size: 20.0),
                        alignment: Alignment.centerRight,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24.0),
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
