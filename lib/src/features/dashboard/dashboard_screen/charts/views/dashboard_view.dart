import 'dart:developer';

import 'package:db_atom/index.dart';

import 'charts/base_pyramid_charts.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => DashboardViewState();
}

class DashboardViewState extends State<DashboardView>
    with WidgetsBindingObserver {
  String userName = '';
  String email = '';

  @override
  void initState() {
    log('-DashboardView---initState--');
    super.initState();
    getUserDetails();
    WidgetsBinding.instance.addObserver(this);
    // BlocProvider.of<ChartsCubit>(context).initializeValues();
    chartsCubit.initializeValues();
    // Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<void> getUserDetails() async {
    userName = await SharedPrefs.getUsername();
    email = await SharedPrefs.getEmail();
    log('username : $userName email is : $email');

    // try {
    //   await FCMHandler.initializeFCM();
    //   FCMHandler.setupForegroundMessageHandler();
    //   FCMHandler.setupBackgroundMessageHandler();
    // } catch (e) {
    //   // Handle Firebase initialization error
    //   log('Firebase initialization failed: $e');
    // }
    setState(() {});
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChartsCubit, ChartsState>(
      listener: (context, state) {
        log('-state---${state.status}---');
        Utils().errorAndLogout(state, context);

        if (state.status == FormStatus.sessionExpired) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.message ?? 'Session Expired...')));
          Validator.logoutAction(context);
          InactivityFunctions().logoutUser(navigatorKey);
        }
      },
      bloc: chartsCubit,
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          drawer: NavigationDrawer1(scaffoldKey, userName, email),
          appBar: AppHeader(
            isTitleCenter: false,
            title: Constants.dashboard,
            action: [
              // GestureDetector(
              //   onTap: () {
              //     showDialog(
              //       context: context,
              //       builder: (BuildContext context) {
              //         return const ArticleDialog(
              //           labels: languagesDropDownValues,
              //           title: 'Choose Language',
              //         );
              //       },
              //     );
              //   },
              //   child: const Padding(
              //     padding: EdgeInsets.all(5.0),
              //     child: Icon(
              //       Icons.translate,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              NotificationBell(notificationCount: state.notificationCount ?? 0),
              GestureDetector(
                onTap: () {
                  _logout(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
            // backgroundColor: AppColors.navigationSkyBlueColor,
            backBtn: IconButton(
              icon:
                  const Icon(Icons.menu, color: AppColors.backgroundWhiteColor),
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
          // body: RefreshIndicator(
          //     color: AppColors.navigationSkyBlueColor,
          //     onRefresh: () async {
          //       BlocProvider.of<ChartsCubit>(context).initializeValues();
          //     },
          //     child: getBody(state)),

          body: getBody(state),
        );
      },
    );
  }

  Widget getBody(ChartsState state) {
    log('--getBody---');
    Utils().errorAndLogout(state, context);
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }
    return Container(
      color: AppColors.navigationSkyBlueColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: SingleChildScrollView(
          // scrollDirection: Axis.horizontal,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const ShapeDecoration(
              color: AppColors.backgroundWhiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
            ),
            child: Column(
              children: [
                buildChartHorizontalWidget(
                    title: Constants.lawEnforcementVisitsByEntity,
                    chartValues: state.lawEnforcementVisitByEntity ?? []),
                buildChartHorizontalWidget(
                    title: Constants.lawEnforcementVisitsByRegion,
                    chartValues: state.lawEnforcementVisitByRegion ?? []),
                buildChartHorizontalWidget(
                    title: Constants.eventProtectionByRegion,
                    chartValues: state.eventProtectionByRegion ?? []),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _logout(BuildContext context) {
    var dialog = CustomAlertDialog(
        title: Constants.logout,
        message: Constants.logoutValidation,
        onPositivePressed: () {
          Validator.logoutAction(context);
        },
        positiveBtnText: Constants.yes,
        negativeBtnText: Constants.no);
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  SingleChildScrollView buildChartHorizontalWidget({
    required String title,
    required List<PieChartData> chartValues,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          BasePieChart(
            chartTitle: title,
            moreIcon: SvgPicture.asset(AppIcon.moreicon),
            chartData: chartValues,
          ),
          BaseVerticleBarCharts(
            chartTitle: title,
            moreIcon: SvgPicture.asset(AppIcon.moreicon),
            chartData: chartValues,
          ),
          BaseBarChart(
            chartTitle: title,
            moreIcon: SvgPicture.asset(AppIcon.moreicon),
            chartData: chartValues,
          ),
          BasePyramidCharts(
            chartTitle: title,
            moreIcon: SvgPicture.asset(AppIcon.moreicon),
            chartData: chartValues,
          ),
          // Add more charts as needed
        ],
      ),
    );
  }
}
