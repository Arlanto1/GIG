import 'dart:developer';

import 'package:db_atom/src/common_widgets/app_bar.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/configurations/main_config.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/dashboard/views/charts/bar_chart.dart';
import 'package:db_atom/src/features/dashboard/views/charts/pie_chart.dart';
import 'package:db_atom/src/features/dashboard/views/drawer/drawer_reusable.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => DashboardViewState();
}

class DashboardViewState extends State<DashboardView> {
  String userName = '';
  String email = '';

  @override
  void initState() {
    log('-MyHomePage---initState--');
    super.initState();
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    userName = await SharedPrefs.getUsername();
    email = await SharedPrefs.getEmail();
    log('username : $userName email is : $email');
    //await Future.delayed(Duration(seconds: 3));
    setState(() {});
  }

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

  // final width = size.width;
// class MyHomePage extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
      // drawer: navigationDrawer(),
      // appBar: AppBar(
      //   title: Text(F.title),
      //   backgroundColor: AppColors.navigationSkybluecolor,
      // ),
      key: scaffoldKey,
      drawer: NavigationDrawer1(scaffoldKey, userName, email),
      appBar: AppHeader(
        isTitleCenter: false,
        title: Constants.dashboard,

        action: const [
          // GestureDetector(
          //   onTap: () {
          //     showDialog(
          //       context: context,
          //       builder: (BuildContext dialogContext) {
          //         return const CustomInternationalization(
          //           title: Constants.internationalization,
          //         );
          //       },
          //     );
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     child: SvgPicture.asset(
          //       AppIcon.vectoridentify,
          //       color: AppColors.backgroundWhitecolor,
          //       width: 20,
          //       //key: const Key(Keys.userIcon),
          //     ),
          //   ),
          // ),

          // Icon(Icons.add),

          // GestureDetector(
          //   onTap: () {
          //     var dialog = CustomAlertImageDialog(
          //         title: Constants.unsaveddata,
          //         message: Constants.unsaveddatadesc,
          //         image: AppIcon.questionmark,
          //         onPostivePressed: () {
          //           // Validator.logoutAction(context);
          //         },
          //         positiveBtnText: Constants.yes,
          //         negativeBtnText: Constants.no);
          //     showDialog(
          //         context: context, builder: (BuildContext context) => dialog);
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     child: SvgPicture.asset(
          //       AppIcon.notifications,
          //       color: AppColors.backgroundWhitecolor,
          //       width: 20,
          //       //key: const Key(Keys.userIcon),
          //     ),
          //   ),
          // ),
        ],
        // backgroundColor: AppColors.navigationSkybluecolor,
        backBtn: IconButton(
          icon: const Icon(Icons.menu, color: AppColors.backgroundWhitecolor),
          onPressed: () {
            if (scaffoldKey.currentState!.isDrawerOpen) {
              scaffoldKey.currentState!.closeDrawer();
              //close drawer, if drawer is open
            } else {
              scaffoldKey.currentState!.openDrawer();
              //open drawer, if drawer is closed
            }
          },
        ),
      ),
      body: Container(
        color: AppColors.navigationSkybluecolor,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: const ShapeDecoration(
                      color: AppColors.backgroundWhitecolor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20.0)),
                      )),
                  child: Column(
                    children: [
                      PieChartApp(),
                      CommonWidgets.verticalSpacerWidget(height * 0.03),
                      BarChartApp(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
