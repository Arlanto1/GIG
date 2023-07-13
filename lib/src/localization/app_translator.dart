// Created by Ramesh
import 'package:connectivity/connectivity.dart';
import 'package:db_atom/src/localization/app_localization_service.dart';
import 'package:db_atom/src/localization/locale_supported.dart';
import 'package:flutter/material.dart';

class Localizer {
  final Locale? locale;
  Localizer(this.locale);
  Localizer? of(BuildContext context) {
    return Localizations.of<Localizer>(context, Localizer);
  }

  late Map<String, String> _localizedStrings;
  Future<bool> load() async {
    final network = await Connectivity().checkConnectivity().then((value) => value);
    if (network == ConnectivityResult.none) {
      final localised =
          await AppLocalisationService.getTranslatedStrings(locale?.languageCode ?? 'en');
      _localizedStrings = flattenTranslations(localised);
    } else {
      final localised = await AppLocalisationService.getLocalisedData();
      _localizedStrings = flattenTranslations(localised);
    }
    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key; // Add event for the keys to see if they exist
  }

  dynamic flattenTranslations(Map<String, dynamic> json, [String prefix = '']) {
    final Map<String, String> translations = {};
    json.forEach((String key, dynamic value) {
      if (value is Map) {
        translations.addAll(flattenTranslations(value as Map<String, dynamic>, '$prefix$key.'));
      } else {
        translations['$prefix$key'] = value.toString();
      }
    });
    return translations;
  }

  static LocalizationsDelegate<Localizer> delegate = AppLocalizationDelegate();
}

class AppLocalizationDelegate extends LocalizationsDelegate<Localizer> {
  @override
  bool isSupported(Locale locale) {
    return ['en', 'fr', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<Localizer> load(Locale locale) async {
    final localizations = LocaleSupportedMethod.initialize(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<Localizer> old) {
    return false;
  }
}
