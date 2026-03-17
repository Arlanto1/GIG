import 'dart:developer';
import 'dart:ui';
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/news/newsList/newsListView.dart';

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
// //     // BlocProvider.of<ChartsCubit>(context).initializeValues();
// //     chartsCubit.initializeValues();
// //     // Navigator.of(context).popUntil((route) => route.isFirst);
// //   }
// //
// //   Future<void> getUserDetails() async {
// //     userName = await SharedPrefs.getUsername();
// //     email = await SharedPrefs.getEmail();
// //     log('username : $userName email is : $email');
// //
// //     // try {
// //     //   await FCMHandler.initializeFCM();
// //     //   FCMHandler.setupForegroundMessageHandler();
// //     //   FCMHandler.setupBackgroundMessageHandler();
// //     // } catch (e) {
// //     //   // Handle Firebase initialization error
// //     //   log('Firebase initialization failed: $e');
// //     // }
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
// //     // Call the provided function
// //     // instance.setBool(Constants.logsToggle, value);
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
// //           key: scaffoldKey,
// //           drawer: NavigationDrawer1(scaffoldKey, userName, email),
// //           appBar: AppHeader(
// //             isTitleCenter: false,
// //             title: Constants.dashboard,
// //             backgroundColour:  Color(0xFF5026bc),
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
// //               // GestureDetector(
// //               //   onTap: () {
// //               //     showDialog(
// //               //       context: context,
// //               //       builder: (BuildContext context) {
// //               //         return const ArticleDialog(
// //               //           labels: languagesDropDownValues,
// //               //           title: 'Choose Language',
// //               //         );
// //               //       },
// //               //     );
// //               //   },
// //               //   child: const Padding(
// //               //     padding: EdgeInsets.all(5.0),
// //               //     child: Icon(
// //               //       Icons.translate,
// //               //       color: Colors.white,
// //               //     ),
// //               //   ),
// //               // ),
// //               /// to test crash
// //               // TextButton(
// //               //   onPressed: () => throw Exception(),
// //               //   child: const Text("Throw Test Exception"),
// //               // ),
// //
// //               GestureDetector(
// //                 onTap: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                       builder: (_) => const AiChatListView(),
// //                     ),
// //                   );
// //                 },
// //                 child: const Padding(
// //                   padding: EdgeInsets.all(5.0),
// //                   child: Icon(
// //                     Icons.chat,
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //               ),
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
// //             // backgroundColor: AppColors.navigationSkyBlueColor,
// //             backBtn: IconButton(
// //               icon:
// //                   const Icon(Icons.menu, color: AppColors.backgroundWhiteColor),
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
// //           // body: RefreshIndicator(
// //           //     color: AppColors.navigationSkyBlueColor,
// //           //     onRefresh: () async {
// //           //       BlocProvider.of<ChartsCubit>(context).initializeValues();
// //           //     },
// //           //     child: getBody(state)),
// //
// //           /// Bottom Navigation Bar
// //           bottomNavigationBar: state.displayMenu != null
// //               ? CustomBottomNavigationBar(
// //                   scaffoldKey: scaffoldKey,
// //                   context: context,
// //                   displayMenu: state.displayMenu!,
// //                 )
// //               : const SizedBox(),
// //           body: getBody(state),
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget getBody(ChartsState state) {
// //     // log('--getBody---');
// //     Utils().errorAndLogout(state, context);
// //     if (state.status == FormStatus.loading) {
// //       return const BaseLoader();
// //     }
// //     return Container(
// //       decoration: const BoxDecoration(
// //         gradient: LinearGradient(
// //           colors: [
// //             Color(0xFF845EF7),
// //             Color(0xFF6A89CC),
// //             Color(0xFF7589E9),
// //           ],
// //           begin: Alignment.topLeft,
// //           end: Alignment.bottomRight,
// //         ),
// //       ),
// //       // color: AppColors.navigationSkyBlueColor,
// //       // child: Padding(
// //       //   padding: const EdgeInsets.only(top: 10.0),
// //         child: SingleChildScrollView(
// //           // scrollDirection: Axis.horizontal,
// //           // child: Container(
// //           //   padding: const EdgeInsets.all(10.0),
// //             // decoration: const ShapeDecoration(
// //             //   color: AppColors.backgroundWhiteColor,
// //             //   shape: RoundedRectangleBorder(
// //             //     borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
// //             //   ),
// //             // ),
// //             child: Column(
// //               children: [
// //                 buildChartHorizontalWidget(
// //                     title: Constants.lawEnforcementVisitsByEntity,
// //                     chartValues: state.lawEnforcementVisitByEntity ?? []),
// //                 buildChartHorizontalWidget(
// //                     title: Constants.lawEnforcementVisitsByRegion,
// //                     chartValues: state.lawEnforcementVisitByRegion ?? []),
// //                 buildChartHorizontalWidget(
// //                     title: Constants.eventProtectionByRegion,
// //                     chartValues: state.eventProtectionByRegion ?? []),
// //               ],
// //             ),
// //           ),
// //         // ),
// //       // ),
// //     );
// //   }
// //
// //   _logout(BuildContext context) {
// //     var dialog = CustomAlertDialog(
// //         title: Constants.logout,
// //         message: Constants.logoutValidation,
// //         onPositivePressed: () {
// //           CommonServices().unlock();
// //           Validator.logoutAction(context);
// //         },
// //         positiveBtnText: Constants.yes,
// //         negativeBtnText: Constants.no);
// //     showDialog(context: context, builder: (BuildContext context) => dialog);
// //   }
// //
// //   // SingleChildScrollView buildChartHorizontalWidget({
// //   //   required String title,
// //   //   required List<PieChartData> chartValues,
// //   // }) {
// //   //   return SingleChildScrollView(
// //   //     scrollDirection: Axis.horizontal,
// //   //     child: Row(
// //   //       children: [
// //   //         BasePieChart(
// //   //           chartTitle: title,
// //   //           moreIcon: SvgPicture.asset(AppIcon.moreicon),
// //   //           chartData: chartValues,
// //   //         ),
// //   //         BaseVerticleBarCharts(
// //   //           chartTitle: title,
// //   //           moreIcon: SvgPicture.asset(AppIcon.moreicon),
// //   //           chartData: chartValues,
// //   //         ),
// //   //         BaseBarChart(
// //   //           chartTitle: title,
// //   //           moreIcon: SvgPicture.asset(AppIcon.moreicon),
// //   //           chartData: chartValues,
// //   //         ),
// //   //         BasePyramidCharts(
// //   //           chartTitle: title,
// //   //           moreIcon: SvgPicture.asset(AppIcon.moreicon),
// //   //           chartData: chartValues,
// //   //         ),
// //   //         // Add more charts as needed
// //   //       ],
// //   //     ),
// //   //   );
// //   // // }
// //   // import 'package:flutter/material.dart';
// //   // import 'package:flutter_svg/flutter_svg.dart';
// // // import your custom chart widgets
// //
// //   SingleChildScrollView buildChartHorizontalWidget({
// //     required String title,
// //     required List<PieChartData> chartValues,
// //   }) {
// //     List<Widget> chartCards = [
// //       BasePieChart(
// //         chartTitle: title,
// //         moreIcon: SvgPicture.asset(AppIcon.moreicon),
// //         chartData: chartValues,
// //       ),
// //       BaseVerticleBarCharts(
// //         chartTitle: title,
// //         moreIcon: SvgPicture.asset(AppIcon.moreicon),
// //         chartData: chartValues,
// //       ),
// //       BaseBarChart(
// //         chartTitle: title,
// //         moreIcon: SvgPicture.asset(AppIcon.moreicon),
// //         chartData: chartValues,
// //       ),
// //       BasePyramidCharts(
// //         chartTitle: title,
// //         moreIcon: SvgPicture.asset(AppIcon.moreicon),
// //         chartData: chartValues,
// //       ),
// //       // Add more as needed
// //     ];
// //
// //     return SingleChildScrollView(
// //       scrollDirection: Axis.horizontal,
// //       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
// //       child: Row(
// //         children: chartCards.map((chart) {
// //           return Container(
// //             width: 410,
// //             margin: const EdgeInsets.only(right: 16),
// //             decoration: BoxDecoration(
// //               color: Colors.white.withOpacity(0.95),
// //               borderRadius: BorderRadius.circular(20),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.black.withOpacity(0.12),
// //                   blurRadius: 8,
// //                   offset: Offset(0, 4),
// //                 ),
// //               ],
// //             ),
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 // Top row: title + more icon
// //                 Padding(
// //                   padding: const EdgeInsets.only(left: 16, right: 8, top: 14, bottom: 2),
// //                   child: Row(
// //                     children: [
// //                       Expanded(
// //                         child: Text(
// //                           title,
// //                           style: const TextStyle(
// //                             fontWeight: FontWeight.w600,
// //                             fontSize: 16,
// //                           ),
// //                           overflow: TextOverflow.ellipsis,
// //                         ),
// //                       ),
// //                       SvgPicture.asset(AppIcon.moreicon, height: 20, width: 20),
// //                     ],
// //                   ),
// //                 ),
// //                 // Chart content
// //                 Container(
// //                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// //                   child: chart,
// //                   height: 350,
// //                 ),
// //               ],
// //             ),
// //           );
// //         }).toList(),
// //       ),
// //     );
// //   }
// //
// // }
//
//
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
//   Future<void> getUserDetails() async {
//     userName = await SharedPrefs.getUsername();
//     email = await SharedPrefs.getEmail();
//
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
//           key: scaffoldKey,
//           drawer: NavigationDrawer1(scaffoldKey, userName, email),
//           appBar: AppHeader(
//             isTitleCenter: false,
//             title: Constants.dashboard,
//             backgroundColour:  AppColors.newColor,
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
//               // GestureDetector(
//               //   onTap: () {
//               //     showDialog(
//               //       context: context,
//               //       builder: (BuildContext context) {
//               //         return const ArticleDialog(
//               //           labels: languagesDropDownValues,
//               //           title: 'Choose Language',
//               //         );
//               //       },
//               //     );
//               //   },
//               //   child: const Padding(
//               //     padding: EdgeInsets.all(5.0),
//               //     child: Icon(
//               //       Icons.translate,
//               //       color: Colors.white,
//               //     ),
//               //   ),
//               // ),
//               /// to test crash
//               // TextButton(
//               //   onPressed: () => throw Exception(),
//               //   child: const Text("Throw Test Exception"),
//               // ),
//
//               // GestureDetector(
//               //   onTap: () {
//               //     Navigator.push(
//               //       context,
//               //       MaterialPageRoute(
//               //         builder: (_) => const AiChatListView(),
//               //       ),
//               //     );
//               //   },
//               //   child: const Padding(
//               //     padding: EdgeInsets.all(5.0),
//               //     child: Icon(
//               //       Icons.chat,
//               //       color: Colors.white,
//               //     ),
//               //   ),
//               // ),
//               //
//               // GestureDetector(
//               //   onTap: () {
//               //     showMenu(
//               //       context: context,
//               //       position: const RelativeRect.fromLTRB(100, 80, 0, 0), // adjust position
//               //       items: [
//               //         PopupMenuItem(
//               //           child: const Row(
//               //             children: [
//               //               Icon(Icons.chat, size: 20),
//               //               SizedBox(width: 10),
//               //               Text("Chat"),
//               //             ],
//               //           ),
//               //           onTap: () {
//               //             Future.delayed(Duration.zero, () {
//               //               Navigator.push(
//               //                 context,
//               //                 MaterialPageRoute(builder: (_) => const AiChatListView()),
//               //               );
//               //             });
//               //           },
//               //         ),
//               //         PopupMenuItem(
//               //           child: const Row(
//               //             children: [
//               //               Icon(Icons.newspaper, size: 20),
//               //               SizedBox(width: 10),
//               //               Text("News"),
//               //             ],
//               //           ),
//               //           onTap: () {
//               //             Future.delayed(Duration.zero, () {
//               //               // Navigator.push(
//               //               //   context,
//               //               //   MaterialPageRoute(builder: (_) => const NewsScreen()),
//               //               // );
//               //             });
//               //           },
//               //         ),
//               //       ],
//               //     );
//               //   },
//               //   child: const Padding(
//               //     padding: EdgeInsets.all(5.0),
//               //     child: Icon(
//               //       Icons.chat,
//               //       color: Colors.white,
//               //     ),
//               //   ),
//               // ),
//         GestureDetector(
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     barrierColor: Colors.black.withValues(alpha: 0.5),
//                     builder: (context) {
//                       return Stack(
//                         children: [
//                           Positioned(
//                             top: kToolbarHeight + 0,
//                             right: 10,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(20),
//                               child: BackdropFilter(
//                                 filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//                                 child: Container(
//                                   width: 180,
//                                   padding: const EdgeInsets.all(10),
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         AppColors.newColor3.withValues(alpha: 0.2),
//                                         Colors.transparent,
//                                         AppColors.newColor3.withValues(alpha: 0.2),
//                                         // Color(0xFF6474C6).withOpacity(0.14)
//                                       ],
//                                       stops: [0.02, 0.35, 1],
//                                       begin: Alignment.topCenter,
//                                       end: Alignment.bottomCenter,
//                                     ),
//                                     borderRadius: BorderRadius.circular(27),
//                                     border: Border.all(
//                                       color: Colors.white.withValues(alpha: 1),
//                                       width: 0.8,
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: AppColors.newColor.withValues(alpha: 0.2),
//                                         blurRadius: 12,
//                                         offset: const Offset(0, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       // CHAT BUTTON
//                                       GestureDetector(
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                           Navigator.pushNamed(
//                                             context,
//                                             aiChatDetailsRoute,
//                                             arguments: {"title":'ATOM AI Chat'},
//                                           );
//                                         },
//                                         child: Container(
//                                           width: double.infinity,
//                                           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//                                           decoration: BoxDecoration(
//                                             gradient: LinearGradient(
//                                               colors: [
//                                                 Colors.white.withValues(alpha: 0.2),
//                                                 Colors.transparent,
//                                                 Colors.white.withValues(alpha: 0.2),
//                                                 // Color(0xFF6474C6).withOpacity(0.14)
//                                               ],
//                                               stops: [0.02, 0.35, 1],
//                                               begin: Alignment.topCenter,
//                                               end: Alignment.bottomCenter,
//                                             ),
//                                             borderRadius: BorderRadius.circular(27),
//                                             border: Border.all(
//                                               color: Colors.white.withValues(alpha: 0.80),
//                                               width: 0.8,
//                                             ),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: const Color(0xFF6474C6).withValues(alpha: 0.09),
//                                                 blurRadius: 12,
//                                                 offset: const Offset(0, 2),
//                                               ),
//                                             ],
//                                           ),
//                                           child: const Row(
//                                             children: [
//                                               Icon(Icons.chat, color: Colors.white),
//                                               SizedBox(width: 10),
//                                               Text(
//                                                 "AI Chat",
//                                                 style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.w800,
//                                                   decoration: TextDecoration.none,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//
//                                       const SizedBox(height: 12),
//
//                                       // NEWS BUTTON
//                                       GestureDetector(
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                           Navigator.push(context,
//                                             MaterialPageRoute(builder: (_) => const NewsApp()),
//                                           );
//                                         },
//                                         child: Container(
//                                           width: double.infinity,
//                                           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//                                           decoration: BoxDecoration(
//                                             gradient: LinearGradient(
//                                               colors: [
//                                                 Colors.white.withValues(alpha: 0.2),
//                                                 Colors.transparent,
//                                                 Colors.white.withValues(alpha: 0.2),
//                                                 // Color(0xFF6474C6).withOpacity(0.14)
//                                               ],
//                                               stops: [0.02, 0.35, 1],
//                                               begin: Alignment.topCenter,
//                                               end: Alignment.bottomCenter,
//                                             ),
//                                             borderRadius: BorderRadius.circular(27),
//                                             border: Border.all(
//                                               color: Colors.white.withValues(alpha: 0.80),
//                                               width: 0.8,
//                                             ),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color:  AppColors.newColor5.withValues(alpha: 0.09),
//                                                 blurRadius: 12,
//                                                 offset: const Offset(0, 2),
//                                               ),
//                                             ],
//                                           ),
//                                           child: const Row(
//                                             children: [
//                                               Icon(Icons.newspaper, color: Colors.white),
//                                               SizedBox(width: 10),
//                                               Text(
//                                                 "News",
//                                                 style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.w800,
//                                                   decoration: TextDecoration.none,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//                 child: const Padding(
//                   padding: EdgeInsets.all(5),
//                   child: Icon(
//                     Icons.more_vert,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//
//
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
//             // backgroundColor: AppColors.navigationSkyBlueColor,
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
//           // body: RefreshIndicator(
//           //     color: AppColors.navigationSkyBlueColor,
//           //     onRefresh: () async {
//           //       BlocProvider.of<ChartsCubit>(context).initializeValues();
//           //     },
//           //     child: getBody(state)),
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
//           body: getBody(state),
//         );
//       },
//     );
//   }
//   Widget getBody(ChartsState state) {
//     Utils().errorAndLogout(state, context);
//     if (state.status == FormStatus.loading) {
//       return const BaseLoader();
//     }
//     return Container(
//       // color: Colors.white,
//       decoration:  BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             // Color(0xFF845EF7),
//             // Color(0xFF6A89CC).withValues(alpha: 0.4),
//             // Color(0xFF6A89CC),
//             // Color(0xFF6A89CC),
//
//             // Color(0xFF6A89CC).withValues(alpha: 0.4),
//             // Color(0xFF7589E9),
//             // Colors.orange,
//             AppColors.newColor3,
//             AppColors.newColor3,
//             // Color(0xFF6474C6),
//             // Color(0xFF6474C6),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(top: 20.0),
//         child: SingleChildScrollView(
//           child: Container(
//             // padding: const EdgeInsets.all(10.0),
//             decoration:  BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   // Color(0xFF845EF7),
//                   // Color(0xFF6A89CC),
//                   // Color(0xFF7589E9),
//                   // Color(0xFF7589E9),
//                   // Color(0xFF6A89CC).withValues(alpha: 0.1),
//                   // Color(0xFF6A89CC).withValues(alpha: 0.1),
//                   // Color(0xFF6474C6),
//                   // Color(0xFF6474C6),
//                   AppColors.newColor3,
//                   AppColors.newColor3,
//                   // Color(0xFF6A89CC),
//                   // Color(0xFF6A89CC),
//                   // Colors.white,
//                   // Colors.white,
//
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             // decoration: const BoxDecoration(
//             //   image: DecorationImage(
//             //     image: AssetImage('assets/images/login4.png'),
//             //     fit: BoxFit.fitHeight,
//             //   ),
//             // ),
//             child: Column(
//               children: [
//                 buildChartHorizontalWidget(
//                   title: Constants.lawEnforcementVisitsByEntity,
//                   chartValues: state.lawEnforcementVisitByEntity ?? [],
//                 ),
//                 const SizedBox(height: 20),
//                 buildChartHorizontalWidget(
//                   title: Constants.lawEnforcementVisitsByRegion,
//                   chartValues: state.lawEnforcementVisitByRegion ?? [],
//                 ),
//                 const SizedBox(height: 20),
//                 buildChartHorizontalWidget(
//                   title: Constants.eventProtectionByRegion,
//                   chartValues: state.eventProtectionByRegion ?? [],
//                 ),
//               ],
//             ),
//           ),
//          ),
//       ),
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
//
//   SingleChildScrollView buildChartHorizontalWidget({
//     required String title,
//     required List<PieChartData> chartValues,
//   }) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: BaseDonutChart(
//                 chartTitle: title,
//                 moreIcon: SvgPicture.asset(AppIcon.moreicon),
//                 chartData: chartValues,
//               ),
//             ),
//
//           SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: BaseVerticleBarCharts(
//               chartTitle: title,
//               moreIcon: SvgPicture.asset(AppIcon.moreicon),
//               chartData: chartValues,
//             ),
//           ),
//           SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: BasePieChart(
//               chartTitle: title,
//               moreIcon: SvgPicture.asset(AppIcon.moreicon),
//               chartData: chartValues,
//             ),
//           ),
//           // SizedBox(
//           //   width: 430,
//           //   child: BaseVerticleBarCharts(
//           //     chartTitle: title,
//           //     moreIcon: SvgPicture.asset(AppIcon.moreicon),
//           //     chartData: chartValues,
//           //   ),
//           // ),
//           // SizedBox(
//           //   width: 430,
//           //   child: SizedBox(
//           //     width: 430,
//           //     child: BaseDonutChart(
//           //       chartTitle: title,
//           //       moreIcon: SvgPicture.asset(AppIcon.moreicon),
//           //       chartData: chartValues,
//           //     ),
//           //   ),
//           //
//           // ),
//           // SizedBox(
//           //   width: 430,
//           //   child: BasePyramidCharts(
//           //     chartTitle: title,
//           //     moreIcon: SvgPicture.asset(AppIcon.moreicon),
//           //     chartData: chartValues,
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
// //------------------------------------------------------------
// //
// // class AppThemes {
// //   // Light Theme
// //   static final ThemeData lightTheme = ThemeData(
// //     brightness: Brightness.light,
// //     primaryColor: Colors.blue,
// //     scaffoldBackgroundColor: Colors.white,
// //     appBarTheme: const AppBarTheme(
// //       backgroundColor: Colors.blue,
// //       foregroundColor: Colors.white,
// //     ),
// //     textTheme: const TextTheme(
// //       bodyLarge: TextStyle(color: Colors.black),
// //       bodyMedium: TextStyle(color: Colors.black87),
// //     ),
// //   );
// //
// //   // Dark Theme
// //   static final ThemeData darkTheme = ThemeData(
// //     brightness: Brightness.dark,
// //     primaryColor: Colors.blueGrey,
// //     scaffoldBackgroundColor: Colors.black,
// //     appBarTheme: const AppBarTheme(
// //       backgroundColor: Colors.blueGrey,
// //       foregroundColor: Colors.white,
// //     ),
// //     textTheme: const TextTheme(
// //       bodyLarge: TextStyle(color: Colors.white),
// //       bodyMedium: TextStyle(color: Colors.white70),
// //     ),
// //   );
// //
// //   // Glass Theme
// //   static final ThemeData glassTheme = ThemeData(
// //     brightness: Brightness.light,
// //     primaryColor: Colors.blue,
// //     scaffoldBackgroundColor: Colors.transparent,
// //     appBarTheme: const AppBarTheme(
// //       backgroundColor: Colors.transparent,
// //       foregroundColor: Colors.white,
// //       elevation: 0,
// //     ),
// //     textTheme: const TextTheme(
// //       bodyLarge: TextStyle(color: Colors.white),
// //       bodyMedium: TextStyle(color: Colors.white70),
// //     ),
// //   );
// // }
// //
// //
// // // import 'package:flutter/material.dart';
// // // import 'theme.dart';
// //
// //
// // enum AppTheme { Light, Dark, Glass }
// //
// // class ThemeProvider extends ChangeNotifier {
// //   ThemeData _themeData = AppThemes.lightTheme;
// //   AppTheme _currentTheme = AppTheme.Light;
// //
// //   ThemeData get themeData => _themeData;
// //   AppTheme get currentTheme => _currentTheme;
// //
// //   void setTheme(AppTheme theme) {
// //     _currentTheme = theme;
// //     switch (theme) {
// //       case AppTheme.Light:
// //         _themeData = AppThemes.lightTheme;
// //         break;
// //       case AppTheme.Dark:
// //         _themeData = AppThemes.darkTheme;
// //         break;
// //       case AppTheme.Glass:
// //         _themeData = AppThemes.glassTheme;
// //         break;
// //     }
// //     notifyListeners();
// //   }
// // }
// //
// //
// // // import 'dart:ui';
// // // import 'package:flutter/material.dart';
// //
// // class GlassContainer extends StatelessWidget {
// //   final Widget child;
// //   final double borderRadius;
// //   final double blur;
// //
// //   const GlassContainer({
// //     required this.child,
// //     this.borderRadius = 20,
// //     this.blur = 10,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return ClipRRect(
// //       borderRadius: BorderRadius.circular(borderRadius),
// //       child: BackdropFilter(
// //         filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
// //         child: Container(
// //           decoration: BoxDecoration(
// //             color: Colors.white.withOpacity(0.2),
// //             borderRadius: BorderRadius.circular(borderRadius),
// //             border: Border.all(
// //               color: Colors.white.withOpacity(0.3),
// //             ),
// //           ),
// //           child: child,
// //         ),
// //       ),
// //     );
// //   }
// // }


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

  Future<void> getUserDetails() async {
    userName = await SharedPrefs.getUsername();
    email = await SharedPrefs.getEmail();

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
          extendBody: true,
          extendBodyBehindAppBar: true,
          key: scaffoldKey,
          drawer: NavigationDrawer1(scaffoldKey, userName, email),
          appBar: AppHeader(
            backgroundColour: Colors.transparent,
            isTitleCenter: false,
            title: Constants.dashboard,
            action: [
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

              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    // barrierColor: Colors.white.withValues(alpha: 0.5),
                    builder: (context) {
                      return Stack(
                        children: [
                          Positioned(
                            top: kToolbarHeight + 0,
                            right: 20,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                                child: Container(
                                  width: 180,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(27),
                                    border: Border.all(
                                      color: Colors.white.withValues(alpha: 1),
                                      width: 0.4,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // CHAT BUTTON
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(
                                            context,
                                            aiChatDetailsRoute,
                                            arguments: {"title":'ATOM AI Chat'},
                                          );
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.white.withValues(alpha: 0.2),
                                                Colors.transparent,
                                                Colors.white.withValues(alpha: 0.2),
                                                // Color(0xFF6474C6).withOpacity(0.14)
                                              ],
                                              // stops: [0.02, 0.35, 1],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                            borderRadius: BorderRadius.circular(27),
                                            border: Border.all(
                                              color: Colors.white.withValues(alpha: 0.80),
                                              width: 0.8,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.newColor.withValues(alpha: 0.09),
                                                blurRadius: 12,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: const Row(
                                            children: [
                                              Icon(Icons.chat, color: Colors.white),
                                              SizedBox(width: 10),
                                              Text(
                                                "AI Chat",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w800,
                                                  decoration: TextDecoration.none,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 12),

                                      // NEWS BUTTON
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.push(context,
                                            MaterialPageRoute(builder: (_) => const NewsApp()),
                                          );
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.white.withValues(alpha: 0.2),
                                                Colors.transparent,
                                                Colors.white.withValues(alpha: 0.2),
                                                // Color(0xFF6474C6).withOpacity(0.14)
                                              ],
                                              // stops: [0.02, 0.35, 1],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                            borderRadius: BorderRadius.circular(27),
                                            border: Border.all(
                                              color: Colors.white.withValues(alpha: 0.80),
                                              width: 0.8,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.newColor.withValues(alpha: 0.09),
                                                blurRadius: 12,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: const Row(
                                            children: [
                                              Icon(Icons.newspaper, color: Colors.white),
                                              SizedBox(width: 10),
                                              Text(
                                                "News",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w800,
                                                  decoration: TextDecoration.none,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              ),



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

          /// Bottom Navigation Bar
          bottomNavigationBar:
          state.displayMenu != null
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

    return Stack(
      children: [
        // 🔹 Full screen Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/images/bg2.png',
            fit: BoxFit.cover,
          ),
        ),

        // 🔹 Global Blur Layer
        Positioned.fill(
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: Container(
                color: Colors.black.withValues(alpha: 0.08), // soft tint
              ),
            ),
          ),
        ),

        // 🔹 Content
        SafeArea(
          top: true, // respects status bar
          bottom: false,
          child: Padding(
            // padding: const EdgeInsets.only(
            //   top: kToolbarHeight, // pushes content below AppBar
            // ),
    padding: const EdgeInsets.only(top: kToolbarHeight + -30),

    child: SingleChildScrollView(
              child: Column(
                children: [
                  buildChartHorizontalWidget(
                    title: Constants.lawEnforcementVisitsByEntity,
                    chartValues: state.lawEnforcementVisitByEntity ?? [],
                  ),
                  const SizedBox(height: 20),
                  buildChartHorizontalWidget(
                    title: Constants.lawEnforcementVisitsByRegion,
                    chartValues: state.lawEnforcementVisitByRegion ?? [],
                  ),
                  const SizedBox(height: 20),
                  buildChartHorizontalWidget(
                    title: Constants.eventProtectionByRegion,
                    chartValues: state.eventProtectionByRegion ?? [],
                  ),
                  const SizedBox(height: 150),
                ],
              ),
            ),
          ),
        ),
      ],
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

  Widget buildChartHorizontalWidget({
    required String title,
    required List<PieChartData> chartValues,
  }) {
    final media = MediaQuery.of(context);
    final isTablet = media.size.shortestSide >= 600;
    final isLandscape = media.orientation == Orientation.landscape;

    final charts = [
      BaseDonutChart(
        chartTitle: title,
        moreIcon: SvgPicture.asset(AppIcon.moreicon),
        chartData: chartValues,
      ),
      BaseVerticalBarCharts(
        chartTitle: title,
        moreIcon: SvgPicture.asset(AppIcon.moreicon),
        chartData: chartValues,
      ),
      BasePieChart(
        chartTitle: title,
        moreIcon: SvgPicture.asset(AppIcon.moreicon),
        chartData: chartValues,
      ),
    ];

    /// TABLET + LANDSCAPE → GRID
    if (isTablet && isLandscape) {
      // return Padding(
        // padding: const EdgeInsets.symmetric(vertical: 10),
      return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 1.35, //
          ),
          itemCount: charts.length,
          itemBuilder: (_, index) => charts[index],
        );
      // );
    }

    ///  MOBILE + PORTRAIT → HORIZONTAL SWIPE
    return SizedBox(
      height: media.size.height * 0.45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: charts.length,
        itemBuilder: (_, index) {
          return SizedBox(
            width: media.size.width,
            child: charts[index],
          );
        },
      ),
    );
  }
}
