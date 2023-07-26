import 'dart:ffi';

import 'package:db_atom/src/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async => instance = await SharedPreferences.getInstance();

  static Future<void> setLoggedIn(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool(Constants.isLoggedInKey, value);
  }

  static Future<bool?> getLoggedIn() async {
    bool? isLoggedIn = instance.getBool(Constants.isLoggedInKey) ?? false;
    print(isLoggedIn);
    return isLoggedIn; //Future<bool>.value(isLoggedIn);
  }

  static Future<void> setUsername(String value) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    instance.setString(Constants.isUserNameKey, value);
  }

  static Future<String> getUsername() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? isUsername = instance.getString(Constants.isUserNameKey) ?? '';
    print(isUsername);
    return isUsername; //Future<bool>.value(isLoggedIn);
  }

  static Future<void> setUserId(String value) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    instance.setString(Constants.isUserIdKey, value);
  }

  static Future<String> getUserId() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? isUserId = instance.getString(Constants.isUserIdKey) ?? '';
    print(isUserId);
    return isUserId; //Future<bool>.value(isLoggedIn);
  }
  static Future<void> setIdentifymenuindex(int value) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    instance.setInt(Constants.isMenuIndexIdentifyKey, value);
  }

  static Future<int> getIdentifymenuindex() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    int value = instance.getInt(Constants.isMenuIndexIdentifyKey) ?? 0;
    print(value);
    return value; //Future<bool>.value(isLoggedIn);
  }

  static Future<void> setFoundId(int value) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    instance.setInt(Constants.isFoundIdKey, value);
  }

  static Future<int> getFoundId() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? isFoundId = instance.getInt(Constants.isFoundIdKey) ?? 0;
    print(isFoundId);
    return isFoundId; //Future<bool>.value(isLoggedIn);
  }
}
