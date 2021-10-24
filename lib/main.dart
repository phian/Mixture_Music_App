import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/app_theme.dart';
import 'routing/route_generator.dart';
import 'routing/routes.dart';
import 'widgets/base_button.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator().onGenerateRoute,
      theme: AppThemes.darkCoolTheme,
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BaseButton(
                content: "ONBOARDING SCREEN",
                onTap: () {
                  Get.offAllNamed(AppRoutes.onBoarding);
                },
                margin: EdgeInsets.symmetric(horizontal: 24.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
