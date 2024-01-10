import 'dart:async';
import 'dart:developer';

import 'package:db_atom/index.dart';

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
    log('-SplashScreen---initState---${DateTime.now()}-');
    initRouting();
  }

  initRouting() async {
    // When there is no session saved, it goes to landing screen
    Timer(const Duration(milliseconds: 500), () async {
      var navigatorState = Navigator.of(context);
      String userName = await SharedPrefs.getUserId();
      String token = await SharedPrefs.getToken();
      if (!userName.isEmptyOrNull && !token.isEmptyOrNull) {
        bool requirePasswordChange =
            await SharedPrefs.getIsRequiredPasswordChange();
        if (requirePasswordChange) {
          navigatorState.pushNamed(resetPwdScreenRoute);
          return;
        }
        navigatorState.pushNamedAndRemoveUntil(
          dashboardViewRoute,
          (route) => false,
        );
      } else {
        navigatorState.pushNamedAndRemoveUntil(
          loginScreenRoute,
          (route) => false,
        );
      }
    });
  }
}
