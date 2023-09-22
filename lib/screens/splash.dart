import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_profile/controllers/auth_controller.dart';
import 'package:my_profile/screens/profile_screen.dart';
import 'package:my_profile/utlity/pref_manager.dart';

import 'login_screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    navigate();
  }

  Future<void> navigate() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: GetBuilder<AuthController>(
              init: AuthController(),
              initState: (state) async {
                final userToken = await PrefManager.getUserToken();
                log('isUserLogin ${userToken}');
                Timer(const Duration(seconds: 3), () {
                  if (userToken != null) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()));
                    return;
                  }
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                });
              },
              builder: (controller) {
                return Text('My Profile');
              }),
        ),
      ),
    );
  }
}
