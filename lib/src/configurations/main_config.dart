import 'dart:developer';

import 'package:db_atom/flavors.dart';
import 'package:db_atom/initialize_providers.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/localization/locale_supported.dart';
import 'package:db_atom/src/routing/route_generator.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

export 'package:flutter/material.dart';

class MainConfig {
  static environmentsChanging() {
    log('-environmentsChanging---main_config--');
    String environment = String.fromEnvironment(
      'ENVIRONMENT',
      defaultValue: F.title == "DEV"
          ? Environment.DEV
          : F.title == "QA"
              ? Environment.QA
              : F.title == "UAT"
                  ? Environment.UAT
                  : Environment.PROD,
    );

    Environment().initConfig(environment);
  }

  static initialSetup() async {
    log('-initialSetup---main_config--');
    Locale? locale;

    // Required for async calls in `main`
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize SharedPrefs instance.
    await SharedPrefs.init();

    // bool isLoggedIn = await SharedPrefs.getLoggedIn() ?? false;
    // GlobalKey<ScaffoldState> _menuscaffoldKey = new GlobalKey<ScaffoldState>();
    //  final _menuscaffoldKey = GlobalKey<ScaffoldState>();
    //Environment setup
    environmentsChanging();

    runApp(
      InitializeProviders(
        child: MaterialApp(
          theme: ThemeData(
            disabledColor: AppColors.textgreyThemecolor,
            fontFamily: Constants.customFontFamily,
            primarySwatch: AppColors.colorCustom,
            // inputDecorationTheme: const InputDecorationTheme(
            // filled: true, //<-- SEE HERE
            // fillColor: AppColors.textfilBbackGroundColor, //<-- SEE HERE
            // ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: splashScreenRoute,
          onGenerateRoute: RouteGenerator.generateRoute,
          locale: locale,
          supportedLocales: LocaleSupportedMethod.supportedLocale,
          localizationsDelegates:
              LocaleSupportedMethod.getLocalizationsDelegates(),
          localeResolutionCallback: (locale, supportedLocales) =>
              LocaleSupportedMethod.getLocale(locale, supportedLocales),
        ),
      ),
    );
  }
}
