// // // import 'dart:developer';
// // // import 'dart:ui';
// // // import 'package:db_atom/index.dart';
// // //
// // // class DashboardView extends StatefulWidget {
// // //   const DashboardView({super.key});
// // //
// // //   @override
// // //   State<DashboardView> createState() => DashboardViewState();
// // // }
// // //
// // // class DashboardViewState extends State<DashboardView>
// // //     with WidgetsBindingObserver {
// // //   String userName = '';
// // //   String email = '';
// // //
// // //   @override
// // //   void initState() {
// // //     log('-DashboardView---initState--');
// // //     super.initState();
// // //     getUserDetails();
// // //     WidgetsBinding.instance.addObserver(this);
// // //     chartsCubit.initializeValues();
// // //   }
// // //
// // //   Future<void> getUserDetails() async {
// // //     userName = await SharedPrefs.getUsername();
// // //     email = await SharedPrefs.getEmail();
// // //     if (!mounted) return;
// // //     setState(() {});
// // //   }
// // //
// // //   final scaffoldKey = GlobalKey<ScaffoldState>();
// // //
// // //   bool isToggled = false;
// // //
// // //   void _onToggleChanged(bool value) async {
// // //     setState(() {
// // //       isToggled = value;
// // //     });
// // //     await setLogsToggle(value);
// // //   }
// // //
// // //   static Future<void> setLogsToggle(bool value) async {
// // //     SharedPrefs.setLogsToggle(value);
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return BlocConsumer<ChartsCubit, ChartsState>(
// // //       listener: (context, state) {
// // //         log('-state---${state.status}---');
// // //         Utils().errorAndLogout(state, context);
// // //
// // //         if (state.status == FormStatus.sessionExpired) {
// // //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// // //               backgroundColor: Colors.red,
// // //               content: Text(state.message ?? 'Session Expired...')));
// // //           Validator.logoutAction(context);
// // //           InactivityFunctions().logoutUser(navigatorKey);
// // //         }
// // //       },
// // //       bloc: chartsCubit,
// // //       builder: (context, state) {
// // //         return Scaffold(
// // //           extendBody: true,
// // //           extendBodyBehindAppBar: true,
// // //           key: scaffoldKey,
// // //           drawer: NavigationDrawer1(scaffoldKey, userName, email),
// // //           appBar: AppHeader(
// // //             backgroundColour: Colors.transparent,
// // //             isTitleCenter: false,
// // //             title: Constants.dashboard,
// // //             action: [
// // //               if (Environment().config.apiHost.contains('api.qa.')) ...[
// // //                 const Text(
// // //                   'Logs',
// // //                   style: TextStyle(color: AppColors.white),
// // //                 ),
// // //                 Switch(
// // //                   value: isToggled,
// // //                   onChanged: _onToggleChanged,
// // //                 ),
// // //               ],
// // //
// // //               NotificationBell(notificationCount: state.notificationCount ?? 0),
// // //               GestureDetector(
// // //                 onTap: () {
// // //                   _logout(context);
// // //                 },
// // //                 child: const Padding(
// // //                   padding: EdgeInsets.all(5.0),
// // //                   child: Icon(
// // //                     Icons.logout,
// // //                     color: Colors.white,
// // //                   ),
// // //                 ),
// // //               ),
// // //             ],
// // //             // backgroundColor: AppColors.navigationSkyBlueColor,
// // //             backBtn: IconButton(
// // //               icon:
// // //               const Icon(Icons.menu, color: AppColors.backgroundWhiteColor),
// // //               onPressed: () {
// // //                 if (scaffoldKey.currentState!.isDrawerOpen) {
// // //                   scaffoldKey.currentState!.closeDrawer();
// // //                   //close drawer, if drawer is open
// // //                 } else {
// // //                   scaffoldKey.currentState!.openDrawer();
// // //                   //open drawer, if drawer is closed
// // //                 }
// // //               },
// // //             ),
// // //           ),
// // //           // body: RefreshIndicator(
// // //           //     color: AppColors.navigationSkyBlueColor,
// // //           //     onRefresh: () async {
// // //           //       BlocProvider.of<ChartsCubit>(context).initializeValues();
// // //           //     },
// // //           //     child: getBody(state)),
// // //
// // //           /// Bottom Navigation Bar
// // //           bottomNavigationBar:
// // //           state.displayMenu != null
// // //               ? CustomBottomNavigationBar(
// // //             hasAddPermission: false,
// // //             scaffoldKey: scaffoldKey,
// // //             context: context,
// // //             displayMenu: state.displayMenu!,
// // //           )
// // //               : const SizedBox(),
// // //
// // //           body: getBody(state),
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   Widget getBody(ChartsState state) {
// // //     Utils().errorAndLogout(state, context);
// // //
// // //     if (state.status == FormStatus.loading) {
// // //       return const BaseLoader();
// // //     }
// // //
// // //     return Stack(
// // //       children: [
// // //         //  Full screen Background Image
// // //         Positioned.fill(
// // //           child: Image.asset(
// // //             'assets/images/bg2.png',
// // //             fit: BoxFit.cover,
// // //           ),
// // //         ),
// // //
// // //         // 🔹 Global Blur Layer
// // //         Positioned.fill(
// // //           child: ClipRect(
// // //             child: BackdropFilter(
// // //               filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
// // //               child: Container(
// // //                 color: Colors.black.withValues(alpha: 0.08), // soft tint
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //
// // //         //  Content
// // //         SafeArea(
// // //           top: true, // respects status bar
// // //           bottom: false,
// // //           child: Padding(
// // //             // padding: const EdgeInsets.only(
// // //             //   top: kToolbarHeight, // pushes content below AppBar
// // //             // ),
// // //     padding: const EdgeInsets.only(top: kToolbarHeight + -30),
// // //
// // //     child: SingleChildScrollView(
// // //               child: Column(
// // //                 children: [
// // //                   buildChartHorizontalWidget(
// // //                     title: Constants.lawEnforcementVisitsByEntity,
// // //                     chartValues: state.lawEnforcementVisitByEntity ?? [],
// // //                   ),
// // //                   const SizedBox(height: 20),
// // //                   buildChartHorizontalWidget(
// // //                     title: Constants.lawEnforcementVisitsByRegion,
// // //                     chartValues: state.lawEnforcementVisitByRegion ?? [],
// // //                   ),
// // //                   const SizedBox(height: 20),
// // //                   buildChartHorizontalWidget(
// // //                     title: Constants.eventProtectionByRegion,
// // //                     chartValues: state.eventProtectionByRegion ?? [],
// // //                   ),
// // //                   const SizedBox(height: 150),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //
// // //   _logout(BuildContext context) {
// // //     var dialog = CustomAlertDialog(
// // //       title: Constants.logout,
// // //       message: Constants.logoutValidation,
// // //       onPositivePressed: () {
// // //         CommonServices().unlock();
// // //         Validator.logoutAction(context);
// // //       },
// // //       positiveBtnText: Constants.yes,
// // //       negativeBtnText: Constants.no,
// // //     );
// // //     showDialog(context: context, builder: (BuildContext context) => dialog);
// // //   }
// // //
// // //   Widget buildChartHorizontalWidget({
// // //     required String title,
// // //     required List<PieChartData> chartValues,
// // //   }) {
// // //     final media = MediaQuery.of(context);
// // //     final isTablet = media.size.shortestSide >= 600;
// // //     final isLandscape = media.orientation == Orientation.landscape;
// // //
// // //     final charts = [
// // //       BaseDonutChart(
// // //         chartTitle: title,
// // //         moreIcon: SvgPicture.asset(AppIcon.moreIcon),
// // //         chartData: chartValues,
// // //       ),
// // //       BaseVerticalBarCharts(
// // //         chartTitle: title,
// // //         moreIcon: SvgPicture.asset(AppIcon.moreIcon),
// // //         chartData: chartValues,
// // //       ),
// // //       BasePieChart(
// // //         chartTitle: title,
// // //         moreIcon: SvgPicture.asset(AppIcon.moreIcon),
// // //         chartData: chartValues,
// // //       ),
// // //     ];
// // //
// // //     /// TABLET + LANDSCAPE → GRID
// // //     if (isTablet && isLandscape) {
// // //       // return Padding(
// // //         // padding: const EdgeInsets.symmetric(vertical: 10),
// // //       return GridView.builder(
// // //           shrinkWrap: true,
// // //           physics: const NeverScrollableScrollPhysics(),
// // //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //             crossAxisCount: 3,
// // //             mainAxisSpacing: 14,
// // //             crossAxisSpacing: 14,
// // //             childAspectRatio: 1.35, //
// // //           ),
// // //           itemCount: charts.length,
// // //           itemBuilder: (_, index) => charts[index],
// // //         );
// // //       // );
// // //     }
// // //
// // //     ///  MOBILE + PORTRAIT → HORIZONTAL SWIPE
// // //     return SizedBox(
// // //       height: media.size.height * 0.45,
// // //       child: ListView.builder(
// // //         scrollDirection: Axis.horizontal,
// // //         itemCount: charts.length,
// // //         itemBuilder: (_, index) {
// // //           return SizedBox(
// // //             width: media.size.width,
// // //             child: charts[index],
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// // import 'dart:developer';
// // import 'package:db_atom/index.dart';
// //
// // class DashboardView extends StatefulWidget {
// //   const DashboardView({super.key});
// //
// //   @override
// //   State<DashboardView> createState() => DashboardViewState();
// // }
// //
// // class DashboardViewState extends State<DashboardView>
// //     with WidgetsBindingObserver {
// //   String userName = '';
// //   String email = '';
// //
// //   @override
// //   void initState() {
// //     log('-DashboardView---initState--');
// //     super.initState();
// //     getUserDetails();
// //     WidgetsBinding.instance.addObserver(this);
// //     chartsCubit.initializeValues();
// //   }
// //
// //   @override
// //   void dispose() {
// //     WidgetsBinding.instance.removeObserver(this);
// //     super.dispose();
// //   }
// //
// //   Future<void> getUserDetails() async {
// //     userName = await SharedPrefs.getUsername();
// //     email = await SharedPrefs.getEmail();
// //     if (!mounted) return;
// //     setState(() {});
// //   }
// //
// //   final scaffoldKey = GlobalKey<ScaffoldState>();
// //
// //   bool isToggled = false;
// //
// //   void _onToggleChanged(bool value) async {
// //     setState(() {
// //       isToggled = value;
// //     });
// //     await setLogsToggle(value);
// //   }
// //
// //   static Future<void> setLogsToggle(bool value) async {
// //     SharedPrefs.setLogsToggle(value);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocConsumer<ChartsCubit, ChartsState>(
// //       listener: (context, state) {
// //         log('-state---${state.status}---');
// //         Utils().errorAndLogout(state, context);
// //
// //         if (state.status == FormStatus.sessionExpired) {
// //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //               backgroundColor: Colors.red,
// //               content: Text(state.message ?? 'Session Expired...')));
// //           Validator.logoutAction(context);
// //           InactivityFunctions().logoutUser(navigatorKey);
// //         }
// //       },
// //       bloc: chartsCubit,
// //       builder: (context, state) {
// //         return Scaffold(
// //           backgroundColor: GigColors.lavender,
// //           extendBody: true,
// //           extendBodyBehindAppBar: true,
// //           key: scaffoldKey,
// //           drawer: NavigationDrawer1(scaffoldKey, userName, email),
// //           appBar: AppHeader(
// //             backgroundColour: Colors.transparent,
// //             isTitleCenter: false,
// //             title: Constants.dashboard,
// //             action: [
// //               if (Environment().config.apiHost.contains('api.qa.')) ...[
// //                 const Text(
// //                   'Logs',
// //                   style: TextStyle(color: AppColors.white),
// //                 ),
// //                 Switch(
// //                   value: isToggled,
// //                   onChanged: _onToggleChanged,
// //                 ),
// //               ],
// //
// //               NotificationBell(notificationCount: state.notificationCount ?? 0),
// //               GestureDetector(
// //                 onTap: () {
// //                   _logout(context);
// //                 },
// //                 child: const Padding(
// //                   padding: EdgeInsets.all(5.0),
// //                   child: Icon(
// //                     Icons.logout,
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //             backBtn: IconButton(
// //               icon:
// //               const Icon(Icons.menu, color: AppColors.backgroundWhiteColor),
// //               onPressed: () {
// //                 if (scaffoldKey.currentState!.isDrawerOpen) {
// //                   scaffoldKey.currentState!.closeDrawer();
// //                   //close drawer, if drawer is open
// //                 } else {
// //                   scaffoldKey.currentState!.openDrawer();
// //                   //open drawer, if drawer is closed
// //                 }
// //               },
// //             ),
// //           ),
// //
// //           /// Bottom Navigation Bar
// //           bottomNavigationBar: state.displayMenu != null
// //               ? CustomBottomNavigationBar(
// //             hasAddPermission: false,
// //             scaffoldKey: scaffoldKey,
// //             context: context,
// //             displayMenu: state.displayMenu!,
// //           )
// //               : const SizedBox(),
// //
// //           body: getBody(state),
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget getBody(ChartsState state) {
// //     Utils().errorAndLogout(state, context);
// //
// //     if (state.status == FormStatus.loading) {
// //       return const BaseLoader();
// //     }
// //
// //     // The AppBar keeps its white title/icons, so give it an indigo band to sit on.
// //     final bandHeight =
// //         MediaQuery.of(context).padding.top + kToolbarHeight + 28;
// //
// //     return Stack(
// //       children: [
// //         Positioned(
// //           top: 0,
// //           left: 0,
// //           right: 0,
// //           height: bandHeight,
// //           child: const DecoratedBox(
// //             decoration: BoxDecoration(
// //               color: GigColors.indigo,
// //               borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
// //             ),
// //           ),
// //         ),
// //
// //         /// Content (starts just below the AppBar, overlapping the band a little)
// //         SafeArea(
// //           top: true,
// //           bottom: false,
// //           child: Padding(
// //             padding: const EdgeInsets.only(top: kToolbarHeight),
// //             child: SingleChildScrollView(
// //               padding: const EdgeInsets.only(top: 16, bottom: 150),
// //               child: _sections(state),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   /// ---------------- CHART CARDS ----------------
// //   Widget _sections(ChartsState state) {
// //     final cards = <Widget>[
// //       BaseGaugeChart(
// //         chartTitle: Constants.lawEnforcementVisitsByEntity,
// //         chartData: state.lawEnforcementVisitByEntity ?? [],
// //       ),
// //       BaseGaugeChart(
// //         chartTitle: Constants.lawEnforcementVisitsByRegion,
// //         chartData: state.lawEnforcementVisitByRegion ?? [],
// //       ),
// //       BaseGaugeChart(
// //         chartTitle: Constants.eventProtectionByRegion,
// //         chartData: state.eventProtectionByRegion ?? [],
// //       ),
// //     ];
// //
// //     return LayoutBuilder(
// //       builder: (context, constraints) {
// //         /// Tablet / wide: 3 columns
// //         if (constraints.maxWidth >= 700) {
// //           final w = (constraints.maxWidth - 16) / 3;
// //           return Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 8),
// //             child: Wrap(
// //               crossAxisAlignment: WrapCrossAlignment.start,
// //               children: [for (final c in cards) SizedBox(width: w, child: c)],
// //             ),
// //           );
// //         }
// //
// //         /// Phone: stacked
// //         return Column(children: cards);
// //       },
// //     );
// //   }
// //
// //   _logout(BuildContext context) {
// //     var dialog = CustomAlertDialog(
// //       title: Constants.logout,
// //       message: Constants.logoutValidation,
// //       onPositivePressed: () {
// //         CommonServices().unlock();
// //         Validator.logoutAction(context);
// //       },
// //       positiveBtnText: Constants.yes,
// //       negativeBtnText: Constants.no,
// //     );
// //     showDialog(context: context, builder: (BuildContext context) => dialog);
// //   }
// // }
//
// import 'dart:developer';
// import 'package:db_atom/index.dart';
//
// class DashboardView extends StatefulWidget {
//   const DashboardView({super.key});
//
//   @override
//   State<DashboardView> createState() => DashboardViewState();
// }
//
// class DashboardViewState extends State<DashboardView>
//     with WidgetsBindingObserver {
//   String userName = '';
//   String email = '';
//
//   @override
//   void initState() {
//     log('-DashboardView---initState--');
//     super.initState();
//     getUserDetails();
//     WidgetsBinding.instance.addObserver(this);
//     chartsCubit.initializeValues();
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   Future<void> getUserDetails() async {
//     userName = await SharedPrefs.getUsername();
//     email = await SharedPrefs.getEmail();
//     if (!mounted) return;
//     setState(() {});
//   }
//
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//
//   bool isToggled = false;
//
//   void _onToggleChanged(bool value) async {
//     setState(() {
//       isToggled = value;
//     });
//     await setLogsToggle(value);
//   }
//
//   static Future<void> setLogsToggle(bool value) async {
//     SharedPrefs.setLogsToggle(value);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ChartsCubit, ChartsState>(
//       listener: (context, state) {
//         log('-state---${state.status}---');
//         Utils().errorAndLogout(state, context);
//
//         if (state.status == FormStatus.sessionExpired) {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               backgroundColor: Colors.red,
//               content: Text(state.message ?? 'Session Expired...')));
//           Validator.logoutAction(context);
//           InactivityFunctions().logoutUser(navigatorKey);
//         }
//       },
//       bloc: chartsCubit,
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: GigColors.lavender,
//           extendBody: true,
//           extendBodyBehindAppBar: false,
//           key: scaffoldKey,
//           drawer: NavigationDrawer1(scaffoldKey, userName, email),
//           appBar: AppHeader(
//             backgroundColour: GigColors.indigo,
//             isTitleCenter: false,
//             title: Constants.dashboard,
//             action: [
//               // if (Environment().config.apiHost.contains('api.qa.')) ...[
//               //   const Text(
//               //     'Logs',
//               //     style: TextStyle(color: AppColors.white),
//               //   ),
//               //   Switch(
//               //     value: isToggled,
//               //     onChanged: _onToggleChanged,
//               //   ),
//               // ],
//
//               NotificationBell(notificationCount: state.notificationCount ?? 0),
//               GestureDetector(
//                 onTap: () {
//                   _logout(context);
//                 },
//                 child: const Padding(
//                   padding: EdgeInsets.all(5.0),
//                   child: Icon(
//                     Icons.logout,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//             backBtn: IconButton(
//               icon:
//               const Icon(Icons.menu, color: AppColors.backgroundWhiteColor),
//               onPressed: () {
//                 if (scaffoldKey.currentState!.isDrawerOpen) {
//                   scaffoldKey.currentState!.closeDrawer();
//                   //close drawer, if drawer is open
//                 } else {
//                   scaffoldKey.currentState!.openDrawer();
//                   //open drawer, if drawer is closed
//                 }
//               },
//             ),
//           ),
//
//           /// Bottom Navigation Bar
//           bottomNavigationBar: state.displayMenu != null
//               ? CustomBottomNavigationBar(
//             hasAddPermission: false,
//             scaffoldKey: scaffoldKey,
//             context: context,
//             displayMenu: state.displayMenu!,
//           )
//               : const SizedBox(),
//
//           body: getBody(state),
//         );
//       },
//     );
//   }
//
//   Widget getBody(ChartsState state) {
//     Utils().errorAndLogout(state, context);
//
//     if (state.status == FormStatus.loading) {
//       return const BaseLoader();
//     }
//
//     // Body starts exactly below the AppBar (no manual top padding needed),
//     // so the cards scroll under the bar's edge with no gap.
//     return SingleChildScrollView(
//       padding: const EdgeInsets.only(top: 12, bottom: 150),
//       child: _sections(state),
//     );
//   }
//
//   /// ---------------- CHART CARDS ----------------
//   Widget _sections(ChartsState state) {
//     final cards = <Widget>[
//       BaseGaugeChart(
//         chartTitle: Constants.lawEnforcementVisitsByEntity,
//         chartData: state.lawEnforcementVisitByEntity ?? [],
//       ),
//       BaseGaugeChart(
//         chartTitle: Constants.lawEnforcementVisitsByRegion,
//         chartData: state.lawEnforcementVisitByRegion ?? [],
//       ),
//       BaseGaugeChart(
//         chartTitle: Constants.eventProtectionByRegion,
//         chartData: state.eventProtectionByRegion ?? [],
//       ),
//     ];
//
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         /// Tablet / wide: 3 columns
//         if (constraints.maxWidth >= 700) {
//           final w = (constraints.maxWidth - 16) / 3;
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Wrap(
//               crossAxisAlignment: WrapCrossAlignment.start,
//               children: [for (final c in cards) SizedBox(width: w, child: c)],
//             ),
//           );
//         }
//
//         /// Phone: stacked
//         return Column(children: cards);
//       },
//     );
//   }
//
//   _logout(BuildContext context) {
//     var dialog = CustomAlertDialog(
//       title: Constants.logout,
//       message: Constants.logoutValidation,
//       onPositivePressed: () {
//         CommonServices().unlock();
//         Validator.logoutAction(context);
//       },
//       positiveBtnText: Constants.yes,
//       negativeBtnText: Constants.no,
//     );
//     showDialog(context: context, builder: (BuildContext context) => dialog);
//   }
// }

// import 'dart:developer';
// import 'package:db_atom/index.dart';
//
//
// class DashboardView extends StatefulWidget {
//   const DashboardView({super.key});
//
//   @override
//   State<DashboardView> createState() => DashboardViewState();
// }
//
// class DashboardViewState extends State<DashboardView>
//     with WidgetsBindingObserver {
//   String userName = '';
//   String email = '';
//
//   @override
//   void initState() {
//     log('-DashboardView---initState--');
//     super.initState();
//     getUserDetails();
//     WidgetsBinding.instance.addObserver(this);
//     chartsCubit.initializeValues();
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   Future<void> getUserDetails() async {
//     userName = await SharedPrefs.getUsername();
//     email = await SharedPrefs.getEmail();
//     if (!mounted) return;
//     setState(() {});
//   }
//
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//
//   bool isToggled = false;
//
//   void _onToggleChanged(bool value) async {
//     setState(() {
//       isToggled = value;
//     });
//     await setLogsToggle(value);
//   }
//
//   static Future<void> setLogsToggle(bool value) async {
//     SharedPrefs.setLogsToggle(value);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ChartsCubit, ChartsState>(
//       listener: (context, state) {
//         log('-state---${state.status}---');
//         Utils().errorAndLogout(state, context);
//
//         if (state.status == FormStatus.sessionExpired) {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               backgroundColor: Colors.red,
//               content: Text(state.message ?? 'Session Expired...')));
//           Validator.logoutAction(context);
//           InactivityFunctions().logoutUser(navigatorKey);
//         }
//       },
//       bloc: chartsCubit,
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: GigColors.lavender,
//           extendBody: true,
//           key: scaffoldKey,
//           drawer: NavigationDrawer1(scaffoldKey, userName, email),
//           appBar: AppHeader(
//             backgroundColour: GigColors.indigo,
//             isTitleCenter: false,
//             title: Constants.dashboard,
//             action: [
//               if (Environment().config.apiHost.contains('api.qa.')) ...[
//                 const Text(
//                   'Logs',
//                   style: TextStyle(color: AppColors.white),
//                 ),
//                 Switch(
//                   value: isToggled,
//                   onChanged: _onToggleChanged,
//                 ),
//               ],
//
//               NotificationBell(notificationCount: state.notificationCount ?? 0),
//               GestureDetector(
//                 onTap: () {
//                   _logout(context);
//                 },
//                 child: const Padding(
//                   padding: EdgeInsets.all(5.0),
//                   child: Icon(
//                     Icons.logout,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//             backBtn: IconButton(
//               icon:
//               const Icon(Icons.menu, color: AppColors.backgroundWhiteColor),
//               onPressed: () {
//                 if (scaffoldKey.currentState!.isDrawerOpen) {
//                   scaffoldKey.currentState!.closeDrawer();
//                   //close drawer, if drawer is open
//                 } else {
//                   scaffoldKey.currentState!.openDrawer();
//                   //open drawer, if drawer is closed
//                 }
//               },
//             ),
//           ),
//
//           /// Bottom Navigation Bar
//           bottomNavigationBar: state.displayMenu != null
//               ? CustomBottomNavigationBar(
//             hasAddPermission: false,
//             scaffoldKey: scaffoldKey,
//             context: context,
//             displayMenu: state.displayMenu!,
//           )
//               : const SizedBox(),
//
//           body: getBody(state),
//         );
//       },
//     );
//   }
//
//   Widget getBody(ChartsState state) {
//     Utils().errorAndLogout(state, context);
//
//     if (state.status == FormStatus.loading) {
//       return const BaseLoader();
//     }
//
//     // Body starts exactly below the AppBar (no manual top padding needed),
//     // so the cards scroll under the bar's edge with no gap.
//     return SingleChildScrollView(
//       padding: const EdgeInsets.only(top: 12, bottom: 150),
//       child: _sections(state),
//     );
//   }
//
//   /// ---------------- CHART CARDS ----------------
//   Widget _sections(ChartsState state) {
//
//     CommonWidgets.textDisplay(
//             Constants.status,
//         Styles.textStyleAppBar,
//         isMandatory: true);
//     final cards = <Widget>[
//       BaseGaugeChart(
//         chartTitle: Constants.lawEnforcementVisitsByEntity,
//         chartData: state.lawEnforcementVisitByEntity ?? [],
//       ),
//       BaseGaugeChart(
//         chartTitle: Constants.lawEnforcementVisitsByRegion,
//         chartData: state.lawEnforcementVisitByRegion ?? [],
//       ),
//       BaseGaugeChart(
//         chartTitle: Constants.eventProtectionByRegion,
//         chartData: state.eventProtectionByRegion ?? [],
//       ),
//     ];
//
//     /// Planner / Todos calendar shown above the charts.
//     /// TODO: replace the empty list with your real todos/planner data
//     /// (e.g. state.plannerEvents) and open your details screen in onViewDetails.
//     final planner = PlannerCalendarCard(
//       events: const <PlannerEvent>[],
//       onViewDetails: (event) {
//         log('View details: ${event.id}');
//       },
//     );
//
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         /// Tablet / wide: 3 columns
//         if (constraints.maxWidth >= 700) {
//           final w = (constraints.maxWidth - 16) / 3;
//           return Column(
//             children: [
//               planner,
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child: Wrap(
//                   crossAxisAlignment: WrapCrossAlignment.start,
//                   children: [
//                     for (final c in cards) SizedBox(width: w, child: c)
//                   ],
//                 ),
//               ),
//             ],
//           );
//         }
//
//         /// Phone: stacked
//         return Column(children: [planner, ...cards]);
//       },
//     );
//   }
//
//   _logout(BuildContext context) {
//     var dialog = CustomAlertDialog(
//       title: Constants.logout,
//       message: Constants.logoutValidation,
//       onPositivePressed: () {
//         CommonServices().unlock();
//         Validator.logoutAction(context);
//       },
//       positiveBtnText: Constants.yes,
//       negativeBtnText: Constants.no,
//     );
//     showDialog(context: context, builder: (BuildContext context) => dialog);
//   }
// }


import 'dart:developer';
import 'dart:math' as math;
import 'package:db_atom/index.dart';


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
    chartsCubit.initializeValues();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> getUserDetails() async {
    userName = await SharedPrefs.getUsername();
    email = await SharedPrefs.getEmail();
    if (!mounted) return;
    setState(() {});
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isToggled = false;

  void _onToggleChanged(bool value) async {
    setState(() {
      isToggled = value;
    });
    await setLogsToggle(value);
  }

  static Future<void> setLogsToggle(bool value) async {
    SharedPrefs.setLogsToggle(value);
  }

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
          backgroundColor: GigColors.lavender,
          extendBody: true,
          key: scaffoldKey,
          drawer: NavigationDrawer1(scaffoldKey, userName, email),
          appBar: AppBar(
            backgroundColor: GigColors.indigo,
            elevation: 0,
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: false,
            titleSpacing: 0,
            leading: IconButton(
              icon: const Icon(Icons.menu, color: AppColors.backgroundWhiteColor),
              onPressed: () {
                if (scaffoldKey.currentState!.isDrawerOpen) {
                  scaffoldKey.currentState!.closeDrawer();
                } else {
                  scaffoldKey.currentState!.openDrawer();
                }
              },
            ),

            /// GIG logo
            title: const Align(
              alignment: Alignment.centerLeft,
              child: GigLogoChip(),
            ),
            actions: [
              if (Environment().config.apiHost.contains('api.qa.')) ...[
                const Text(
                  'Logs',
                  style: TextStyle(color: AppColors.white),
                ),
                Switch(
                  value: isToggled,
                  onChanged: _onToggleChanged,
                ),
              ],
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
              const SizedBox(width: 8),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 1,
                color: Colors.white.withValues(alpha: 0.18),
              ),
            ),
          ),

          /// Bottom Navigation Bar
          bottomNavigationBar: state.displayMenu != null
              ? CustomBottomNavigationBar(
            hasAddPermission: false,
            scaffoldKey: scaffoldKey,
            context: context,
            displayMenu: state.displayMenu!,
          )
              : const SizedBox(),

          body: getBody(state),
        );
      },
    );
  }

  Widget getBody(ChartsState state) {
    Utils().errorAndLogout(state, context);

    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    // Body starts exactly below the AppBar (no manual top padding needed),
    // so the cards scroll under the bar's edge with no gap.
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 12, bottom: 150),
      child: _sections(state),
    );
  }

  /// ---------------- CHART CARDS ----------------
  Widget _sections(ChartsState state) {
    final cards = <Widget>[
      BaseGaugeChart(
        chartTitle: Constants.lawEnforcementVisitsByEntity,
        chartData: state.lawEnforcementVisitByEntity ?? [],
      ),
      BaseGaugeChart(
        chartTitle: Constants.lawEnforcementVisitsByRegion,
        chartData: state.lawEnforcementVisitByRegion ?? [],
      ),
      BaseGaugeChart(
        chartTitle: Constants.eventProtectionByRegion,
        chartData: state.eventProtectionByRegion ?? [],
      ),
    ];

    /// "Dashboard" heading banner (just below the AppBar).
    const heading = DashboardHeading(title: Constants.dashboard, label: '',);

    /// Planner / Todos calendar shown above the charts.
    /// TODO: replace the empty list with your real todos/planner data
    /// (e.g. state.plannerEvents) and open your details screen in onViewDetails.
    final planner = PlannerCalendarCard(
      events: const <PlannerEvent>[],
      onViewDetails: (event) {
        log('View details: ${event.id}');
      },
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        /// Tablet / wide: 3 columns
        if (constraints.maxWidth >= 700) {
          final w = (constraints.maxWidth - 16) / 3;
          return Column(
            children: [
              heading,
              planner,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    for (final c in cards) SizedBox(width: w, child: c)
                  ],
                ),
              ),
            ],
          );
        }

        /// Phone: stacked
        return Column(children: [heading, planner, ...cards]);
      },
    );
  }

  _logout(BuildContext context) {
    var dialog = CustomAlertDialog(
      title: Constants.logout,
      message: Constants.logoutValidation,
      onPositivePressed: () {
        CommonServices().unlock();
        Validator.logoutAction(context);
      },
      positiveBtnText: Constants.yes,
      negativeBtnText: Constants.no,
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}
/// One planner / todo entry shown on the calendar.
class PlannerEvent {
  final String id;
  final String title;
  final DateTime starts;
  final DateTime? deadline;
  final DateTime? created;
  final String? responsible;
  final String? modifiedBy;

  const PlannerEvent({
    required this.id,
    required this.title,
    required this.starts,
    this.deadline,
    this.created,
    this.responsible,
    this.modifiedBy,
  });
}

enum PlannerView { day, week, month }

/// Planner / Todos card.
///  - Phone  (< 640 px wide): compact toolbar, clean month grid, selected-day
///    events and a compact details block underneath.
///  - Tablet (>= 640 px wide): calendar on the left, "Select an event"
///    details panel on the right, filter always visible.
class PlannerCalendarCard extends StatefulWidget {
  final List<PlannerEvent> events;
  final void Function(PlannerEvent event)? onViewDetails;

  const PlannerCalendarCard({
    super.key,
    this.events = const [],
    this.onViewDetails,
  });

  @override
  State<PlannerCalendarCard> createState() => _PlannerCalendarCardState();
}

class _PlannerCalendarCardState extends State<PlannerCalendarCard> {
  static const _months = [
    'January', 'February', 'March', 'April', 'May', 'June', 'July',
    'August', 'September', 'October', 'November', 'December',
  ];
  static const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  late DateTime _focused;
  DateTime? _selectedDay;
  PlannerEvent? _selectedEvent;
  PlannerView _view = PlannerView.month;
  bool _showFilter = false; // phone only
  final _filterCtrl = TextEditingController();
  String _filter = '';

  DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);
  bool _same(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  void initState() {
    super.initState();
    _focused = _dateOnly(DateTime.now());
    _selectedDay = _focused;
  }

  @override
  void dispose() {
    _filterCtrl.dispose();
    super.dispose();
  }

  // ---------------- data helpers ----------------
  bool _matches(PlannerEvent e) =>
      _filter.isEmpty ||
          e.title.toLowerCase().contains(_filter) ||
          (e.responsible ?? '').toLowerCase().contains(_filter);

  List<PlannerEvent> _eventsOn(DateTime day) => widget.events
      .where(_matches)
      .where((e) =>
  _same(e.starts, day) ||
      (e.deadline != null && _same(e.deadline!, day)))
      .toList();

  String _two(int v) => v.toString().padLeft(2, '0');

  String _fmt(DateTime? d) => d == null
      ? '—'
      : '${d.day} ${_months[d.month - 1].substring(0, 3)} ${d.year}, '
      '${_two(d.hour)}:${_two(d.minute)}';

  DateTime get _weekStart => DateTime(
      _focused.year, _focused.month, _focused.day - (_focused.weekday - 1));

  String get _title {
    switch (_view) {
      case PlannerView.month:
        return '${_months[_focused.month - 1]} ${_focused.year}';
      case PlannerView.week:
        final s = _weekStart;
        final e = DateTime(s.year, s.month, s.day + 6);
        final sm = _months[s.month - 1].substring(0, 3);
        final em = _months[e.month - 1].substring(0, 3);
        return s.month == e.month
            ? '${s.day} – ${e.day} $em ${e.year}'
            : '${s.day} $sm – ${e.day} $em ${e.year}';
      case PlannerView.day:
        return '${_focused.day} ${_months[_focused.month - 1]} ${_focused.year}';
    }
  }

  // ---------------- actions ----------------
  void _move(int dir) {
    setState(() {
      switch (_view) {
        case PlannerView.month:
          _focused = DateTime(_focused.year, _focused.month + dir, 1);
          break;
        case PlannerView.week:
          _focused =
              DateTime(_focused.year, _focused.month, _focused.day + 7 * dir);
          _selectedDay = _focused;
          break;
        case PlannerView.day:
          _focused =
              DateTime(_focused.year, _focused.month, _focused.day + dir);
          _selectedDay = _focused;
          break;
      }
      _selectedEvent = null;
    });
  }

  void _goToday() {
    setState(() {
      _focused = _dateOnly(DateTime.now());
      _selectedDay = _focused;
      _selectedEvent = null;
    });
  }

  void _apply() {
    FocusScope.of(context).unfocus();
    setState(() {
      _filter = _filterCtrl.text.trim().toLowerCase();
      _selectedEvent = null;
    });
  }

  void _reset() {
    FocusScope.of(context).unfocus();
    _filterCtrl.clear();
    setState(() {
      _filter = '';
      _view = PlannerView.month;
      _focused = _dateOnly(DateTime.now());
      _selectedDay = _focused;
      _selectedEvent = null;
    });
  }

  void _selectDay(DateTime day) {
    final list = _eventsOn(day);
    setState(() {
      _selectedDay = day;
      _selectedEvent = list.isNotEmpty ? list.first : null;
    });
  }

  // ---------------- build ----------------
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final wide = c.maxWidth >= 640;

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(34),
          boxShadow: [
            BoxShadow(
              color: GigColors.indigo.withValues(alpha: 0.10),
              blurRadius: 34,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(34),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [GigColors.indigo, GigColors.copper],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    wide ? 20 : 14, 16, wide ? 20 : 14, wide ? 20 : 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Planner / Todos',
                      style: TextStyle(
                        fontFamily: kGigFont,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: GigColors.indigo,
                      ),
                    ),
                    const SizedBox(height: 12),
                    wide ? _toolbarWide() : _toolbarNarrow(),
                    const SizedBox(height: 14),
                    wide ? _bodyWide() : _bodyNarrow(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // ---------------- toolbars ----------------
  Widget _toolbarNarrow() {
    return Column(
      children: [
        Row(
          children: [
            _pill('Today', filled: true, onTap: _goToday),
            const Spacer(),
            _segmented(compact: true),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _circleIcon(Icons.chevron_left, () => _move(-1)),
            Expanded(
              child: Center(
                child: Text(
                  _title,
                  style: const TextStyle(
                    fontFamily: kGigFont,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: GigColors.indigo,
                  ),
                ),
              ),
            ),
            _circleIcon(Icons.chevron_right, () => _move(1)),
            const SizedBox(width: 8),
            _circleIcon(
              _filter.isNotEmpty ? Icons.filter_alt : Icons.filter_alt_outlined,
                  () => setState(() => _showFilter = !_showFilter),
              active: _showFilter || _filter.isNotEmpty,
            ),
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.topCenter,
          child: _showFilter
              ? Padding(
            padding: const EdgeInsets.only(top: 10),
            child: _filterRow(),
          )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }

  Widget _toolbarWide() {
    return Column(
      children: [
        Row(
          children: [
            _pill('Today', filled: true, onTap: _goToday),
            const SizedBox(width: 8),
            _circleIcon(Icons.chevron_left, () => _move(-1)),
            const SizedBox(width: 8),
            _circleIcon(Icons.chevron_right, () => _move(1)),
            Expanded(
              child: Center(
                child: Text(
                  _title,
                  style: const TextStyle(
                    fontFamily: kGigFont,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: GigColors.indigo,
                  ),
                ),
              ),
            ),
            _segmented(),
          ],
        ),
        const SizedBox(height: 12),
        _filterRow(),
      ],
    );
  }

  Widget _filterRow() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _filterCtrl,
            onSubmitted: (_) => _apply(),
            style: const TextStyle(
              fontFamily: kGigFont,
              fontSize: 13,
              color: GigColors.indigo,
            ),
            decoration: InputDecoration(
              hintText: 'Filter',
              hintStyle: const TextStyle(color: GigColors.muted),
              isDense: true,
              filled: true,
              fillColor: GigColors.lavender,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        _pill('Apply', filled: true, onTap: _apply),
        const SizedBox(width: 8),
        _pill('Reset', onTap: _reset),
      ],
    );
  }

  Widget _segmented({bool compact = false}) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: GigColors.lavender,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final v in PlannerView.values)
            GestureDetector(
              onTap: () => setState(() {
                _view = v;
                _selectedEvent = null;
                if (v != PlannerView.month) _focused = _selectedDay ?? _focused;
              }),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                    horizontal: compact ? 12 : 18, vertical: 9),
                decoration: BoxDecoration(
                  color: _view == v ? GigColors.indigo : Colors.transparent,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  v.name[0].toUpperCase() + v.name.substring(1),
                  style: TextStyle(
                    fontFamily: kGigFont,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: _view == v ? Colors.white : GigColors.indigo,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _pill(String label, {bool filled = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 40),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: filled ? GigColors.indigo : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border:
          Border.all(color: filled ? GigColors.indigo : GigColors.border),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: kGigFont,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: filled ? Colors.white : GigColors.indigo,
          ),
        ),
      ),
    );
  }

  Widget _circleIcon(IconData icon, VoidCallback onTap, {bool active = false}) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: active ? GigColors.indigo : Colors.white,
          shape: BoxShape.circle,
          border:
          Border.all(color: active ? GigColors.indigo : GigColors.border),
        ),
        child: Icon(icon,
            size: 20, color: active ? Colors.white : GigColors.indigo),
      ),
    );
  }

  // ---------------- bodies ----------------
  Widget _bodyNarrow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_view != PlannerView.day) ...[
          _weekdayHeader(),
          const SizedBox(height: 2),
          _view == PlannerView.month ? _monthGrid(44) : _weekRow(56),
          const SizedBox(height: 8),
          const Divider(height: 1, color: GigColors.border),
          const SizedBox(height: 12),
        ],
        _dayHeading(),
        const SizedBox(height: 8),
        _eventList(),
        if (_selectedEvent != null) ...[
          const SizedBox(height: 10),
          _compactDetails(_selectedEvent!),
        ],
      ],
    );
  }

  Widget _bodyWide() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_view != PlannerView.day) ...[
                _weekdayHeader(),
                const SizedBox(height: 2),
                _view == PlannerView.month ? _monthGrid(54) : _weekRow(68),
                const SizedBox(height: 8),
                const Divider(height: 1, color: GigColors.border),
                const SizedBox(height: 12),
              ],
              _dayHeading(),
              const SizedBox(height: 8),
              _eventList(),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(flex: 4, child: _detailsPanel()),
      ],
    );
  }

  // ---------------- calendar ----------------
  Widget _weekdayHeader() {
    return Row(
      children: [
        for (final d in _weekdays)
          Expanded(
            child: Center(
              child: Text(
                d,
                style: const TextStyle(
                  fontFamily: kGigFont,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: GigColors.muted,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _monthGrid(double cellHeight) {
    final first = DateTime(_focused.year, _focused.month, 1);
    final leading = first.weekday - 1;
    final daysInMonth = DateTime(first.year, first.month + 1, 0).day;
    final weeks = ((leading + daysInMonth) / 7).ceil();

    return Column(
      children: [
        for (int w = 0; w < weeks; w++)
          Row(
            children: [
              for (int c = 0; c < 7; c++)
                Expanded(
                  child: _dayCell(
                    DateTime(first.year, first.month, 1 - leading + w * 7 + c),
                    first.month,
                    cellHeight,
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _weekRow(double cellHeight) {
    final s = _weekStart;
    return Row(
      children: [
        for (int i = 0; i < 7; i++)
          Expanded(
            child: _dayCell(DateTime(s.year, s.month, s.day + i),
                DateTime(s.year, s.month, s.day + i).month, cellHeight),
          ),
      ],
    );
  }

  Widget _dayCell(DateTime day, int monthShown, double height) {
    final inMonth = day.month == monthShown;
    final isToday = _same(day, DateTime.now());
    final isSelected = _selectedDay != null && _same(day, _selectedDay!);
    final count = _eventsOn(day).length;
    final circle = height >= 54 ? 38.0 : 34.0;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _selectDay(day),
      child: SizedBox(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: circle,
              height: circle,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isToday ? GigColors.indigo : Colors.transparent,
                border: isSelected
                    ? Border.all(color: GigColors.copper, width: 1.8)
                    : null,
              ),
              child: Text(
                '${day.day}',
                style: TextStyle(
                  fontFamily: kGigFont,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isToday
                      ? Colors.white
                      : inMonth
                      ? GigColors.indigo
                      : GigColors.muted.withValues(alpha: 0.45),
                ),
              ),
            ),
            const SizedBox(height: 3),
            SizedBox(
              height: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < count.clamp(0, 3); i++)
                    Container(
                      width: 5,
                      height: 5,
                      margin: const EdgeInsets.symmetric(horizontal: 1.5),
                      decoration: const BoxDecoration(
                        color: GigColors.copper,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- selected day ----------------
  Widget _dayHeading() {
    final day = _selectedDay ?? _focused;
    final count = _eventsOn(day).length;
    return Row(
      children: [
        Expanded(
          child: Text(
            '${_weekdays[day.weekday - 1]}, ${day.day} '
                '${_months[day.month - 1].substring(0, 3)}',
            style: const TextStyle(
              fontFamily: kGigFont,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: GigColors.indigo,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: GigColors.lavender,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            count == 1 ? '1 event' : '$count events',
            style: const TextStyle(
              fontFamily: kGigFont,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: GigColors.muted,
            ),
          ),
        ),
      ],
    );
  }

  Widget _eventList() {
    final list = _eventsOn(_selectedDay ?? _focused);

    if (list.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'Nothing planned for this day',
          style: TextStyle(
            fontFamily: kGigFont,
            fontSize: 12,
            color: GigColors.muted,
          ),
        ),
      );
    }

    return Column(
      children: [
        for (final e in list)
          GestureDetector(
            onTap: () => setState(() => _selectedEvent = e),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: GigColors.lavender,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _selectedEvent?.id == e.id
                      ? GigColors.indigo
                      : Colors.transparent,
                  width: 1.4,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 34,
                    decoration: BoxDecoration(
                      color: GigColors.copper,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: kGigFont,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: GigColors.indigo,
                          ),
                        ),
                        Text(
                          '${_two(e.starts.hour)}:${_two(e.starts.minute)}'
                              '${e.responsible != null ? '  ·  ${e.responsible}' : ''}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: kGigFont,
                            fontSize: 11,
                            color: GigColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  // ---------------- details ----------------
  /// Phone: compact 2-column block, shown only when an event is selected.
  Widget _compactDetails(PlannerEvent e) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: GigColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            e.title,
            style: const TextStyle(
              fontFamily: kGigFont,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: GigColors.indigo,
            ),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(builder: (context, c) {
            final w = (c.maxWidth - 12) / 2;
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _infoTile(w, Icons.person, 'Responsible', e.responsible ?? '—'),
                _infoTile(w, Icons.schedule, 'Starts', _fmt(e.starts)),
                _infoTile(w, Icons.flag, 'Deadline', _fmt(e.deadline)),
                _infoTile(w, Icons.calendar_month, 'Created', _fmt(e.created)),
                _infoTile(w, Icons.edit, 'Modified by', e.modifiedBy ?? '—'),
              ],
            );
          }),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: _pill('View Details',
                filled: true, onTap: () => widget.onViewDetails?.call(e)),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(double width, IconData icon, String label, String value) {
    return SizedBox(
      width: width,
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFEEEAFB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 18, color: GigColors.indigo),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: kGigFont,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: GigColors.muted,
                  ),
                ),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: kGigFont,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: GigColors.indigo,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Tablet: always-visible "Select an event" panel on the right.
  Widget _detailsPanel() {
    final e = _selectedEvent;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: GigColors.lavender,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            e?.title ?? 'Select an event',
            style: const TextStyle(
              fontFamily: kGigFont,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: GigColors.indigo,
            ),
          ),
          const SizedBox(height: 14),
          _infoRow(Icons.person, 'Responsible', e?.responsible ?? '—'),
          _infoRow(Icons.schedule, 'Starts', _fmt(e?.starts)),
          _infoRow(Icons.flag, 'Deadline', _fmt(e?.deadline)),
          _infoRow(Icons.calendar_month, 'Created', _fmt(e?.created)),
          _infoRow(Icons.edit, 'Modified by', e?.modifiedBy ?? '—'),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Opacity(
              opacity: e == null ? 0.4 : 1,
              child: _pill(
                'View Details',
                filled: true,
                onTap: e == null ? null : () => widget.onViewDetails?.call(e),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: 20, color: GigColors.indigo),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: kGigFont,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: GigColors.muted,
                  ),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: kGigFont,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: GigColors.indigo,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class GigLogoChip extends StatelessWidget {
  final double height;
  final String assetPath;
  final bool plate;

  const GigLogoChip({
    super.key,
    this.height = 36,
    this.assetPath = AppIcon.gigLogoAsset,
    this.plate = true,
  });

  @override
  Widget build(BuildContext context) {
    final logo = Image.asset(
      assetPath,
      fit: BoxFit.contain,
    );

    if (!plate) {
      return SizedBox(height: height, child: logo);
    }

    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: logo,
    );
  }
}
/// "Dashboard" heading banner shown just below the AppBar.
class DashboardHeading extends StatelessWidget {
  final String title;
  final String label;

  const DashboardHeading({
    super.key,
    required this.title, required this.label,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      padding: const EdgeInsets.fromLTRB(20, 18, 16, 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Color(0xFFEFEBFC)],
        ),
        border: Border.all(color: GigColors.border),
        boxShadow: [
          BoxShadow(
            color: GigColors.indigo.withValues(alpha: 0.08),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: kGigFont,
                    fontSize: 11,
                    letterSpacing: 1.6,
                    color: GigColors.muted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: kGigFont,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    height: 1.15,
                    color: GigColors.indigo,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 160,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    gradient: const LinearGradient(
                      colors: [GigColors.indigo, GigColors.copper],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const SizedBox(
            width: 84,
            height: 48,
            child: CustomPaint(painter: _MiniArcPainter()),
          ),
        ],
      ),
    );
  }
}

/// Small decorative tick arc (echoes the gauge charts).
class _MiniArcPainter extends CustomPainter {
  const _MiniArcPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const n = 22;
    final center = Offset(size.width / 2, size.height - 2);
    final outer = size.width / 2 - 2;
    final inner = outer * 0.68;
    final p = Paint()
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < n; i++) {
      final a = math.pi + math.pi * i / (n - 1);
      final d = Offset(math.cos(a), math.sin(a));
      p.color =
      Color.lerp(GigColors.indigo, GigColors.copper, i / (n - 1))!;
      canvas.drawLine(center + d * inner, center + d * outer, p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}