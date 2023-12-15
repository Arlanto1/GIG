import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/common_widgets/cubits.dart';
import 'package:db_atom/src/features/dashboard/dashboard_screen/charts/cubits/charts_cubit.dart';
import 'package:db_atom/src/features/dashboard/dashboard_screen/charts/views/charts/base_bar_charts.dart';
import 'package:db_atom/src/features/dashboard/dashboard_screen/charts/views/charts/base_bubble_charts.dart';

import 'charts/base_pie_charts.dart';

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
    log('-DashboardView---initState--');
    super.initState();
    chartsCubit.initializeValues();
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    userName = await SharedPrefs.getUsername();
    email = await SharedPrefs.getEmail();
    log('username : $userName email is : $email');
    setState(() {});
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChartsCubit, ChartsState>(
      listener: (context, state) {
        if (state.status == FormStatus.sessionExpired) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.message ?? 'Session Expired...')));
          Validator.logoutAction(context);
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
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const ArticleDialog(
                        labels: languagesDropDownValues,
                        title: 'Choose Language',
                      );
                    },
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.translate,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, notificationViewRoute);
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
            // backgroundColor: AppColors.navigationSkybluecolor,
            backBtn: IconButton(
              icon:
                  const Icon(Icons.menu, color: AppColors.backgroundWhitecolor),
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
                // scrollDirection: Axis.horizontal,
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: const ShapeDecoration(
                    color: AppColors.backgroundWhitecolor,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.0)),
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
          ),
        );
      },
    );
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
          BaseBubbleChart(
            chartTitle: title,
            moreIcon: SvgPicture.asset(AppIcon.moreicon),
            chartData: chartValues,
          ),
          BaseBarChart(
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
