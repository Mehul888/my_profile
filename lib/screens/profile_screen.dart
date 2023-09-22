import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_profile/controllers/profile_controller.dart';
import 'package:my_profile/screens/login_screen.dart';
import 'package:my_profile/utlity/pref_manager.dart';

import 'confirmation_popup.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ConfirmationPopup(
                    title: 'Confirmation',
                    message: 'Are you sure you want to Logout?',
                    onConfirm: () async {
                      await PrefManager.clearAllPref();
                      Navigator.of(context).pop();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()),
                          (route) => false); // Close the dialog
                    },
                  );
                },
              );
              // Handle logout logic here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<ProfileController>(
              init: ProfileController(),
              initState: (_) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  ProfileController.to.initValues();
                });
              },
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8, bottom: 0),
                      child: Center(
                        child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: controller.user.imagePath == null
                                  ? null
                                  : Image.file(File(controller.user.imagePath!)).image,
                            )),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 50, left: 8.0),
                      child: Text(
                        "Name : ",
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        controller.user.name,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, left: 8.0),
                      child: Text(
                        "Email : ",
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        controller.user.email,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, left: 8.0),
                      child: Text(
                        "Skills : ",
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        controller.user.skill,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, left: 8.0),
                      child: Text(
                        "Work Experience : ",
                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "${controller.user.workExpreince} + year",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 60, bottom: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfile()));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                          child: const Center(
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
