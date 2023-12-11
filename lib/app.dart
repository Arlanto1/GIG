import 'dart:developer';

import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';

import 'flavors.dart';
import 'src/features/dashboard/views/my_home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    log('-App---build--');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: F.title,
      theme: ThemeData(
        primarySwatch: AppColors.colorCustom,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true, //<-- SEE HERE
          fillColor: Colors.deepPurpleAccent, //<-- SEE HERE
        ),
      ),
      home: _flavorBanner(
        child: const DashboardView(),
        //show: kReleaseMode,
      ),
    );
  }

  Widget _flavorBanner({
    required Widget child,
    bool show = true,
  }) =>
      show
          ? Banner(
              location: BannerLocation.topStart,
              message: F.name,
              color: Colors.green.withOpacity(0.6),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.0,
                  letterSpacing: 1.0),
              textDirection: TextDirection.ltr,
              child: child,
            )
          : Container(
              child: child,
            );
}
