import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/constants/app_colors.dart';
import 'package:mixture_music_app/controllers/auth_controller.dart';
import 'package:mixture_music_app/images/app_icons.dart';
import 'package:mixture_music_app/models/auth/auth_user_model.dart';
import 'package:mixture_music_app/models/auth/facebook/facebook_user_model.dart';
import 'package:mixture_music_app/routing/routes.dart';
import 'package:mixture_music_app/ui/settings_screen/constants/settings_screen_constants.dart';
import 'package:mixture_music_app/ui/settings_screen/controller/setings_screen_controller.dart';
import 'package:mixture_music_app/ui/settings_screen/widgets/interface_sheet.dart';
import 'package:mixture_music_app/ui/settings_screen/widgets/notification_sheet.dart';
import 'package:mixture_music_app/ui/settings_screen/widgets/setting_tile.dart';
import 'package:mixture_music_app/widgets/inkwell_wrapper.dart';
import 'package:mixture_music_app/widgets/loading_container.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rating_dialog/rating_dialog.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
  String _appVersion = '';
  FacebookUserModel? _facebookUser;
  User? _googleUser;
  AuthUserModel? _authUser;
  final _authController = Get.find<AuthController>();
  String _authType = '';
  final _settingsController = Get.put(SettingsScreenController());

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

    _getAuthType();
  }

  void _getAuthType() async {
    _authType = await _authController.getAuthType();
    _checkAuthTypeAndInitUser();
  }

  void _checkAuthTypeAndInitUser() async {
    switch (_authType) {
      case 'facebook':
        _facebookUser = await _authController.getFacebookUserData();
        setState(() {});
        break;
      case 'google':
        _googleUser = _authController.googleUser;
        setState(() {});
        break;
      case 'authUser':
        _authUser = AuthUserModel(
          userName: await _authController.getAuthUserName(),
          avatarUrl: await _authController.getAuthUserAvatar(),
        );
        setState(() {});
        break;
    }
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
              onTap: _authType == 'authUser'
                  ? () async {
                      var res = await Get.toNamed(
                        AppRoutes.editProfile,
                        arguments: _authUser,
                      );

                      if (res) {
                        _authUser = AuthUserModel(
                          userName: await _authController.getAuthUserName(),
                          avatarUrl: await _authController.getAuthUserAvatar(),
                        );
                        setState(() {});
                      }
                    }
                  : null,
              borderRadius: BorderRadius.zero,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    ClipOval(
                      child: () {
                        if (_authType == 'authUser') {
                          if (_authUser!.avatarUrl != null) {
                            return Image.network(
                              _authUser!.avatarUrl!,
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.width * 0.25,
                              fit: BoxFit.cover,
                              loadingBuilder: (_, child, chunkEvent) {
                                if (chunkEvent == null) return child;

                                return LoadingContainer(
                                  width: MediaQuery.of(context).size.width * 0.25,
                                  height: MediaQuery.of(context).size.width * 0.25,
                                );
                              },
                            );
                          } else {
                            Image.asset(
                              AppIcons.avatar,
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.width * 0.25,
                              fit: BoxFit.cover,
                            );
                          }
                        } else {
                          print('facebook url: ${_facebookUser!.picture?.url}');
                          return Image.network(
                            _authType == 'facebook' ? _facebookUser!.picture?.url ?? '' : _googleUser!.photoURL ?? '',
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.width * 0.25,
                            fit: BoxFit.cover,
                            loadingBuilder: (_, child, chunkEvent) {
                              if (chunkEvent == null) return child;

                              return LoadingContainer(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height: MediaQuery.of(context).size.width * 0.25,
                              );
                            },
                          );
                        }
                      }(),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _authType == 'facebook'
                                ? _facebookUser!.name ?? ''
                                : _authType == 'google'
                                    ? _googleUser!.displayName ?? ''
                                    : _authUser!.userName ?? '',
                            style: Theme.of(context).textTheme.headline5?.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            _authType == 'facebook'
                                ? _facebookUser!.email ?? ''
                                : _authType == 'google'
                                    ? _googleUser!.email ?? ''
                                    : _authUser!.userName ?? '',
                            style: Theme.of(context).textTheme.caption?.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 15.0,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _authType == 'authUser',
                      child: const Icon(Icons.arrow_forward_ios, size: 20.0),
                    ),
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
                  if (index == 1) {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return NotificationSheet(controller: _settingsController, title: firstSectionTexts[index]);
                      },
                    );
                  } else if (index == 2) {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return InterfaceSheet(controller: _settingsController, title: firstSectionTexts[index]);
                      },
                    );
                  }
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

  void _navigate({required int index}) async {
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
      case 1:
        Get.toNamed(AppRoutes.helpScreen);
        break;
      case 2:
        Get.toNamed(AppRoutes.feedbackAndBugReport);
        break;
      case 3:
        // RateMyApp rateMyApp = RateMyApp(
        //   preferencesPrefix: 'rateMyApp_',
        //   minDays: 0, // Show rate popup on first day of install.
        //   minLaunches: 5, // Show rate popup after 5 launches of app after minDays is passed.
        // );
        // await rateMyApp.init();
        // rateMyApp.showRateDialog(context);

        Get.dialog(
          RatingDialog(
            initialRating: 1.0,
            // your app's name?
            title: const Text(
              'Mixture Music',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            // encourage your user to leave a high rating?
            message: const Text(
              'Tap a star to set your rating. Add more description here if you want.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
            // Your app's logo?
            image: Image.asset(AppIcons.appIcon, width: 150.0, height: 150.0),
            submitButtonText: 'Send',
            commentHint: 'Tell us your feeling',
            onCancelled: () => print('cancelled'),
            onSubmitted: (response) {
              print('rating: ${response.rating}, comment: ${response.comment}');

              // TODO: add your own logic
              if (response.rating < 3.0) {
                // send their comments to your email or anywhere you wish
                // ask the user to contact you instead of leaving a bad review
              } else {
                // _rateAndReviewApp();
              }
            },
          ),
        );
        break;
    }
  }
}
