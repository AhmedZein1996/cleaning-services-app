import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class UserAuth {
//  String uid;
//  final String accessToken;
//
//  User({required this.accessToken});

  static Future<void> saveToken({required resultData}) async {
    final accessToken = resultData['login']['access_token'];
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('access_token', accessToken);
    return;
  }

  static Future<bool> isAlreadyLogin() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (!sharedPreferences.containsKey('access_token')) {
      return false;
    }
    return true;
  }

  static Future<String> getToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('access_token')) {
      log("Tooooooooooken :::::: =>>>>>>>>>>>>  ${sharedPreferences.get("access_token").toString()}");
      return sharedPreferences.get("access_token").toString();
    }
    log("Tooooooooooken :Error");
    return "not found";
  }

  static Future<void> logout() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    return;
  }
}
