// Created by Ramesh
import 'dart:convert';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:db_atom/src/constants/constants.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class AppLocalisationService {
  static Future getLocalisedData() async {
    final String languageCode = Platform.localeName;
    final String code = getDeviceLocale(languageCode);
    // Need to change the real urls when api is ready
    const String url = 'www.locles.com';
    final String urlMethod = '$url/$code.json';
    try {
      final response = await http.get(Uri.parse(urlMethod), headers: {
        'Accept-Language': '/*',
        'Content-Type': 'application/json; charset=UTF-8; ',
      });
      if (response.statusCode == 200) {
        // api call success, collect all the data and store in object
        final Map<String, dynamic> jsonMap = jsonDecode(utf8.decode(response.bodyBytes));
        return jsonMap;
      } else {
        // in else case if api is failed, we can load from even local files which should be uploaded in assests
        final Map<String, dynamic> jsonMap = await getTranslatedStrings(code);
        return jsonMap;
      }
    } catch (e) {
      final Map<String, dynamic> jsonMap = await getTranslatedStrings(code);
      return jsonMap;
    }
  }

  static String getDeviceLocale(String code) {
    if (code.toLowerCase().contains('fr')) {
      return 'fr'; // French
    } else if (code.toLowerCase().contains('hant')) {
      return 'zh-TW'; // Chinese simplified
    } else if (code.toLowerCase().contains('zh')) {
      return 'zh-CN'; // Chinese traditional
    } else {
      return 'en'; // English
    }
  }

  static String getLocaleName(String code) {
    if (code == 'fr') {
      return Constants.french;
    } else if (code == 'zh-TW') {
      return Constants.chineseTraditional;
    } else if (code == 'zh-CN') {
      return Constants.chineseSimplified;
    } else {
      return Constants.english;
    }
  }

  static getTranslatedStrings(String code) async {
    final jsonString = await rootBundle.loadString('assets/translation/$code.json');
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return jsonMap;
  }
}
