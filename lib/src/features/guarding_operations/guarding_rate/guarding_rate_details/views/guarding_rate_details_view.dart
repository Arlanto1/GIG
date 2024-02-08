import 'dart:developer';

import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/configurations/main_config.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common_widgets/app_button.dart';
import '../../../../../enums/form_status.dart';
import '../../../../../routing/router.dart';
import '../../../../../utils/helpers/keys/keys.dart';
import '../../../../../utils/validators/validator.dart';
import '../pay_rates/cubits/pay_rate_cubit.dart';

class GuardingRateDetailsView extends StatefulWidget {
  final String title;
  final GMRate rate;

  const GuardingRateDetailsView({
    super.key,
    required this.title,
    required this.rate,
  });

  @override
  State<GuardingRateDetailsView> createState() => GuardingRateDetailsViewState();
}

class GuardingRateDetailsViewState extends State<GuardingRateDetailsView> {
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
      // drawer: navigationDrawer1(scaffoldKey),
      appBar: BaseAppBar().buildAppHeader(
        context: context,
        title: widget.title,
        showPopUp: false,
        showSaveButton: false,
        showSubmitButton: false,
        showDisLikeButton: false,
        showLikeButton: false,
      ),
      body: BlocConsumer<PayRateCubit, PayRateState>(
        listener: (context, state) {
          if (state.status == FormStatus.error) {
            log('--if-ssss--${state.status}-----');

            Validator().showToast(
              context,
              state.message ?? 'Invalid Information',
            );
          }

          if (state.status == FormStatus.success) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Container(
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
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.0)),
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
                          // GuardingRectangle(rate: widget.rate),

                          buildTwoColumnLayout(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget submitButtonDisplay() {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        Navigator.pushNamed(context, guardingRatesRoute,
            arguments: {"Guarding Rates": true});
        // FocusScope.of(context).unfocus();
        // BlocProvider.of<PayRateCubit>(context).onSave(isSubmit: true);
      },
    );
  }

  Widget buildTwoColumnLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                BlocProvider.of<PayRateCubit>(context).updateModelValue();
                Navigator.pushNamed(context, guardingRatesGRIRoute, arguments: {
                  "title": Constants.createGuardingRatingCards,
                  "gmRate": widget.rate,
                });
              },
              child: buildRectangleBox(
                imageAsset: 'assets/images/dollar.png',
                text: Constants.guardingRatingInformation,
                bottomPadding: 8,
              ),
            ),
            const SizedBox(width: 19),
            InkWell(
              onTap: () async {
                BlocProvider.of<PayRateCubit>(context).updateModelValue();
                Navigator.pushNamed(scaffoldKey.currentContext!, payRateRoute,
                    arguments: {
                      "title": Constants.createSecurityGuard,
                      "payRates": widget.rate.securityGuardRates ?? [],
                      "gmRate": widget.rate,
                    });
              },
              child: buildRectangleBox(
                imageAsset: 'assets/images/security.png',
                text: 'Security Guard',
                bottomPadding: 22,
              ),
            ),
          ],
        ),
        const SizedBox(height: 19), // Add spacing between the columns
        Row(
          children: [
            InkWell(
              onTap: () {
                BlocProvider.of<PayRateCubit>(context).updateModelValue();
                Navigator.pushNamed(context, payRateRoute, arguments: {
                  "title": Constants.createSecuritySupervisor,
                  "payRates": widget.rate.securitySupervisorRates ?? [],
                  "gmRate": widget.rate,
                });
              },
              child: buildRectangleBox(
                imageAsset: 'assets/images/security.png',
                text: 'Security Supervisor',
                // Add the text
                bottomPadding: 22,
              ),
            ),
            const SizedBox(width: 19), // Add some spacing between the boxes
            InkWell(
              onTap: () {
                BlocProvider.of<PayRateCubit>(context).updateModelValue();
                Navigator.pushNamed(context, payRateRoute, arguments: {
                  "title": Constants.createSecurityOfficer,
                  "payRates": widget.rate.securityGuardRates ?? [],
                  "gmRate": widget.rate,
                });
              },
              child: buildRectangleBox(
                imageAsset: 'assets/images/security.png',
                text: 'Security Officer',
                bottomPadding: 22,
              ),
            ),
          ],
        ),
        const SizedBox(height: 19),
        Row(
          children: [
            InkWell(
              onTap: () {
                BlocProvider.of<PayRateCubit>(context).updateModelValue();
                Navigator.pushNamed(context, payRateRoute, arguments: {
                  "title": Constants.createSecurityFacilitator,
                  "payRates": widget.rate.securityFacilitatorRates ?? [],
                  "gmRate": widget.rate,
                });
              },
              child: buildRectangleBox(
                imageAsset: 'assets/images/security.png',
                text: 'Security Facilitator',
                bottomPadding: 22,
              ),
            ),
            const SizedBox(width: 19), // Add some spacing between the boxes
            InkWell(
              onTap: () {
                BlocProvider.of<PayRateCubit>(context).updateModelValue();
                Navigator.pushNamed(context, payRateRoute, arguments: {
                  "title": Constants.createGunMan,
                  "payRates": widget.rate.securityGunManRates ?? [],
                  "gmRate": widget.rate,
                });
              },
              child: buildRectangleBox(
                imageAsset: 'assets/images/securityGunMan.png',
                text: 'Gun Man',
                bottomPadding: 22,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30), // Add some spacing between the boxes
        Center(
          child: submitButtonDisplay(),
        ),
      ],
    );
  }

  Widget buildRectangleBox({
    required String imageAsset,
    required String text,
    required double bottomPadding,
  }) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.42,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.4),
            spreadRadius: 1.0,
            blurRadius: 4.0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              imageAsset,
              width: 69,
              height: 110,
            ),
          ),
          Positioned(
            bottom: bottomPadding, // Use the provided bottom padding
            left: 0,
            right: 0,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Styles.styleHeaderGreyText16,
            ),
          ),
        ],
      ),
    );
  }
}
