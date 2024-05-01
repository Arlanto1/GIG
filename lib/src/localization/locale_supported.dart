// Created by Ramesh
import 'package:db_atom/src/localization/app_translator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Localizer? localizer;

class LocaleSupportedMethod {
  //Supported locale for the app
  static var supportedLocale = const <Locale>[
    Locale('en', 'US'),
    Locale('fr', ''),
    Locale.fromSubtags(languageCode: 'zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
    Locale.fromSubtags(
        languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
    Locale.fromSubtags(
        languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
    Locale.fromSubtags(
        languageCode: 'zh', scriptCode: 'Hant', countryCode: 'HK'),
  ];

  static Localizer initialize(Locale locale) {
    localizer ??= Localizer(locale);
    return localizer!;
  }

  // Chinese traditional supported languages
  static const List<String> chineseTarditional = [
    'zh_Hant',
    'zh_Hant_TW',
    'zh_Hant_HK'
  ];

  // Initialising the locale translation and SDK
  static List<LocalizationsDelegate> getLocalizationsDelegates() {
    return [
      Localizer.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];
  }

  // Getting the locale on the initialization
  static Locale getLocale(Locale? locale, Iterable<Locale> supportedLocales) {
    if (locale == null) {
      return supportedLocales.first;
    }
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }

  // Method to call the translation in localizer service
  static String getLocaleString(BuildContext context, String key) {
    return localizer!.of(context)!.translate(key).replaceAll('�', '');
  }
}
