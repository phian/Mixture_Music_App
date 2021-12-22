import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mixture_music_app/controllers/theme_controller.dart';
import 'package:mixture_music_app/routing/routes.dart';
import 'package:mixture_music_app/ui/home/controller/home_controller.dart';

import 'routing/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox<List<String>?>('recentSearch');

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final themeController = Get.put(ThemeController());
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: themeController.light.value,
        darkTheme: themeController.dark.value,
        getPages: RouteGenerator.pages(),
        initialRoute: AppRoutes.splash,
        smartManagement: SmartManagement.keepFactory,
      ),
    );
  }
}
