import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_profile/controllers/login_screen_controllers.dart';
import 'package:my_profile/models/login_model.dart';
import 'package:my_profile/screens/profile_screen.dart';
import 'package:my_profile/utlity/pref_manager.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailContoller = Get.put(EmailController());
    final passwordContoller = Get.put(PasswordController());
    final rememberContoller = Get.put(RememberController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetBuilder<EmailController>(
                    init: emailContoller,
                    initState: (state) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        EmailController.to.iniValues();
                      });
                    },
                    builder: (eContoller) {
                      return TextFormField(
                        controller: eContoller.emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please Enter email id';
                          }
                          if (!eContoller.isValidEmail()) {
                            return 'Please check email id';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(12.0),
                        ),
                      );
                    }),
                const SizedBox(height: 16.0),
                GetBuilder<PasswordController>(
                    init: passwordContoller,
                    initState: (state) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        PasswordController.to.iniValues();
                      });
                    },
                    builder: (pContoller) {
                      return TextFormField(
                        obscureText: pContoller.obscurePassword,
                        controller: pContoller.passWordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter password';
                          }
                          if (pContoller.isPassWordValid()) {
                            return 'Password length must be 8';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(12.0),
                          suffixIcon: IconButton(
                            icon: Icon(
                              pContoller.obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              pContoller.changeObserValue();
                            },
                          ),
                        ),
                      );
                    }),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    GetBuilder<RememberController>(
                        init: rememberContoller,
                        initState: (state) {
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            RememberController.to.iniValues();
                          });
                        },
                        builder: (controller) {
                          return Checkbox(
                            value: controller.remember,
                            onChanged: (value) {
                              controller.changeValue();
                            },
                          );
                        }),
                    const Text('Remember Password'),
                  ],
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () async {
                    final user = await PrefManager.getUser();
                    if (emailContoller.email != user.email) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Email id is Wrong"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    } else if (passwordContoller.password != '12345678') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Password is Wrong"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    } else {
                      await PrefManager.setUserToken('USER');
                      if (rememberContoller.remember) {
                        final loginData = LoginModel(
                            email: EmailController.to.email,
                            password: PasswordController.to.password);
                        await PrefManager.setLoginData(loginData);
                      } else {
                        await PrefManager.clearLogindata();
                      }
                      emailContoller.emailController.clear();
                      passwordContoller.passWordController.clear();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileScreen()));
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                      child: Text(
                        'Sign In ',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
