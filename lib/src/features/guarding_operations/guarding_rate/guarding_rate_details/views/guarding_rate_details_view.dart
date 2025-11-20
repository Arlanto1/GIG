import 'dart:ui';

import 'package:db_atom/index.dart';

class GuardingRateDetailsView extends StatefulWidget {
  final String title;
  final GMRate rate;

  const GuardingRateDetailsView({
    super.key,
    required this.title,
    required this.rate,
  });

  @override
  State<GuardingRateDetailsView> createState() =>
      GuardingRateDetailsViewState();
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
          Utils().formError(state, context);
          Utils().errorAndLogout(state, context);

          if (state.status == FormStatus.success) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Container(
            color: AppColors.lavender,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: const ShapeDecoration(
                          color: AppColors.lavender,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.0)),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            Constants.guardingOfficialRatingCards,
                            style: Styles.textStyleRegularNormalWhite18,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.02),
                          // GuardingRectangle(rate: widget.rate),

                          buildTwoColumnLayout(state),
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

  Widget buildTwoColumnLayout(PayRateState state) {
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
                text: state.labels?.locale.securityGuard ??
                    state.labels?.defaultLocale.securityGuard ??
                    'Security Guard',
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
                text: state.labels?.locale.securitySupervisor ??
                    state.labels?.defaultLocale.securitySupervisor ??
                    'Security Supervisor',
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
                text: state.labels?.locale.securityOfficer ??
                    state.labels?.defaultLocale.securityOfficer ??
                    'Security Officer',
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
                text: state.labels?.locale.securityFacilitator ??
                    state.labels?.defaultLocale.securityFacilitator ??
                    'Security Facilitator',
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
                text: state.labels?.locale.gunMan ??
                    state.labels?.defaultLocale.gunMan ??
                    'Gun Man',
                bottomPadding: 22,
              ),
            ),
          ],
        ),
        const SizedBox(height: 19), //
        // const SizedBox(height: 19), // Add spacing between the columns
        Row(
          children: [
            InkWell(
              onTap: () {
                BlocProvider.of<PayRateCubit>(context).updateModelValue();
                Navigator.pushNamed(context, payRateRoute, arguments: {
                  "title": Constants.createOthers,
                  "payRates": widget.rate.otherRates ?? [],
                  "gmRate": widget.rate,
                });
              },
              child: buildRectangleBox(
                imageAsset: 'assets/images/security.png',
                text: state.labels?.locale.other ??
                    state.labels?.defaultLocale.other ??
                    'Others',
                // Add the text
                bottomPadding: 22,
              ),
            ),
          ],
        ),
        // const SizedBox(height: 19), // Add spacing between the columns
        //     Center(
        //       child: submitButtonDisplay(),
        //     ),
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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF6474C6),
                  Color(0xFF6474C6)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            margin: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8),

            child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 18, sigmaY: 18),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withValues(
                                alpha: 0.2),
                            Colors.transparent,
                            Colors.white.withValues(
                                alpha: 0.2),
                            // Color(0xFF6474C6).withOpacity(0.14)
                          ],
                          stops: [0.02, 0.35, 1],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius
                            .circular(27),
                        border: Border.all(
                          color: Colors.white
                              .withValues(alpha: 0.80),
                          width: 0.8,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                                0xFF6474C6).withValues(
                                alpha: 0.09),
                            blurRadius: 12,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
      width: size.width * 0.42,
      height: 160,
      // decoration: BoxDecoration(
      //   color: AppColors.lavender,
      //   borderRadius: BorderRadius.circular(10.0),
      //   boxShadow: [
      //     BoxShadow(
      //       color: AppColors.white.withValues(alpha: 0.5),
      //       spreadRadius: 1.0,
      //       blurRadius: 4.0,
      //       offset: const Offset(0, 0),
      //     ),
      //   ],
      // ),
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
              style: Styles.textStyleWhite14,
            ),
          ),
        ],
      ),
                    ))));
  }
}
