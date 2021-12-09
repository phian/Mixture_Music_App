import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mixture_music_app/controllers/auth_controller.dart';
import 'package:mixture_music_app/ui/edit_profile_screen/edit_profile_screen.dart';
import 'package:mixture_music_app/ui/feedback_and_report_screen.dart';
import 'package:mixture_music_app/ui/help_screen.dart';
import 'package:mixture_music_app/ui/playlist_detail_screen/playlist_detail_screen.dart';
import 'package:mixture_music_app/ui/scan_qr_code_screen.dart';
import 'package:mixture_music_app/ui/splash_screen.dart';

import '../ui/forgot_password.dart';
import '../ui/home/home.dart';
import '../ui/nav_screen/nav_screen.dart';
import '../ui/onboarding_screen.dart';
import '../ui/player_screen/music_player_screen.dart';
import '../ui/sign_in_screen/sign_in_screen.dart';
import '../ui/sign_up_screen.dart';
import '../utils/route_exception.dart';
import 'routes.dart';

class RouteGenerator {
  static RouteGenerator? _instance;

  RouteGenerator._();

  factory RouteGenerator() {
    _instance ??= RouteGenerator._();
    return _instance!;
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case AppRoutes.signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case AppRoutes.main:
        return MaterialPageRoute(builder: (_) => Home());
      case AppRoutes.navigationScreen:
        return MaterialPageRoute(builder: (_) => const NavScreen());
      case AppRoutes.musicPlayerScreen:
        return MaterialPageRoute(builder: (_) => MusicPlayerScreen());
      case AppRoutes.feedbackAndBugReport:
        return MaterialPageRoute(builder: (_) => const FeedbackAndReportScreen());
      case AppRoutes.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case AppRoutes.playlistDetailScreen:
        return MaterialPageRoute(builder: (_) => const PlayListDetailScreen());
      default:
        throw const RouteException('Route not found');
    }
  }

  static List<GetPage<dynamic>> pages() {
    return [
      GetPage(
        name: AppRoutes.splash,
        page: () => const SplashScreen(),
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => AuthController());
          },
        ),
      ),
      GetPage(
        name: AppRoutes.onBoarding,
        page: () => const OnBoardingScreen(),
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => AuthController());
          },
        ),
      ),
      GetPage(
        name: AppRoutes.signIn,
        page: () => const SignInScreen(),
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => AuthController());
          },
        ),
      ),
      GetPage(name: AppRoutes.forgotPassword, page: () => const ForgotPasswordScreen()),
      GetPage(name: AppRoutes.signUp, page: () => const SignUpScreen()),
      GetPage(name: AppRoutes.main, page: () => Home()),
      GetPage(name: AppRoutes.navigationScreen, page: () => const NavScreen()),
      GetPage(name: AppRoutes.musicPlayerScreen, page: () => MusicPlayerScreen()),
      GetPage(name: AppRoutes.feedbackAndBugReport, page: () => const FeedbackAndReportScreen()),
      GetPage(
        name: AppRoutes.editProfile,
        page: () => const EditProfileScreen(),
        binding: BindingsBuilder(
          () {
            Get.lazyPut(() => AuthController());
          },
        ),
      ),
      GetPage(name: AppRoutes.playlistDetailScreen, page: () => const PlayListDetailScreen()),
      GetPage(name: AppRoutes.helpScreen, page: () => const HelpScreen()),
      GetPage(name: AppRoutes.scanQrCode, page: () => const ScanQrCodeScreen()),
    ];
  }
}
