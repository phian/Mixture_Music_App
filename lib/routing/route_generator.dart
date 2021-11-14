import 'package:flutter/material.dart';
import 'package:mixture_music_app/ui/feedback_and_report_screen.dart';

import '../ui/forgot_password.dart';
import '../ui/home/home.dart';
import '../ui/nav_screen/nav_screen.dart';
import '../ui/onboarding_screen.dart';
import '../ui/player_screen/music_player_screen.dart';
import '../ui/sign_in_screen.dart';
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
      default:
        throw const RouteException('Route not found');
    }
  }
}
