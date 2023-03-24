import 'dart:developer';

import 'package:clean_services_app/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachedHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static putValue(String key, String value) {
    sharedPreferences!.setString(key, value);
  }

  static String getValue(String key) {
    if (sharedPreferences!.containsKey(key)) {
      return sharedPreferences!.get(key).toString();
    }
    log("Tooooooooooken :Error");
    return notFoundError;
  }

  static bool isGiftTaken() {
    if (sharedPreferences!.containsKey("isTakeGift")) {
      return true;
    }
    return false;
  }

  static putBool(String key, bool value) {
    sharedPreferences!.setBool(key, value);
  }

  static dynamic getBool(String key) {
    if (sharedPreferences!.containsKey(key)) {
      return sharedPreferences!.getBool(key);
    }
    return notFoundError;
  }

  static bool isAlreadyLogin() {
    if (!sharedPreferences!.containsKey('access_token')) {
      return false;
    }
    return true;
  }

  static void logout() {
    // sharedPreferences!.clear();
    sharedPreferences!.remove(kTokenKey);
  }

  static setLanguage(String value) {
    putValue(defaultLanguageKey, value);
  }

  static getLanguage() {
    return getValue(defaultLanguageKey);
  }

  static setThemeMode(bool value) {
    return putBool(defaultThemeModeKey, value);
  }

  static dynamic getThemeMode() {
    return getBool(defaultThemeModeKey);
  }
}
