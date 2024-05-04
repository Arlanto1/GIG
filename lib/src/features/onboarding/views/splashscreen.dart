import 'dart:async';
import 'dart:developer';

import 'package:db_atom/index.dart';

/// This screen is not required
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    log('-SplashScreen---initState---${DateTime.now()}-');
    initRouting(context);
  }

  @override
  Widget build(BuildContext context) {
    log('-_SplashScreenState-build----');
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

  initRouting(BuildContext context) async {
    log('--initRouting---');
    // Get the NavigatorState object
    var navigatorState = Navigator.of(context);

    // Get the user name and token from SharedPrefs
    String userName = await SharedPrefs.getUserId();
    String token = await SharedPrefs.getToken();
    log('--initRouting--${userName.isEmptyOrNull}-');

    // Check if the user is logged in
    if (!userName.isEmptyOrNull && !token.isEmptyOrNull) {
      // Check if a password change is required
      bool requirePasswordChange =
      await SharedPrefs.getIsRequiredPasswordChange();

      // Navigate to the reset password screen if a password change is required
      if (requirePasswordChange) {
        navigatorState.pushNamed(resetPwdScreenRoute);
        return;
      }

      // Navigate to the dashboard screen and remove all previous screens from the back stack
      navigatorState.pushNamedAndRemoveUntil(
        dashboardViewRoute,
            (route) => false,
      );
    } else {
      // Navigate to the login screen and remove all previous screens from the back stack
      log('--initRouting--loginScreenRoute-');
      navigatorState.pushNamedAndRemoveUntil(
        loginScreenRoute,
            (route) => false,
      );
    }
  }
}
