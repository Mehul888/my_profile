import 'dart:convert';

import 'package:my_profile/constants/app_constants.dart';
import 'package:my_profile/models/login_model.dart';
import 'package:my_profile/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  static Future<String?> getUserToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(AppConstants.userTokenKey);
  }

  static Future<void> setUserToken(String value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(AppConstants.userTokenKey, value);
  }

  static Future<LoginModel?> getLoginData() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString(AppConstants.userRemeberKey);
    if (data == null) {
      return null;
    }
    return LoginModel.fromJson(jsonDecode(data));
  }

  static Future<void> setLoginData(LoginModel data) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(AppConstants.userRemeberKey, jsonEncode(data));
  }

  static Future<UserModel> getUser() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString(AppConstants.userKey);
    if (data == null) {
      return UserModel.defaultValue();
    }
    return UserModel.fromJson(jsonDecode(data));
  }

  static Future<void> setUser(UserModel data) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(AppConstants.userKey, jsonEncode(data));
  }

  static Future<void> clearAllPref() async {
    final pref = await SharedPreferences.getInstance();

    await pref.remove(AppConstants.userKey);
    await pref.remove(AppConstants.userTokenKey);
  }

  static Future<void> clearLogindata() async {
    final pref = await SharedPreferences.getInstance();

    await pref.remove(AppConstants.userRemeberKey);
  }
}
