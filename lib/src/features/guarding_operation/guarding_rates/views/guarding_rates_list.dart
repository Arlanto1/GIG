import 'package:db_atom/src/common_widgets/app_bar.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/configurations/main_config.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/dashboard/views/drawer/drawer_reusable.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../../common_widgets/base_widget/guarding_box.dart';

class GuardingRates extends StatefulWidget {
  const GuardingRates({super.key});

  @override
  State<GuardingRates> createState() => GuardingRatesState();
}

class GuardingRatesState extends State<GuardingRates> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      key: scaffoldKey,
      drawer: navigationDrawer1(scaffoldKey),
      appBar: AppHeader(
        isTitleCenter: false,
        title: 'Create Guarding Rates Cards',

        action: [
                ],
        // backgroundColor: AppColors.navigationSkybluecolor,
           backBtn: IconButton(
             onPressed: () {
               Navigator.pop(context);
             },
             icon: SvgPicture.asset(AppIcon.backIcon,
                 color: AppColors.backgroundWhitecolor),
           ),
        ),

      body: Container(
        color: AppColors.navigationSkybluecolor,
        child: Padding(
          padding: const EdgeInsets.only(top:10.0),
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
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                      Text(Constants.guardingRatingCards,
                      style: Styles.styleHeaderGreyText16,
                      ),
                       CommonWidgets.verticalSpacerWidget(height * 0.02),
                       const GuardingRectangle(),
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