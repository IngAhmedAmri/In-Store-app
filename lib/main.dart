import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'presentation/pages/splash_screen.dart';
import 'presentation/pages/login_instascreen.dart';
import 'presentation/controllers/login_controller.dart';
import 'presentation/pages/sign_upinstascreen.dart';
import 'presentation/controllers/signup_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
