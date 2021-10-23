import 'package:flutter/material.dart';
import '../ui/home/nav_screen/nav_screen.dart';
import 'routes.dart';
import '../ui/forgot_password.dart';
import '../ui/home/home.dart';
import '../ui/sign_in_screen.dart';
import '../ui/onboarding_screen.dart';
import '../ui/sign_up_screen.dart';
import '../utils/route_exception.dart';

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
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case AppRoutes.signIn:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case AppRoutes.main:
        return MaterialPageRoute(builder: (_) => Home());
      case AppRoutes.navigationScreen:
        return MaterialPageRoute(builder: (_) => NavScreen());
      default:
        throw RouteException("Route not found");
    }
  }
}
