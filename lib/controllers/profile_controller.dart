import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_profile/models/user_model.dart';
import 'package:my_profile/utlity/pref_manager.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  late UserModel user = UserModel.defaultValue();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final skillController = TextEditingController();
  final expreinceController = TextEditingController();
  File? profileImage;
  final formKey = GlobalKey<FormState>();

  Future<void> initValues() async {
    user = await PrefManager.getUser();
    nameController.text = user.name;
    emailController.text = user.email;
    skillController.text = user.skill;
    expreinceController.text = user.workExpreince.toString();

    if (user.imagePath != null) {
      profileImage = File(user.imagePath!);
    }
    update();
  }

  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(emailController.text);
  }

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    profileImage = File(image.path);
    update();
  }

  Future<void> updateProfile() async {
    final updatedUser = UserModel(
      nameController.text.trim(),
      emailController.text.trim(),
      skillController.text.trim(),
      int.tryParse(expreinceController.text) ?? 5,
      profileImage != null ? profileImage!.path : null,
    );
    await PrefManager.setUser(updatedUser);
    user = updatedUser;
    update();
  }
}
