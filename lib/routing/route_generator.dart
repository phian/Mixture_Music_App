
import 'package:flutter/material.dart';
import 'package:mixture_music_app/routing/routes.dart';
import 'package:mixture_music_app/ui/onboarding_screen.dart';
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
      default:
        throw RouteException("Route not found");
    }
  }
}