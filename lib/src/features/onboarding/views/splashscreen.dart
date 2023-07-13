import 'dart:async';

import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(Constants.splashscreen),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initRouting();
  }

  initRouting() async {
    // When there is no session saved, it goes to landing screen
    Timer(Duration(milliseconds: 1500), () {
      Navigator.pushNamed(context, loginScreenRoute);
    });
  }
}
