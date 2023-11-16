import 'dart:convert';
import 'dart:developer';

import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/login/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  static clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> setIsRequiredPasswordChange(bool value) async {
    instance.setBool(Constants.isRequiredPasswordChangeKey, value);
  }

  static Future<bool> getIsRequiredPasswordChange() async {
    return instance.getBool(Constants.isRequiredPasswordChangeKey) ?? false;
  }

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

  static Future<void> setEmail(String value) async {
    instance.setString(Constants.isEmailKey, value);
  }

  static Future<String> getEmail() async {
    String? isEmail = instance.getString(Constants.isEmailKey) ?? '';
    return isEmail; //Future<bool>.value(isLoggedIn);
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

  static Future<void> setToken(String token) async {
    instance.setString(Constants.isAccessToken, token);
  }

  static Future<String> getToken() async {
    String token = instance.getString(Constants.isAccessToken) ?? '';
    return token;
  }

  static Future<void> setRefreshToken(String token) async {
    instance.setString(Constants.isSessionToken, token);
  }

  static Future<String> getRefreshToken() async {
    String token = instance.getString(Constants.isSessionToken) ?? '';
    return token;
  }

  static removeAccessToken() async {
    //final prefs = await SharedPreferences.getInstance();
    instance.remove(Constants.isAccessToken);
  }

  static Future<void> setSessionToken(String token) async {
    instance.setString(Constants.isSessionToken, token);
  }

  static Future<String> getSessionToken() async {
    String token = instance.getString(Constants.isSessionToken) ?? '';
    return token;
  }

  static removeSessionAccessToken() async {
    //final prefs = await SharedPreferences.getInstance();
    instance.remove(Constants.isSessionToken);
  }

  static Future<void> setMaterialMovementId(int value) async {
    instance.setInt(Constants.isMaterialMovementIdKey, value);
  }

  static Future<int> getMaterialMovementId() async {
    int? id = instance.getInt(Constants.isMaterialMovementIdKey) ?? 0;
    log('$id');
    return id;
  }

  static Future<void> setDisplayMenu(DisplayMenu displayMenu) async {
    log('Setting Display Menu');
    String jsonString = jsonEncode(displayMenu.toJson());
    instance.setString(Constants.userRoles, jsonString);
  }

  static Future<DisplayMenu?> getDisplayMenu() async {
    String jsonString = instance.getString(Constants.userRoles) ?? '';
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    if (jsonMap.isNotEmpty) {
      DisplayMenu displayMenu = DisplayMenu.fromJson(jsonMap);
      return displayMenu;
    }

    return null;
  }
}
