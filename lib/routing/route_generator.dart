
import 'package:flutter/material.dart';
import 'package:mixture_music_app/routing/routes.dart';
import 'package:mixture_music_app/ui/forgot_password.dart';
import 'package:mixture_music_app/ui/home/home.dart';
import 'package:mixture_music_app/ui/sign_in_screen.dart';
import 'package:mixture_music_app/ui/onboarding_screen.dart';
import 'package:mixture_music_app/ui/sign_up_screen.dart';
import 'package:mixture_music_app/utils/route_exception.dart';

class RouteGenerator {
  static RouteGenerator? _instance;

  RouteGenerator._();

  factory RouteGenerator() {
    _instance ??= RouteGenerator._();
    return _instance!;
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch(settings.name) {
      case AppRoutes.onBoarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case AppRoutes.signIn:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case AppRoutes.main:
        return MaterialPageRoute(builder: (_) => Home());
      default:
        throw RouteException("Route not found");
    }
  }
}