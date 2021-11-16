import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'routing/route_generator.dart';
import 'ui/splash_screen.dart';

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

  runApp(
    GetMaterialApp(
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator().onGenerateRoute,

      // theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
    ),
  );
}
