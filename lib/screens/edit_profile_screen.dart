import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_profile/controllers/profile_controller.dart';

import 'confirmation_popup.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Builder(builder: (context) {
          return GestureDetector(
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EditConfirmationPopup(
                    title: 'Changes not saved !',
                    message: 'Its Seems you forgot saved changes',
                    onConfirm: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      // Close the dialog
                    },
                  );
                },
              );
              // Navigator.of(context).pop();
            },
          );
        }),
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
                return Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8, bottom: 0),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              controller.pickImage();
                            },
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    controller.profileImage == null ? null : Image.file(controller.profileImage!).image,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 28.0, left: 8.0, right: 8.0, bottom: 8.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: controller.nameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please Enter Name';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                            contentPadding: EdgeInsets.all(12.0),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: controller.emailController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please Enter Email';
                            }
                            if (!controller.isValidEmail()) {
                              return 'Please check email id';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            contentPadding: EdgeInsets.all(12.0),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: controller.skillController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please Enter Skill';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Skill',
                            contentPadding: EdgeInsets.all(12.0),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please Enter Experince';
                            }

                            return null;
                          },
                          controller: controller.expreinceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Work Experince',
                            contentPadding: EdgeInsets.all(12.0),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 60, bottom: 8.0),
                        child: GestureDetector(
                          onTap: () async {
                            if (controller.formKey.currentState!.validate()) {
                              await controller.updateProfile();
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                            child: const Center(
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
