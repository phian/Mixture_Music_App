import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mixture_music_app/ui/splash_screen.dart';

import 'routing/route_generator.dart';
import 'ui/home/controller/home_controller.dart';

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

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const SplashScreen(),
      // onGenerateRoute: RouteGenerator().onGenerateRoute,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      getPages: RouteGenerator.pages(),
      smartManagement: SmartManagement.keepFactory,
    );
  }
}
