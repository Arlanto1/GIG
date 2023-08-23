import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/guarding_box.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/configurations/main_config.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/dashboard/views/drawer/drawer_reusable.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:flutter/material.dart';


class GuardingRateDetails extends StatefulWidget {
  final String title;
  final GMRate rate;
  const GuardingRateDetails({super.key, required this.title, required this.rate});

  @override
  State<GuardingRateDetails> createState() => GuardingRateDetailsState();
}

class GuardingRateDetailsState extends State<GuardingRateDetails> {
  @override
  void initState() {
    super.initState();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
      key: scaffoldKey,
      drawer: navigationDrawer1(scaffoldKey),
      appBar: BaseAppBar().buildAppHeader(
        context: context,
        title: widget.title,
        showPopUp: false,
        showSaveButton: false,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Constants.guardingOfficialRatingCards,
                        style: Styles.styleHeaderGreyText16,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),
                       GuardingRectangle(rate: widget.rate),
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
