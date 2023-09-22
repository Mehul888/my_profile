import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_profile/screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(scaffoldBackgroundColor: const Color(0xffEAEAEA), unselectedWidgetColor: const Color(0xff231F20)),
      home: const Splash(),
    );
  }
}
