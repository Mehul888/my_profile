import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_profile/utlity/pref_manager.dart';

class EmailController extends GetxController {
  final emailController = TextEditingController();

  String get email => emailController.text.trim();

  static EmailController get to => Get.find();

  Future<void> iniValues() async {
    final loginData = await PrefManager.getLoginData();
    emailController.text = loginData?.email ?? '';
  }

  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(emailController.text);
  }
}

class PasswordController extends GetxController {
  final passWordController = TextEditingController();
  bool obscurePassword = true;

  String get password => passWordController.text.trim();

  static PasswordController get to => Get.find();
  Future<void> iniValues() async {
    final loginData = await PrefManager.getLoginData();
    passWordController.text = loginData?.password ?? '';
  }

  bool isPassWordValid() {
    return passWordController.text.length < 8;
  }

  void changeObserValue() {
    obscurePassword = !obscurePassword;
    update();
  }
}

class RememberController extends GetxController {
  bool remember = false;

  static RememberController get to => Get.find();

  Future<void> iniValues() async {
    final loginData = await PrefManager.getLoginData();
    remember = loginData != null;
    update();
  }

  void changeValue() {
    remember = !remember;
    update();
  }
}
