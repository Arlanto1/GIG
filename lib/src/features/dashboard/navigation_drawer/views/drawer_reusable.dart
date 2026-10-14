//
//
// import 'dart:developer';
// import 'dart:ui';
//
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/features/dashboard/navigation_drawer/views/menu_permissions.dart';
//
// class NavigationDrawer1 extends StatelessWidget {
//   NavigationDrawer1(
//       this._menuScaffoldKey,
//       this.username,
//       this.email, {
//         super.key,
//       }) {
//     /// Initialize Display Menu
//     initializeDrawerItems();
//   }
//
//   late List<MenuItem> expansionTileDrawerItems = [];
//   late List<MenuItem> costAndBillingExpansionTileDrawerItems = [];
//   late List<MenuItem> securitySystemTicketsItems = [];
//
//   Future<void> initializeDrawerItems() async {
//     expansionTileDrawerItems = await checkDisplayMenu();
//     // costAndBillingExpansionTileDrawerItems = await costBillingDisplayMenu();
//     securitySystemTicketsItems = await securitySystemsDisplayMenu();
//   }
//
//   DisplayMenu? displayMenu;
//
//   Future<List<MenuItem>> checkDisplayMenu() async {
//     displayMenu = await SharedPrefs.getDisplayMenu();
//     bool guardingOperations = ((displayMenu?.gM ?? false) ||
//         (displayMenu?.cD ?? false) ||
//         (displayMenu?.gR ?? false) ||
//         (displayMenu?.oCC ?? false) ||
//         (displayMenu?.sVP ?? false) ||
//         (displayMenu?.gMR ?? false));
//
//     if (displayMenu == null) {
//       return [];
//     }
//     List<MenuItem> expansionTileDrawerItems = [];
//     if (displayMenu?.aps ?? false) {
//       expansionTileDrawerItems.add(const MenuItem(
//           Constants.annualPowerShutdownListTitle,
//           AppIcon.annualPowerShutdownIcon,
//           0));
//     }
//     if (displayMenu?.aF ?? false) {
//       expansionTileDrawerItems.add(const MenuItem(
//           Constants.articleFoundRegisterListTitle,
//           AppIcon.articleFoundRegisterIcon,
//           0));
//     }
//     if (displayMenu?.eP ?? false) {
//       expansionTileDrawerItems.add(const MenuItem(
//           Constants.eventProtection, AppIcon.eventProtectionIcon, 1));
//     }
//
//     log('gm -- ${displayMenu?.gM}');
//     // if (guardingOperations) {
//       expansionTileDrawerItems.add(const MenuItem(
//           Constants.guardingOperations, AppIcon.guardingOperationIcon, 1));
//     // }
//
//     if (displayMenu?.iM ?? false) {
//       expansionTileDrawerItems.add(const MenuItem(
//           Constants.incidentManagementTitle,
//           AppIcon.incidentManagementIcon,
//           1));
//     }
//     if (displayMenu?.keyMM ?? false) {
//       expansionTileDrawerItems.add(const MenuItem(
//           Constants.keyManagementData, AppIcon.keyManagementDataIcon, 1));
//     }
//     if (displayMenu?.lEO ?? false) {
//       expansionTileDrawerItems.add(const MenuItem(
//           Constants.lawEnforcementVisitsListTitle,
//           AppIcon.lawEnforcementIcon,
//           0));
//     }
//
//
//     if (displayMenu?.mM ?? false) {
//       expansionTileDrawerItems.add(const MenuItem(
//           Constants.materialMovement, AppIcon.materialMovementIcon, 1));
//     }
//     if (displayMenu?.pM ?? false) {
//       expansionTileDrawerItems.add(const MenuItem(
//           Constants.passManagement, AppIcon.passManagementIcon, 1));
//     }
//
//     if (displayMenu?.sS ?? false) {
//       expansionTileDrawerItems.add(
//           const MenuItem(shiftSchedulingTitle, AppIcon.eventProtectionIcon, 1));
//     }
//
//     if (displayMenu?.vIP ?? false) {
//       expansionTileDrawerItems
//           .add(const MenuItem(vVipVisitorsTitle, AppIcon.vvipVisitorIcon, 0));
//     }
//
//     if (displayMenu?.vIP ?? false) {
//       expansionTileDrawerItems.add(const MenuItem(
//           Constants.parking, AppIcon.transportIcon,
//           0));
//     }
//
//
//     return expansionTileDrawerItems;
//   }
//
//   // Future<List<MenuItem>> costBillingDisplayMenu() async {
//   //   displayMenu = await SharedPrefs.getDisplayMenu();
//   //   if (displayMenu == null) {
//   //     return [];
//   //   }
//   //   List<MenuItem> costAndBillingExpansionTileDrawerItems = [];
//   //   if (displayMenu?.gR ?? false) {
//   //     costAndBillingExpansionTileDrawerItems.add(const MenuItem(
//   //         Constants.guardingRates, AppIcon.guardingRatesIcon, 0));
//   //   }
//   //   return costAndBillingExpansionTileDrawerItems;
//   // }
//
//   Future<List<MenuItem>> securitySystemsDisplayMenu() async {
//     displayMenu = await SharedPrefs.getDisplayMenu();
//     if (displayMenu == null) {
//       return [];
//     }
//     List<MenuItem> securitySystemTicketsItems = [];
//     if (displayMenu?.gR ?? false) {
//       securitySystemTicketsItems
//           .add(const MenuItem(Constants.incident, AppIcon.incidentIcon, 0));
//     }
//     return securitySystemTicketsItems;
//   }
//
//   final String? username;
//   final String? email;
//   final GlobalKey<ScaffoldState> _menuScaffoldKey;
//
//   late int _lastSelectedItem = 0;
//   late int _opearationsLastSelectedItem = 10;
//   late int _passlastSelectedItem = 10;
//   late int _securityfunfunctionslastSelectedItem = 10;
//   late int _ticketingSystemlastSelectedItem = 1;
//   late int _traininglastSelectedItem = 1;
//
//   Future<void> getIndeifydrawerIndex() async {
//     _lastSelectedItem = await SharedPrefs.getIdentifymenuindex();
//   }
//
//   // TODO: Need to define all the Titles here
//   static const String operationsTitle = Constants.operations;
//   // static const String costAndBillingTitle = Constants.costAndBilling;
//   static const String shiftSchedulingTitle = Constants.shiftScheduling;
//   static const String keyManagementDataTitle = Constants.keyManagementData;
//   static const String vVipVisitorsTitle = Constants.vVipVisitorsTitle;
//   static const String securitySystemsTitle = Constants.securitySystems;
//   static const String ticketingSystemsTitle = Constants.ticketingSystem;
//
//   @override
//   Widget build(BuildContext context) {
//     // Glassy background gradient and blur
//     return Theme(
//       data: Theme.of(context).copyWith(
//         canvasColor: Colors.transparent,
//       ),
//       child: Drawer(
//         width: MediaQuery.of(context).size.width,
//         elevation: 0,
//         child: Stack(
//           children: [
//             // BACKGROUND GRADIENT
//             // Container(
//             //   decoration:  BoxDecoration(
//             //     gradient: LinearGradient(
//             //       colors: [
//             //         AppColors.newColor,
//             //         AppColors.newColor,
//             //         // Color(0xFF0F172A), // deep navy
//             //         // Color(0xFF071130),
//             //         //   Color(0xFF111827),
//             //         //   Color(0xFF111827)
//             //       ],
//             //       begin: Alignment.topLeft,
//             //       end: Alignment.bottomRight,
//             //     ),
//             //   ),
//             // ),
//             Positioned.fill(
//               child: Image.asset(
//                 'assets/images/bg2.png',
//                 fit: BoxFit.cover,
//               ),
//             ),
//
//             // 🔹 Global Blur Layer
//             Positioned.fill(
//               child: ClipRect(
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
//                   child: Container(
//                     color: Colors.black.withValues(alpha: 0.3), // soft tint
//                   ),
//                 ),
//               ),
//             ),
//
//             // FROSTED BLUR LAYER
//             ClipRRect(
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 14.0, sigmaY: 14.0),
//                 child: Container(
//                   color:AppColors.newColor.withValues(alpha: 0.1),
//                 ),
//               ),
//             ),
//
//             // CONTENT
//             SafeArea(
//               child: BlocProvider(
//                 create: (context) => DrawerCubit(),
//                 child: BlocBuilder<DrawerCubit, DrawerState>(
//                   builder: (context, state) {
//                     switch (state.runtimeType) {
//                       case DrawerInitial _:
//                         _lastSelectedItem = (state as DrawerInitial).index;
//                         break;
//                       case GetDrawerItemChange _:
//                         _lastSelectedItem =
//                             (state as GetDrawerItemChange).index;
//                         break;
//                       case OperationsGetDrawerItemChange _:
//                         log('drawer operation ');
//                         _opearationsLastSelectedItem =
//                             (state as OperationsGetDrawerItemChange).index;
//                         break;
//                     case SecurityFunctionsGetDrawerItemChange _:
//                       _securityfunfunctionslastSelectedItem =
//                           (state as SecurityFunctionsGetDrawerItemChange)
//                               .index;
//                       break;
//                       case PassMgmtGetDrawerItemChange _:
//                         _passlastSelectedItem =
//                             (state as PassMgmtGetDrawerItemChange).index;
//                         break;
//                     case TicketingSystemGetDrawerItemChange _:
//                       _ticketingSystemlastSelectedItem =
//                           (state as TicketingSystemGetDrawerItemChange)
//                               .index;
//                       break;
//                       case TrainingGetDrawerItemChange _:
//                         _traininglastSelectedItem =
//                             (state as TrainingGetDrawerItemChange)
//                                 .index;
//                       default:
//                         break;
//                     }
//
//                     return ListView(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 0.0, horizontal: 5.0),
//                       children: <Widget>[
//                         // Close icon top-right
//                         Padding(
//                           padding: const EdgeInsets.only(right: 6.0),
//                           child: Align(
//                             alignment: Alignment.centerRight,
//                             child: GestureDetector(
//                               onTap: () async {
//                                 if (_menuScaffoldKey
//                                     .currentState!.isDrawerOpen) {
//                                   _menuScaffoldKey.currentState!.closeDrawer();
//                                 } else {
//                                   _menuScaffoldKey.currentState!.openDrawer();
//                                 }
//                               },
//                               child: Container(
//                                 padding: const EdgeInsets.all(6),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white.withValues(alpha: 0.04),
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(
//                                       color: Colors.white.withValues(alpha: 0.6)),
//                                 ),
//                                 child:
//                                 SvgPicture.asset(AppIcon.closeIcon,colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
//                               )
//
//                             ),
//
//                           ),
//                         ),
//
//                         const SizedBox(height: 8),
//
//                         // PROFILE HEADER (glassy card)
//                         Container(
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 4, vertical: 6),
//                           padding: const EdgeInsets.all(14),
//                           decoration: BoxDecoration(
//                             color: AppColors.newColor.withValues(alpha: 0.4),
//                             borderRadius: BorderRadius.circular(16),
//                             border: Border.all(
//                                 color: Colors.white.withValues(alpha: 0.5)),
//                           ),
//                           child: Row(
//                             children: [
//                               // Avatar
//                               Container(
//                                 width: 56,
//                                 height: 56,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   gradient: LinearGradient(
//                                     begin: Alignment.topLeft,
//                                     end: Alignment.bottomRight,
//                                     colors: [
//                                       AppColors.newColor,
//                                       AppColors.newColor,
//                                     ],
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: AppColors.white
//                                             .withValues(alpha: 0.18),
//                                         blurRadius: 8,
//                                         offset: const Offset(0, 6)),
//                                   ],
//                                 ),
//                                 child: CircleAvatar(
//                                   backgroundColor: Colors.transparent,
//                                   child: Text(
//                                     (username?.isNotEmpty ?? false)
//                                         ? username!.substring(0, 1).toUpperCase()
//                                         : 'U',
//                                     style: const TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w900,
//                                         fontSize: 25),
//                                   ),
//                                 ),
//                               ),
//
//                               const SizedBox(width: 12),
//
//                               // Name & Email
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       username ?? '',
//                                       style: const TextStyle(
//                                         color: AppColors.white,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w900,
//                                         fontFamily:
//                                         Constants.customFontSemiBoldFamily,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       email ?? '',
//                                       style: const TextStyle(
//                                         color: AppColors.white,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w700,
//                                         fontFamily:
//                                         Constants.customFontSemiBoldFamily,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                       maxLines: 1,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         const SizedBox(height: 8),
//
//                         // MAIN MENU ITEMS (keeps all logic)
//                         // Container(
//                         //   padding: const EdgeInsets.symmetric(
//                         //       vertical: 6, horizontal: 6),
//                         //   decoration: BoxDecoration(
//                         //     color:   AppColors.newColor.withValues(alpha: 0.1),
//                         //     borderRadius: BorderRadius.circular(14),
//                         //   ),
//                         //   child: Column(
//                         //     children: _buildDrawerChildren(context, state),
//                         //   ),
//                         // ),
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(14),
//                           child: Material(
//                             color: AppColors.newColor.withValues(alpha: 0.1),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
//                               child: Column(
//                                 children: _buildDrawerChildren(context, state),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _glassyTile({
//     required Widget child,
//     bool isSelected = false,
//     EdgeInsets margin = const EdgeInsets.symmetric(vertical: 4),
//   }) {
//     return StatefulBuilder(
//       builder: (context, setState) {
//         bool isHovered = false;
//
//         return MouseRegion(
//           onEnter: (_) => setState(() => isHovered = true),
//           onExit: (_) => setState(() => isHovered = false),
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeOutCubic,
//             margin: margin,
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//             decoration: BoxDecoration(
//               color: (isHovered || isSelected)
//                   ? Colors.transparent
//                   : Colors.transparent,
//               borderRadius: BorderRadius.circular(12),
//
//               //  Highlight border when selected
//               border: Border.all(
//                 color: isSelected
//                     ? Colors.white.withValues(alpha: 0.45)
//                     : (isHovered
//                     ? Colors.white.withValues(alpha: 0.25)
//                     : Colors.white.withValues(alpha: 0.45)),
//                 width: isSelected ? 1.3 : 1.3,
//               ),
//
//               //  Add subtle glowing shadow when selected
//               boxShadow: [
//                 if (isHovered || isSelected)
//                   BoxShadow(
//                     color: isSelected
//                         ? Colors.white.withValues(alpha: 0.05)
//                         : Colors.white.withValues(alpha: 0.05),
//                     blurRadius: isSelected ? 12 : 12,
//                     spreadRadius: isSelected ? 1 : 1,
//                     offset: const Offset(0, 3),
//                   ),
//               ],
//             ),
//
//             child: AnimatedDefaultTextStyle(
//               duration: const Duration(milliseconds: 250),
//               style: TextStyle(
//                 color: (isHovered || isSelected)
//                     ? Colors.white
//                     : Colors.white.withValues(alpha: 0.7),
//                 fontWeight:
//                 (isHovered || isSelected) ? FontWeight.w600 : FontWeight.w500,
//               ),
//               child: AnimatedOpacity(
//                 duration: const Duration(milliseconds: 200),
//                 opacity: (isHovered || isSelected) ? 1.0 : 0.85,
//                 child: child,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//
//   List<Widget> _genericItemSelection(
//       BuildContext context,
//       List<MenuItem> items,
//       String title,
//       ) {
//     List<Widget> children = [];
//
//     for (int i = 0; i < items.length; i++) {
//       MenuItem drawerItem = items[i];
//       final bool selected = (i == _passlastSelectedItem);
//
//       children.add(
//         _glassyTile(
//           isSelected: selected,
//           child: ListTile(
//             dense: true,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 6),
//             leading: SizedBox(
//                 width: 22,
//                 height: 22,
//                 child: Image.asset(drawerItem.imageName,
//                     fit: BoxFit.scaleDown,
//                     color: (i == _passlastSelectedItem)
//                         ? AppColors.white
//                         : AppColors.white)),
//             title: Text(drawerItem.title,
//                 style: TextStyle(
//                     fontSize: 15,
//                     fontFamily: Constants.customFontSemiBoldFamily,
//                     fontWeight: FontWeight.w900,
//                     color: (i == _passlastSelectedItem)
//                         ? AppColors.white
//                         : AppColors.white)),
//             onTap: () {
//               switch (title) {
//               /// 2nd Level Menu
//                 case Constants.eventProtection:
//                   _onEventProtectionItemSelected(i, context);
//                   break;
//                 case Constants.incidentManagementTitle:
//                   _onIncidentManagementItemSelected(i, context);
//                   break;
//                 case Constants.materialMovement:
//                   _onMaterialMovementItemSelected(i, context);
//                   break;
//                 case Constants.passManagement:
//                   _onPassMgmtSelectItem(i, context);
//                   break;
//               case Constants.sCRI:
//                 _onSCRIItemSelected(i, context);
//                 break;
//               // case Constants.securitySystems:
//               //   _onSecurityFunctionsItemSelected(i, context);
//               //   break;
//
//               case Constants.ticketingSystem:
//                 _onTicketingSystemItemSelected(i, context);
//                 break;
//
//                 case Constants.training:
//                   _onTrainingItemSelected(i, context);
//                   break;
//
//               /// 3nd Level Menu
//                 case Constants.guardingOperations:
//                   _onGuardingOperationItemSelected(i, context, drawerItem);
//                   break;
//                 case operationsTitle:
//                   buildDrawerChildren(context, drawerItem.title);
//                   break;
//
//               // case Constants.costAndBilling:
//               //   _onCostAndBillingItemSelected(i, context);
//               //   break;
//
//               case Constants.securitySystems:
//                 _onSecuritySystemIncidentItemSelected(i, context);
//                 break;
//
//               case Constants.keyManagementData:
//                 _onKeyManagementItemSelected(
//                   i,
//                   context,
//                 );
//                 break;
//               case shiftSchedulingTitle:
//                 _onShiftScheduleItemSelected(i, context);
//                 break;
//               default:
//                 _onSecuritySystemIncidentItemSelected(i, context);
//               // Default case if title doesn't match any specific condition
//               }
//             },
//           ),
//         ),
//       );
//     }
//
//     return children;
//   }
//
//   _onMaterialMovementItemSelected(int index, BuildContext context) async {
//     // _menuScaffoldKey.currentState!.closeDrawer();
//     _passlastSelectedItem = index;
//     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
//     if (index == 0) {
//       Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
//           arguments: {"isInward": true, "returnable": true,});
//     } else if (index == 1) {
//       Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
//           arguments: {
//             "isInward": true, "returnable": false,
//           });
//     } else if (index == 2) {
//       Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
//           arguments: {"isInward": false, "returnable": true});
//     }
//     else if (index == 3) {
//       Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
//           arguments: {"isInward": false, "returnable": false});
//     }
//   }
//
//
//   _onEventProtectionItemSelected(int index, BuildContext context) async {
//     // _menuScaffoldKey.currentState!.closeDrawer();
//     _passlastSelectedItem = index;
//     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
//     if (index == 0) {
//       Navigator.pushNamed(context, eventProtectionListRoute);
//     } else if (index == 1) {
//       Navigator.pushNamed(context, csrEventListRoute , arguments: {ConstantsArgument.isCSREvent :true, ConstantsArgument.isSportEvent :false});
//     } else if (index == 2) {
//       Navigator.pushNamed(context, csrEventListRoute,arguments: {ConstantsArgument.isSportEvent :true,  ConstantsArgument.isCSREvent :false});
//     }
//   }
//
//
//   _onIncidentManagementItemSelected(int index, BuildContext context) async {
//     // _menuScaffoldKey.currentState!.closeDrawer();
//     _passlastSelectedItem = index;
//     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
//     if (index == 0) {
//       Navigator.pushNamed(context, incidentManagementsRoute);
//     } else if (index == 1) {
//       Navigator.pushNamed(context, transportMedicalListRoute , arguments: {ConstantsArgument.isTransport :true});
//     } else if (index == 2) {
//       Navigator.pushNamed(context, transportMedicalListRoute,arguments: {ConstantsArgument.isTransport :false});
//     }
//   }
//
//   _onSCRIItemSelected(int index, BuildContext context) async {
//     // _menuScaffoldKey.currentState!.closeDrawer();
//     _passlastSelectedItem = index;
//     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
//     if (index == 0) {
//       Navigator.pushNamed(
//         context,
//         vipVisitorsListRoute,
//       );
//     }
//   }
//
//   _onSecurityFunctionsItemSelected(int index, BuildContext context) async {
//     _passlastSelectedItem = index;
//     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
//     if (index == 0) {
//       Navigator.pushNamed(
//         context,
//         sstIncidentListRoute,
//       );
//     }
//   }
//
//   _onTicketingSystemItemSelected(int index, BuildContext context) async {
//     _ticketingSystemlastSelectedItem = index;
//     context.read<DrawerCubit>().getTicketingSystemIndexChange(index);
//     if (index == 0) {
//       Navigator.pushNamed(
//         context,
//         ticketingSystemListRoute,
//       );
//     }
//   }
//
//   _onTrainingItemSelected(int index, BuildContext context) async {
//     _traininglastSelectedItem = index;
//     context.read<DrawerCubit>().getTrainingIndexChange(index);
//     if (index == 0) {
//       Navigator.pushNamed(
//         context,
//         trainingModuleListRoute,
//       );
//     }
//     if (index == 1) {
//       Navigator.pushNamed(
//         context,
//         selfPacedTrainingListRoute,
//       );
//     }
//   }
//
//   _onSecuritySystemIncidentItemSelected(int index, BuildContext context) async {
//     _passlastSelectedItem = index;
//     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
//     if (index == 0) {
//       Navigator.pushNamed(context, sstIncidentListRoute,
//           arguments: {"isInternal": true});
//     }
//   }
//
//   _onKeyManagementItemSelected(int index, BuildContext context) async {
//     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
//     switch (index) {
//       case 0:
//         Navigator.pushNamed(context, keyManagementMasterListRoute,
//             arguments: {"Key Management Master": false});
//         break;
//       case 1:
//         Navigator.pushNamed(context, keyManagementIssuanceListRoute,
//             arguments: {"Key Management Issuance List": false});
//         break;
//       case 2:
//         Navigator.pushNamed(context, keyLossDestructionListRoute,
//             arguments: {"Key Loss Destruction List": false});
//         break;
//     }
//   }
//
//   _onShiftScheduleItemSelected(int index, BuildContext context) async {
//     _passlastSelectedItem = index;
//     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
//     switch (index) {
//       case 0:
//         Navigator.pushNamed(context, attendanceListRoute);
//         break;
//       case 1:
//         Navigator.pushNamed(context, dutyPostMasterListRoute);
//         break;
//       case 2:
//         Navigator.pushNamed(context, dutyPostNameMasterListRoute);
//         break;
//       case 3:
//         Navigator.pushNamed(context, shiftScheduleListRoute);
//         break;
//       case 4:
//         Navigator.pushNamed(context, attendanceReportBillingListRoute);
//         break;
//       default:
//         break;
//     }
//   }
//   //
//   // _onCostAndBillingItemSelected(int index, BuildContext context) async {
//   //   _passlastSelectedItem = index;
//   //   context.read<DrawerCubit>().getPassMgmtIndexChange(index);
//   //   if (index == 0) {
//   //     Navigator.pushNamed(context, guardingRatesRoute);
//   //   }
//   // }
//
//   // TODO: Fix the Drawer Index
//   _onGuardingOperationItemSelected(
//       int index, BuildContext context, MenuItem item) async {
//     _passlastSelectedItem = index;
//     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
//
//     log('--item.title--${item.title}--');
//
//     switch (item.title) {
//       case Constants.escalationMatrix:
//         Navigator.pushNamed(context, contactDetailsListRoute);
//         break;
//       case Constants.guardingMasterData:
//         Navigator.pushNamed(context, guardingMasterDataRoute);
//         break;
//       case Constants.guardingMasterReport:
//         log('--Constants.guardingMasterReportTitle--${item.title}--');
//         return Navigator.pushNamed(context, guardingMasterReportRoute);
//       case Constants.shiftOccurrence:
//         Navigator.pushNamed(context, shiftOccurrenceRoute);
//         break;
//       // case Constants.slaViolationPenaltyTitle:
//       //   Navigator.pushNamed(context, slaViolationPenaltyListRoute);
//         break;
//       case Constants.patrolling:
//         Navigator.pushNamed(context, patrollingListRoute);
//       default:
//         break;
//     }
//   }
//
//   List<Widget> _buildDrawerChildren(BuildContext context, DrawerState state) {
//     List<Widget> children = [];
//
//     for (int i = 0; i < mainDrawerItems.length; i++) {
//       MenuItem drawerItem = mainDrawerItems[i];
//       children.add(
//         drawerItem.numberOfChildren == 0
//             ? _glassyTile(
//           isSelected: (i == _lastSelectedItem),
//           child: ListTile(
//             dense: true,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 6),
//             leading: SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: Image.asset(drawerItem.imageName,
//                     fit: BoxFit.cover,
//                     color: (i == _lastSelectedItem)
//                         ? AppColors.white
//                         : AppColors.white)),
//             title: Text(drawerItem.title,
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontFamily: Constants.customFontSemiBoldFamily,
//                     fontWeight: FontWeight.w900,
//                     color: (i == _lastSelectedItem)
//                         ? AppColors.white
//                         : AppColors.white)),
//             onTap: () => _onSelectItem(
//               i,
//               context,
//             ),
//           ),
//         )
//             : Theme(
//           data: Theme.of(context)
//               .copyWith(dividerColor: Colors.transparent),
//           child: _glassyTile(
//             child: ExpansionTile(
//                 onExpansionChanged: (value) {
//                   if (value == true) {
//                     _lastSelectedItem = i;
//                     context
//                         .read<DrawerCubit>()
//                         .getIndexChange(_lastSelectedItem);
//                   } else {
//                     _securityfunfunctionslastSelectedItem = 10;
//                     context
//                         .read<DrawerCubit>()
//                         .getSecurityIndexChange(10);
//                   }
//                 },
//                 trailing: const Icon(Icons.arrow_drop_down_rounded, color: Colors.white,),
//                 title: Text(
//                   drawerItem.title,
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontFamily: Constants.customFontSemiBoldFamily,
//                       fontWeight: FontWeight.w600,
//                       color: (i == _lastSelectedItem)
//                           ? AppColors.white
//                           : AppColors.white),
//                 ),
//                 leading: SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: Image.asset(drawerItem.imageName,
//                         fit: BoxFit.cover,
//                         color: (i == _lastSelectedItem)
//                             ? AppColors.white
//                             : AppColors.white)),
//                 childrenPadding: const EdgeInsets.only(left: 18),
//                 //children padding
//                 // children: drawerItem.title == Constants.securityFunctions
//                 //     ? _buildOperationsFromSecurity(context, state)
//                 //     : _buildTicketingSystemFromSecurity(context, state)),
//                 children: drawerItem.title == Constants.securityFunctions
//                     ? _buildOperationsFromSecurity(context, state)
//                     : drawerItem.title == Constants.training
//                     ? _buildTrainingFromSecurity(context, state)
//                     : _buildTicketingSystemFromSecurity(context, state)),
//             ),
//         ),
//       );
//     }
//
//     return children;
//   }
//
//   List<Widget> _buildOperationsFromSecurity(
//       BuildContext context, DrawerState state) {
//     List<Widget> children = [];
//
//     List<MenuItem> menuItems = [];
//     menuItems
//         .add(const MenuItem(Constants.operations, AppIcon.operationsIcon, 1));
//     // if (displayMenu?.gR ?? false) {
//     //   menuItems.add(
//     //       const MenuItem(Constants.costAndBilling, AppIcon.costBillingIcon, 1));
//     // }
//     if (displayMenu?.sSSLA ?? false) {
//       menuItems.add(const MenuItem(
//           Constants.securitySystems, AppIcon.securitySystemIcon, 1));
//     }
//
//     for (int i = 0; i < menuItems.length; i++) {
//       MenuItem drawerItem = menuItems[i];
//       children.add(
//         drawerItem.numberOfChildren == 0
//             ? _glassyTile(
//           child: ListTile(
//             dense: true,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 6),
//             leading: SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: Image.asset(
//                   drawerItem.imageName,
//                   //fit: BoxFit.cover,
//                   color: (i == _securityfunfunctionslastSelectedItem)
//                       ? AppColors.white
//                       : AppColors.white,
//                 )),
//             title: Text(drawerItem.title,
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontFamily: Constants.customFontSemiBoldFamily,
//                     fontWeight: FontWeight.w600,
//                     color: (i == _securityfunfunctionslastSelectedItem)
//                         ? AppColors.white
//                         : AppColors.white)),
//             onTap: () => _onSecurityExpansionSelectItem(i, context),
//           ),
//         )
//             : Theme(
//           data: Theme.of(context)
//               .copyWith(dividerColor: Colors.transparent),
//           child: _glassyTile(
//             child: ExpansionTile(
//               onExpansionChanged: (value) {
//                 if (value == true) {
//                   _securityfunfunctionslastSelectedItem = i;
//                   context.read<DrawerCubit>().getSecurityIndexChange(
//                       _securityfunfunctionslastSelectedItem);
//                 } else {
//                   _securityfunfunctionslastSelectedItem = 10;
//                   context.read<DrawerCubit>().getSecurityIndexChange(
//                       _securityfunfunctionslastSelectedItem);
//                 }
//               },
//               trailing: const Icon(Icons.arrow_drop_down_rounded, color: Colors.white,),
//               title: Text(
//                 drawerItem.title,
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontFamily: Constants.customFontSemiBoldFamily,
//                     fontWeight: FontWeight.w600,
//                     color: (i == _lastSelectedItem)
//                         ? AppColors.white
//                         : AppColors.white),
//               ),
//               leading: SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: Image.asset(
//                     i == 0
//                         ? AppIcon.operationsIcon
//                         : i == 1
//                         ? AppIcon.costBillingIcon
//                         : AppIcon.securitySystemIcon,
//                     fit: BoxFit.cover,
//                     color: (i == _lastSelectedItem)
//                         ? AppColors.white
//                         : AppColors.white),
//               ),
//               childrenPadding: const EdgeInsets.only(left: 20),
//               children: selectedChild(drawerItem, context),
//             ),
//           ),
//         ),
//       );
//     }
//
//     return children;
//   }
//
//   List<Widget> _buildTicketingSystemFromSecurity(
//       BuildContext context, DrawerState state) {
//     List<Widget> children = [];
//
//     List<MenuItem> menuItems = [];
//     menuItems.add(const MenuItem(Constants.tickets, AppIcon.ticketsIcon, 1));
//
//     for (int i = 0; i < menuItems.length; i++) {
//       MenuItem drawerItem = menuItems[i];
//       children.add(
//         _glassyTile(
//           child: ListTile(
//             dense: true,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 6),
//             leading: SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: Image.asset(
//                   drawerItem.imageName,
//                   //fit: BoxFit.cover,
//                   color: (i == _ticketingSystemlastSelectedItem)
//                       ? AppColors.white
//                       : AppColors.white,
//                 )),
//             title: Text(drawerItem.title,
//                 //style: Styles.textStyleBlack16,
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontFamily: Constants.customFontSemiBoldFamily,
//                     fontWeight: FontWeight.w600,
//                     color: (i == _ticketingSystemlastSelectedItem)
//                         ? AppColors.white
//                         : AppColors.white)),
//             onTap: () => _onTicketingSystemItemSelected(i, context),
//           ),
//         ),
//       );
//     }
//
//     return children;
//   }
//
//
//   List<Widget> _buildTrainingFromSecurity(
//       BuildContext context, DrawerState state) {
//     List<Widget> children = [];
//
//     List<MenuItem> menuItems = [];
//     menuItems.add(
//       const MenuItem(Constants.classroomTraining, AppIcon.tasklist, 0));
//     menuItems.add( const MenuItem(Constants.selfPacedTraining, AppIcon.tasklist, 0));
//
//     for (int i = 0; i < menuItems.length; i++) {
//       MenuItem drawerItem = menuItems[i];
//       children.add(
//         _glassyTile(
//           child: ListTile(
//             dense: true,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 6),
//             leading: SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: Image.asset(
//                   drawerItem.imageName,
//                   //fit: BoxFit.cover,
//                   color: (i == _traininglastSelectedItem)
//                       ? AppColors.white
//                       : AppColors.white,
//                 )),
//             title: Text(drawerItem.title,
//                 //style: Styles.textStyleBlack16,
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontFamily: Constants.customFontSemiBoldFamily,
//                     fontWeight: FontWeight.w600,
//                     color: (i == _traininglastSelectedItem)
//                         ? AppColors.white
//                         : AppColors.white)),
//             onTap: () => _onTrainingItemSelected(i, context),
//           ),
//         ),
//       );
//     }
//
//     return children;
//   }
//
//
//   List<Widget> selectedChild(MenuItem drawerItem, BuildContext context) {
//     switch (drawerItem.title) {
//       case operationsTitle:
//         return _genericItemExpandable(
//           context,
//           expansionTileDrawerItems,
//           operationsTitle,
//         );
//
//       // case Constants.costAndBilling:
//       //   return _genericItemExpandable(
//       //     context,
//       //     costAndBillingExpansionTileDrawerItems,
//       //     Constants.costAndBilling,
//       //   );
//
//       case Constants.securitySystems:
//         return _genericItemExpandable(
//           context,
//           securitySystemTicketsItems,
//           Constants.securitySystems,
//         );
//       case ticketingSystemsTitle:
//         return _genericItemExpandable(
//           context,
//           expansionTileDrawerItems,
//           ticketingSystemsTitle,
//         );
//       default:
//         return [];
//     }
//   }
//
//   List<Widget> _genericItemExpandable(
//       BuildContext context,
//       List<MenuItem> items,
//       String title,
//       ) {
//     List<Widget> children = [];
//
//     for (int i = 0; i < items.length; i++) {
//       MenuItem drawerItem = items[i];
//       // log('--drawerItem-title-${drawerItem.title}--');
//       children.add(
//         drawerItem.numberOfChildren == 0
//             ? _glassyTile(
//           child: ListTile(
//             dense: true,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 6),
//             leading: SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: Image.asset(drawerItem.imageName,
//                     fit: BoxFit.cover,
//                     color: (i == _opearationsLastSelectedItem)
//                         ? AppColors.white
//                         : AppColors.white)),
//             title: Text(drawerItem.title,
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontFamily: Constants.customFontSemiBoldFamily,
//                     fontWeight: FontWeight.w600,
//                     color: (i == _opearationsLastSelectedItem)
//                         ? AppColors.white
//                         : AppColors.white)),
//             onTap: () {
//               if (title == Constants.guardingOperations) {
//                 _onGuardingOperationItemSelected(i, context, drawerItem);
//                 return;
//               }
//
//               if (title == Constants.keyManagementData) {
//                 _onKeyManagementItemSelected(i, context);
//                 return;
//               }
//               if (title == Constants.shiftSchedule) {
//                 _onShiftScheduleItemSelected(i, context);
//                 return;
//               }
//               // if (title == Constants.costAndBilling) {
//               //   _onCostAndBillingItemSelected(i, context);
//               //   return;
//               // }
//               log('--title-$title-');
//               if (title == Constants.securitySystems) {
//                 _onSecuritySystemIncidentItemSelected(i, context);
//                 return;
//               }
//
//               _onExpansionSelectItem(i, context, drawerItem);
//             },
//           ),
//         )
//             : Theme(
//           data: Theme.of(context)
//               .copyWith(dividerColor: Colors.transparent),
//           child: _glassyTile(
//             child: ExpansionTile(
//               onExpansionChanged: (value) {
//                 if (value == true) {
//                   _opearationsLastSelectedItem = i;
//                   context.read<DrawerCubit>().getOperationsIndexChange(
//                       _opearationsLastSelectedItem);
//                 } else {
//                   _opearationsLastSelectedItem = 10;
//                   context
//                       .read<DrawerCubit>()
//                       .getOperationsIndexChange(10);
//                 }
//               },
//               trailing: const Icon(Icons.arrow_drop_down_rounded, color: Colors.white),
//               title: Text(
//                 drawerItem.title,
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontFamily: Constants.customFontSemiBoldFamily,
//                     fontWeight: FontWeight.w600,
//                     color: (i == _opearationsLastSelectedItem)
//                         ? AppColors.white
//                         : AppColors.white),
//                 // style: Styles.textStyleBlack16,
//               ),
//               leading: SizedBox(
//                 width: 18,
//                 height: 18,
//                 child: Image.asset(drawerItem.imageName,
//                     fit: BoxFit.fitHeight,
//                     color: (i == _opearationsLastSelectedItem)
//                         ? AppColors.white
//                         : AppColors.white),
//               ),
//               childrenPadding: const EdgeInsets.only(left: 20),
//               //children padding
//               children: buildDrawerChildren(context, drawerItem.title),
//             ),
//           ),
//         ),
//       );
//     }
//
//     return children;
//   }
//
//   _onExpansionSelectItem(int index, BuildContext context, MenuItem item) async {
//     _opearationsLastSelectedItem = index;
//     context.read<DrawerCubit>().getOperationsIndexChange(index);
//
//     switch (item.title) {
//       case Constants.annualPowerShutdownListTitle:
//         Navigator.pushNamed(context, annualPowerShutdownListRoute);
//         break;
//       case Constants.articleFoundRegisterListTitle:
//         Navigator.pushNamed(context, articleFoundNewListRoute);
//         break;
//       // case Constants.eventProtectionList:
//       //   Navigator.pushNamed(context, eventProtectionListRoute);
//       //   break;
//       // case Constants.incidentManagementTitle:
//       //   Navigator.pushNamed(context, incidentManagementsRoute);
//       //   break;
//       case Constants.lawEnforcementVisitsListTitle:
//         Navigator.pushNamed(context, lawEnforcementNewListRoute);
//         break;
//       case Constants.vVipVisitorsTitle:
//         Navigator.pushNamed(context, vipVisitorsListRoute);
//         break;
//
//       case Constants.parking:
//         Navigator.pushNamed(context, parkingListRoute);
//         break;
//       default:
//         break;
//     }
//   }
//
//   _onPassMgmtSelectItem(int index, BuildContext context) async {
//     _passlastSelectedItem = index;
//     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
//     switch (index) {
//       case 0:
//         log('day pass management index0');
//         Navigator.pushNamed(context, dayPassManagementListRoute, arguments: {
//           "passMngDetails": PassMngArguments(0, 'Day Pass Management', false)
//         });
//         break;
//       case 1:
//         log('day pass registry index1');
//         Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
//           "passMngRegisterDetails":
//           PassMngArguments(0, 'Day Pass Register', true)
//         });
//         break;
//       // case 2:
//       //   log('Sez pass Management index6');
//       //   Navigator.pushNamed(context, sezPassManagementListRoute, arguments: {
//       //     "passMngDetails": PassMngArguments(3, 'Sez Pass Management', false)
//       //   });
//       //   break;
//       // case 3:
//       //   log('Sez pass registry index7');
//       //   Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
//       //     "passMngRegisterDetails":
//       //     PassMngArguments(3, 'Sez Pass Register', true)
//       //   });
//         break;
//       case 2:
//         log('vendor pass management index4');
//         Navigator.pushNamed(context, vendorPassManagementListRoute, arguments: {
//           "passMngDetails": PassMngArguments(2, 'Vendor Pass Management', false)
//         });
//         break;
//       case 3:
//         log('vendor pass registry index5');
//         Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
//           "passMngRegisterDetails":
//           PassMngArguments(2, 'Vendor Pass Register', true)
//         });
//         break;
//       case 4:
//         log('visitor pass management index2');
//         Navigator.pushNamed(context, visitorPassManagementListRoute, arguments: {
//           "passMngDetails":
//           PassMngArguments(1, 'Visitor Pass Management', false)
//         });
//         break;
//       case 5:
//         log('visitor pass registry index3');
//         Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
//           "passMngRegisterDetails":
//           PassMngArguments(1, 'Visitor Pass Register', true)
//         });
//         break;
//       default:
//         break;
//     }
//   }
//
//   _onSecurityExpansionSelectItem(int index, BuildContext context) async {
//     // _menuScaffoldKey.currentState!.closeDrawer();
//     _securityfunfunctionslastSelectedItem = index;
//     context.read<DrawerCubit>().getSecurityIndexChange(index);
//     if (index == 0) {
//       Navigator.pushNamed(context, sstIncidentListRoute);
//     }
//   }
//
//   _onSelectItem(
//       int index,
//       BuildContext context,
//       ) async {
//     if (index != 5) {}
//     _lastSelectedItem = index;
//
//     context.read<DrawerCubit>().getIndexChange(index);
//     if (index != 2) {
//       _opearationsLastSelectedItem = 10;
//     }
//     if (index == 0) {
//     } else if (index == 1) {
//     } else if (index == 3) {
//       Navigator.pushNamed(
//         context,
//         resetPwdScreenRoute,
//         arguments: {'viaNavigationDrawer': true},
//       );
//     } else if (index == 4) {
//       Navigator.pushNamed(
//         context,
//         trainingModuleListRoute,
//         arguments: {},
//       );
//     }
//   }
//
//   List<Widget> buildDrawerChildren(
//       BuildContext context,
//       String title,
//       ) {
//     // log('--title---$title--');
//     switch (title) {
//       case Constants.eventProtection:
//         return _genericItemSelection(
//             context, eventProtectionDrawerItems, title);
//       case Constants.incidentManagementTitle:
//         return _genericItemSelection(
//             context, incidentManagementDrawerItems, title);
//       case Constants.materialMovement:
//         return _genericItemSelection(
//             context, materialMovementDrawerItemsWithReturnable, title);
//       case Constants.guardingOperations:
//         List<MenuItem> menuItems = [];
//         checkMenuPermissionsGuardingOperations(displayMenu, menuItems);
//         return _genericItemExpandable(
//           context,
//           menuItems,
//           Constants.guardingOperations,
//         );
//       case Constants.keyManagementData:
//         List<MenuItem> menuItems = [];
//
//         MenuPermissions()
//             .checkMenuPermissionsKeyManagementData(displayMenu, menuItems);
//         return _genericItemExpandable(
//           context,
//           menuItems,
//           Constants.keyManagementData,
//         );
//
//       case shiftSchedulingTitle:
//         List<MenuItem> menuItems = [];
//
//         MenuPermissions()
//             .checkMenuPermissionsShiftSchedule(displayMenu, menuItems);
//         return _genericItemExpandable(
//           context,
//           menuItems,
//           Constants.shiftSchedule,
//         );
//
//       case Constants.passManagement:
//         return _genericItemSelection(
//           context,
//           passTileDrawerItems,
//           title,
//         );
//       case Constants.sCRI:
//         return _genericItemSelection(
//           context,
//           sCRIItems,
//           title,
//         );
//       default:
//         log('-buildDrawerChildren-----else-----title--$title--');
//         return _genericItemSelection(
//             context, guardingOperationDrawerItems, title);
//     }
//   }
//
//   void checkMenuPermissionsGuardingOperations(
//       DisplayMenu? displayMenu,
//       List<MenuItem> menuItems,
//       ) {
//     if (displayMenu?.cD ?? false) {
//       menuItems.add(const MenuItem(
//           Constants.escalationMatrix, AppIcon.escalationMatrixIcon, 0));
//     }
//
//     if (displayMenu?.gM ?? false) {
//       menuItems.add(const MenuItem(
//           Constants.guardingMasterData, AppIcon.guardingMasterDataIcon, 0));
//     }
//
//     if (displayMenu?.gMR ?? false) {
//       menuItems.add(const MenuItem(
//           Constants.guardingMasterReport, AppIcon.guardingMasterReportIcon, 0));
//     }
//
//     if (displayMenu?.oCC ?? false) {
//       menuItems.add(const MenuItem(
//           Constants.shiftOccurrence, AppIcon.shiftOccurrenceIcon, 0));
//     }
//     // if (displayMenu?.sVP ?? false) {
//     //   menuItems.add(const MenuItem(Constants.slaViolationPenaltyTitle,
//     //       AppIcon.slaViolationPenaltyIcon, 0));
//     // }
//
//     menuItems.add(const MenuItem(Constants.patrolling,
//         AppIcon.slaViolationPenaltyIcon, 0));
//   }
// }
//
//

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/dashboard/navigation_drawer/views/menu_permissions.dart';

// The drawer keeps its "last selected" indexes in plain fields (as before).
// ignore: must_be_immutable
class NavigationDrawer1 extends StatelessWidget {
  NavigationDrawer1(
      this._menuScaffoldKey,
      this.username,
      this.email, {
        super.key,
      }) {
    /// Initialize Display Menu
    initializeDrawerItems();
  }

  late List<MenuItem> expansionTileDrawerItems = [];
  late List<MenuItem> securitySystemTicketsItems = [];

  DisplayMenu? displayMenu;

  final String? username;
  final String? email;
  final GlobalKey<ScaffoldState> _menuScaffoldKey;

  late int _lastSelectedItem = 0;
  late int _opearationsLastSelectedItem = 10;
  late int _passlastSelectedItem = 10;
  late int _securityfunfunctionslastSelectedItem = 10;
  late int _ticketingSystemlastSelectedItem = 1;
  late int _traininglastSelectedItem = 1;

  // TODO: Need to define all the Titles here
  static const String operationsTitle = Constants.operations;
  static const String shiftSchedulingTitle = Constants.shiftScheduling;
  static const String keyManagementDataTitle = Constants.keyManagementData;
  static const String vVipVisitorsTitle = Constants.vVipVisitorsTitle;
  static const String securitySystemsTitle = Constants.securitySystems;
  static const String ticketingSystemsTitle = Constants.ticketingSystem;

  // ---------------------------------------------------------------------------
  // Menu data
  // ---------------------------------------------------------------------------

  Future<void> initializeDrawerItems() async {
    expansionTileDrawerItems = await checkDisplayMenu();
    securitySystemTicketsItems = await securitySystemsDisplayMenu();
  }

  Future<List<MenuItem>> checkDisplayMenu() async {
    displayMenu = await SharedPrefs.getDisplayMenu();
    if (displayMenu == null) {
      return [];
    }

    final items = <MenuItem>[];

    if (displayMenu?.aps ?? false) {
      items.add(const MenuItem(Constants.annualPowerShutdownListTitle,
          AppIcon.annualPowerShutdownIcon, 0));
    }
    if (displayMenu?.aF ?? false) {
      items.add(const MenuItem(Constants.articleFoundRegisterListTitle,
          AppIcon.articleFoundRegisterIcon, 0));
    }
    if (displayMenu?.eP ?? false) {
      items.add(const MenuItem(
          Constants.eventProtection, AppIcon.eventProtectionIcon, 1));
    }

    items.add(const MenuItem(
        Constants.guardingOperations, AppIcon.guardingOperationIcon, 1));

    if (displayMenu?.iM ?? false) {
      items.add(const MenuItem(Constants.incidentManagementTitle,
          AppIcon.incidentManagementIcon, 1));
    }
    if (displayMenu?.keyMM ?? false) {
      items.add(const MenuItem(
          Constants.keyManagementData, AppIcon.keyManagementDataIcon, 1));
    }
    if (displayMenu?.lEO ?? false) {
      items.add(const MenuItem(Constants.lawEnforcementVisitsListTitle,
          AppIcon.lawEnforcementIcon, 0));
    }
    if (displayMenu?.mM ?? false) {
      items.add(const MenuItem(
          Constants.materialMovement, AppIcon.materialMovementIcon, 1));
    }
    if (displayMenu?.pM ?? false) {
      items.add(const MenuItem(
          Constants.passManagement, AppIcon.passManagementIcon, 1));
    }
    if (displayMenu?.sS ?? false) {
      items.add(
          const MenuItem(shiftSchedulingTitle, AppIcon.eventProtectionIcon, 1));
    }
    if (displayMenu?.vIP ?? false) {
      items.add(const MenuItem(vVipVisitorsTitle, AppIcon.vvipVisitorIcon, 0));
      items.add(
          const MenuItem(Constants.parking, AppIcon.transportIcon, 0));
    }

    return items;
  }

  Future<List<MenuItem>> securitySystemsDisplayMenu() async {
    displayMenu = await SharedPrefs.getDisplayMenu();
    if (displayMenu == null) {
      return [];
    }

    final items = <MenuItem>[];
    if (displayMenu?.gR ?? false) {
      items.add(const MenuItem(Constants.incident, AppIcon.incidentIcon, 0));
    }
    return items;
  }

  Future<void> getIndeifydrawerIndex() async {
    _lastSelectedItem = await SharedPrefs.getIdentifymenuindex();
  }

  // ---------------------------------------------------------------------------
  // Drawer shell  (GIG "white sheet" design)
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width,
      elevation: 0,
      backgroundColor: GigColors.indigo,
      child: Stack(
        children: [
          /// Indigo gradient
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1C10A0),
                    GigColors.indigo,
                    Color(0xFF0A0347),
                  ],
                ),
              ),
            ),
          ),

          /// Soft copper glow (top-right)
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(1.0, -1.0),
                  radius: 0.9,
                  colors: [
                    GigColors.copper.withValues(alpha: 0.4),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          /// Content: indigo header + white menu sheet
          SafeArea(
            bottom: false,
            child: BlocProvider(
              create: (context) => DrawerCubit(),
              child: BlocBuilder<DrawerCubit, DrawerState>(
                builder: (context, state) {
                  _syncSelection(state);

                  return Column(
                    children: [
                      _buildHeader(),
                      Expanded(child: _buildMenuSheet(context, state)),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Keeps the "last selected" fields in sync with the cubit state.
  void _syncSelection(DrawerState state) {
    switch (state.runtimeType) {
      case DrawerInitial _:
        _lastSelectedItem = (state as DrawerInitial).index;
        break;
      case GetDrawerItemChange _:
        _lastSelectedItem = (state as GetDrawerItemChange).index;
        break;
      case OperationsGetDrawerItemChange _:
        _opearationsLastSelectedItem =
            (state as OperationsGetDrawerItemChange).index;
        break;
      case SecurityFunctionsGetDrawerItemChange _:
        _securityfunfunctionslastSelectedItem =
            (state as SecurityFunctionsGetDrawerItemChange).index;
        break;
      case PassMgmtGetDrawerItemChange _:
        _passlastSelectedItem = (state as PassMgmtGetDrawerItemChange).index;
        break;
      case TicketingSystemGetDrawerItemChange _:
        _ticketingSystemlastSelectedItem =
            (state as TicketingSystemGetDrawerItemChange).index;
        break;
      case TrainingGetDrawerItemChange _:
        _traininglastSelectedItem =
            (state as TrainingGetDrawerItemChange).index;
        break;
      default:
        break;
    }
  }

  /// Logo (left) + close button (right) + profile
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 26),
      child: Column(
        children: [
          _buildTopBar(),
          const SizedBox(height: 22),
          _buildProfileCard(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        const GigLogoChip(height: 38),
        const Spacer(),
        GestureDetector(
          onTap: () {
            final scaffold = _menuScaffoldKey.currentState!;
            if (scaffold.isDrawerOpen) {
              scaffold.closeDrawer();
            } else {
              scaffold.openDrawer();
            }
          },
          child: Container(
            width: 42,
            height: 42,
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
            ),
            child: SvgPicture.asset(
              AppIcon.closeIcon,
              colorFilter:
              const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }

  /// Avatar + name + email (no card, sits directly on the indigo header)
  Widget _buildProfileCard() {
    final initial = (username?.isNotEmpty ?? false)
        ? username!.substring(0, 1).toUpperCase()
        : 'U';

    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFE3AE7C), Color(0xFFB8754A)],
            ),
            boxShadow: [
              BoxShadow(
                color: GigColors.copper.withValues(alpha: 0.45),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Text(
            initial,
            style: const TextStyle(
              fontFamily: kGigFont,
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: kGigFont,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                email ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: kGigFont,
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.75),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// White rounded sheet that holds the menu
  Widget _buildMenuSheet(BuildContext context, DrawerState state) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
        child: ListView(
          padding: EdgeInsets.fromLTRB(
              16, 22, 16, 24 + MediaQuery.of(context).padding.bottom),
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(6, 0, 6, 14),
              child: Text(
                'MENU',
                style: TextStyle(
                  fontFamily: kGigFont,
                  fontSize: 11,
                  letterSpacing: 2,
                  color: GigColors.muted,
                ),
              ),
            ),
            ..._buildDrawerChildren(context, state),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Reusable tile pieces (GIG style)
  //   level 0 = main menu, 1 = second level, 2+ = deeper levels
  // ---------------------------------------------------------------------------

  /// Rounded tile. Main level: lavender (selected = indigo).
  /// Nested levels: white / lavender with a thin border.
  Widget _glassyTile({
    required Widget child,
    bool isSelected = false,
    int level = 0,
    EdgeInsets margin = const EdgeInsets.symmetric(vertical: 5),
  }) {
    final isMain = level == 0;

    final Color fill;
    if (isSelected) {
      fill = isMain ? GigColors.indigo : const Color(0xFFEEEAFB);
    } else {
      fill = (isMain || level >= 2) ? GigColors.lavender : Colors.white;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      margin: margin,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: isMain ? 4 : 2),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(isMain ? 20 : 16),
        border: isMain
            ? null
            : Border.all(
          color: isSelected
              ? GigColors.indigo.withValues(alpha: 0.25)
              : GigColors.border,
        ),
        boxShadow: (isSelected && isMain)
            ? [
          BoxShadow(
            color: GigColors.indigo.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ]
            : null,
      ),
      // Lets ListTile / ExpansionTile ripples show above the tile colour.
      child: Material(type: MaterialType.transparency, child: child),
    );
  }

  /// Main level: icon inside a small rounded square. Nested: plain icon.
  Widget _menuIcon(
      String asset, {
        double size = 20,
        BoxFit fit = BoxFit.cover,
        bool selected = false,
        int level = 0,
      }) {
    final isMain = level == 0;
    final icon = SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        asset,
        fit: fit,
        color: isMain
            ? (selected ? Colors.white : GigColors.indigo)
            : (selected ? GigColors.copper : GigColors.indigo),
      ),
    );

    if (!isMain) return icon;

    return Container(
      width: 38,
      height: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: selected ? null : Colors.white,
        gradient: selected
            ? const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE3AE7C), Color(0xFFB8754A)],
        )
            : null,
      ),
      child: icon,
    );
  }

  Widget _menuTitle(
      String text, {
        double fontSize = 16,
        bool selected = false,
        int level = 0,
      }) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: kGigFont,
        fontSize: fontSize,
        fontWeight:
        (level == 0 || !selected) ? FontWeight.w600 : FontWeight.w700,
        color: (level == 0 && selected) ? Colors.white : GigColors.indigo,
      ),
    );
  }

  /// Simple (no children) menu row.
  Widget _menuTile({
    required MenuItem item,
    required VoidCallback onTap,
    bool selected = false,
    int level = 0,
    double iconSize = 20,
    BoxFit iconFit = BoxFit.cover,
    double fontSize = 16,
  }) {
    return _glassyTile(
      isSelected: selected,
      level: level,
      child: ListTile(
        dense: level != 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 4),
        leading: _menuIcon(item.imageName,
            size: iconSize, fit: iconFit, selected: selected, level: level),
        title: _menuTitle(item.title,
            fontSize: fontSize, selected: selected, level: level),
        onTap: onTap,
      ),
    );
  }

  /// Expandable menu row (default animated chevron, muted colour).
  Widget _expansionTile({
    required BuildContext context,
    required MenuItem item,
    required ValueChanged<bool> onExpansionChanged,
    required List<Widget> children,
    int level = 0,
    String? iconAsset,
    double iconSize = 20,
    BoxFit iconFit = BoxFit.cover,
    double fontSize = 16,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: _glassyTile(
        level: level,
        child: ExpansionTile(
          onExpansionChanged: onExpansionChanged,
          tilePadding: const EdgeInsets.symmetric(horizontal: 4),
          shape: const Border(),
          collapsedShape: const Border(),
          iconColor: GigColors.muted,
          collapsedIconColor: GigColors.muted,
          leading: _menuIcon(iconAsset ?? item.imageName,
              size: iconSize, fit: iconFit, level: level),
          title: _menuTitle(item.title, fontSize: fontSize, level: level),
          childrenPadding: const EdgeInsets.fromLTRB(8, 0, 0, 6),
          children: children,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Menu lists
  // ---------------------------------------------------------------------------

  List<Widget> _buildDrawerChildren(BuildContext context, DrawerState state) {
    final children = <Widget>[];

    for (int i = 0; i < mainDrawerItems.length; i++) {
      final drawerItem = mainDrawerItems[i];

      if (drawerItem.numberOfChildren == 0) {
        children.add(_menuTile(
          item: drawerItem,
          selected: i == _lastSelectedItem,
          onTap: () => _onSelectItem(i, context),
        ));
        continue;
      }

      children.add(_expansionTile(
        context: context,
        item: drawerItem,
        onExpansionChanged: (value) {
          if (value) {
            _lastSelectedItem = i;
            context.read<DrawerCubit>().getIndexChange(_lastSelectedItem);
          } else {
            _securityfunfunctionslastSelectedItem = 10;
            context.read<DrawerCubit>().getSecurityIndexChange(10);
          }
        },
        children: drawerItem.title == Constants.securityFunctions
            ? _buildOperationsFromSecurity(context, state)
            : drawerItem.title == Constants.training
            ? _buildTrainingFromSecurity(context, state)
            : _buildTicketingSystemFromSecurity(context, state),
      ));
    }

    return children;
  }

  List<Widget> _buildOperationsFromSecurity(
      BuildContext context, DrawerState state) {
    final menuItems = <MenuItem>[
      const MenuItem(Constants.operations, AppIcon.operationsIcon, 1),
      if (displayMenu?.sSSLA ?? false)
        const MenuItem(
            Constants.securitySystems, AppIcon.securitySystemIcon, 1),
    ];

    final children = <Widget>[];

    for (int i = 0; i < menuItems.length; i++) {
      final drawerItem = menuItems[i];

      children.add(_expansionTile(
        context: context,
        item: drawerItem,
        level: 1,
        // Icon mapping kept exactly as in the original code.
        iconAsset: i == 0
            ? AppIcon.operationsIcon
            : i == 1
            ? AppIcon.costBillingIcon
            : AppIcon.securitySystemIcon,
        onExpansionChanged: (value) {
          _securityfunfunctionslastSelectedItem = value ? i : 10;
          context
              .read<DrawerCubit>()
              .getSecurityIndexChange(_securityfunfunctionslastSelectedItem);
        },
        children: selectedChild(drawerItem, context),
      ));
    }

    return children;
  }

  List<Widget> _buildTicketingSystemFromSecurity(
      BuildContext context, DrawerState state) {
    const menuItems = [MenuItem(Constants.tickets, AppIcon.ticketsIcon, 1)];

    return [
      for (int i = 0; i < menuItems.length; i++)
        _menuTile(
          item: menuItems[i],
          level: 1,
          fontSize: 15,
          onTap: () => _onTicketingSystemItemSelected(i, context),
        ),
    ];
  }

  List<Widget> _buildTrainingFromSecurity(
      BuildContext context, DrawerState state) {
    const menuItems = [
      MenuItem(Constants.classroomTraining, AppIcon.tasklist, 0),
      MenuItem(Constants.selfPacedTraining, AppIcon.tasklist, 0),
    ];

    return [
      for (int i = 0; i < menuItems.length; i++)
        _menuTile(
          item: menuItems[i],
          level: 1,
          fontSize: 15,
          onTap: () => _onTrainingItemSelected(i, context),
        ),
    ];
  }

  List<Widget> selectedChild(MenuItem drawerItem, BuildContext context) {
    switch (drawerItem.title) {
      case operationsTitle:
        return _genericItemExpandable(
            context, expansionTileDrawerItems, operationsTitle);
      case Constants.securitySystems:
        return _genericItemExpandable(
            context, securitySystemTicketsItems, Constants.securitySystems);
      case ticketingSystemsTitle:
        return _genericItemExpandable(
            context, expansionTileDrawerItems, ticketingSystemsTitle);
      default:
        return [];
    }
  }

  List<Widget> _genericItemExpandable(
      BuildContext context,
      List<MenuItem> items,
      String title,
      ) {
    final children = <Widget>[];

    for (int i = 0; i < items.length; i++) {
      final drawerItem = items[i];

      if (drawerItem.numberOfChildren == 0) {
        children.add(_menuTile(
          item: drawerItem,
          level: 2,
          fontSize: 15,
          onTap: () {
            if (title == Constants.guardingOperations) {
              _onGuardingOperationItemSelected(i, context, drawerItem);
              return;
            }
            if (title == Constants.keyManagementData) {
              _onKeyManagementItemSelected(i, context);
              return;
            }
            if (title == Constants.shiftSchedule) {
              _onShiftScheduleItemSelected(i, context);
              return;
            }
            if (title == Constants.securitySystems) {
              _onSecuritySystemIncidentItemSelected(i, context);
              return;
            }
            _onExpansionSelectItem(i, context, drawerItem);
          },
        ));
        continue;
      }

      children.add(_expansionTile(
        context: context,
        item: drawerItem,
        level: 2,
        fontSize: 15,
        iconSize: 18,
        iconFit: BoxFit.fitHeight,
        onExpansionChanged: (value) {
          _opearationsLastSelectedItem = value ? i : 10;
          context
              .read<DrawerCubit>()
              .getOperationsIndexChange(_opearationsLastSelectedItem);
        },
        children: buildDrawerChildren(context, drawerItem.title),
      ));
    }

    return children;
  }

  List<Widget> _genericItemSelection(
      BuildContext context,
      List<MenuItem> items,
      String title,
      ) {
    final children = <Widget>[];

    for (int i = 0; i < items.length; i++) {
      final drawerItem = items[i];

      children.add(_menuTile(
        item: drawerItem,
        selected: i == _passlastSelectedItem,
        level: 2,
        iconSize: 22,
        iconFit: BoxFit.scaleDown,
        fontSize: 14,
        onTap: () {
          switch (title) {
          /// 2nd Level Menu
            case Constants.eventProtection:
              _onEventProtectionItemSelected(i, context);
              break;
            case Constants.incidentManagementTitle:
              _onIncidentManagementItemSelected(i, context);
              break;
            case Constants.materialMovement:
              _onMaterialMovementItemSelected(i, context);
              break;
            case Constants.passManagement:
              _onPassMgmtSelectItem(i, context);
              break;
            case Constants.sCRI:
              _onSCRIItemSelected(i, context);
              break;
            case Constants.ticketingSystem:
              _onTicketingSystemItemSelected(i, context);
              break;
            case Constants.training:
              _onTrainingItemSelected(i, context);
              break;

          /// 3rd Level Menu
            case Constants.guardingOperations:
              _onGuardingOperationItemSelected(i, context, drawerItem);
              break;
            case operationsTitle:
              break; // nothing to open for the "Operations" group itself
            case Constants.securitySystems:
              _onSecuritySystemIncidentItemSelected(i, context);
              break;
            case Constants.keyManagementData:
              _onKeyManagementItemSelected(i, context);
              break;
            case shiftSchedulingTitle:
              _onShiftScheduleItemSelected(i, context);
              break;
            default:
              _onSecuritySystemIncidentItemSelected(i, context);
          }
        },
      ));
    }

    return children;
  }

  List<Widget> buildDrawerChildren(BuildContext context, String title) {
    switch (title) {
      case Constants.eventProtection:
        return _genericItemSelection(
            context, eventProtectionDrawerItems, title);
      case Constants.incidentManagementTitle:
        return _genericItemSelection(
            context, incidentManagementDrawerItems, title);
      case Constants.materialMovement:
        return _genericItemSelection(
            context, materialMovementDrawerItemsWithReturnable, title);
      case Constants.guardingOperations:
        {
          final menuItems = <MenuItem>[];
          checkMenuPermissionsGuardingOperations(displayMenu, menuItems);
          return _genericItemExpandable(
              context, menuItems, Constants.guardingOperations);
        }
      case Constants.keyManagementData:
        {
          final menuItems = <MenuItem>[];
          MenuPermissions()
              .checkMenuPermissionsKeyManagementData(displayMenu, menuItems);
          return _genericItemExpandable(
              context, menuItems, Constants.keyManagementData);
        }
      case shiftSchedulingTitle:
        {
          final menuItems = <MenuItem>[];
          MenuPermissions()
              .checkMenuPermissionsShiftSchedule(displayMenu, menuItems);
          return _genericItemExpandable(
              context, menuItems, Constants.shiftSchedule);
        }
      case Constants.passManagement:
        return _genericItemSelection(context, passTileDrawerItems, title);
      case Constants.sCRI:
        return _genericItemSelection(context, sCRIItems, title);
      default:
        return _genericItemSelection(
            context, guardingOperationDrawerItems, title);
    }
  }

  void checkMenuPermissionsGuardingOperations(
      DisplayMenu? displayMenu,
      List<MenuItem> menuItems,
      ) {
    if (displayMenu?.cD ?? false) {
      menuItems.add(const MenuItem(
          Constants.escalationMatrix, AppIcon.escalationMatrixIcon, 0));
    }
    if (displayMenu?.gM ?? false) {
      menuItems.add(const MenuItem(
          Constants.guardingMasterData, AppIcon.guardingMasterDataIcon, 0));
    }
    if (displayMenu?.gMR ?? false) {
      menuItems.add(const MenuItem(
          Constants.guardingMasterReport, AppIcon.guardingMasterReportIcon, 0));
    }
    if (displayMenu?.oCC ?? false) {
      menuItems.add(const MenuItem(
          Constants.shiftOccurrence, AppIcon.shiftOccurrenceIcon, 0));
    }

    menuItems.add(const MenuItem(
        Constants.patrolling, AppIcon.slaViolationPenaltyIcon, 0));
  }

  // ---------------------------------------------------------------------------
  // Navigation handlers
  // ---------------------------------------------------------------------------

  void _onSelectItem(int index, BuildContext context) {
    _lastSelectedItem = index;
    context.read<DrawerCubit>().getIndexChange(index);

    if (index != 2) {
      _opearationsLastSelectedItem = 10;
    }

    switch (index) {
      case 3:
        Navigator.pushNamed(
          context,
          resetPwdScreenRoute,
          arguments: {'viaNavigationDrawer': true},
        );
        break;
      case 4:
        Navigator.pushNamed(context, trainingModuleListRoute, arguments: {});
        break;
      default:
        break;
    }
  }

  void _onExpansionSelectItem(int index, BuildContext context, MenuItem item) {
    _opearationsLastSelectedItem = index;
    context.read<DrawerCubit>().getOperationsIndexChange(index);

    switch (item.title) {
      case Constants.annualPowerShutdownListTitle:
        Navigator.pushNamed(context, annualPowerShutdownListRoute);
        break;
      case Constants.articleFoundRegisterListTitle:
        Navigator.pushNamed(context, articleFoundNewListRoute);
        break;
      case Constants.lawEnforcementVisitsListTitle:
        Navigator.pushNamed(context, lawEnforcementNewListRoute);
        break;
      case Constants.vVipVisitorsTitle:
        Navigator.pushNamed(context, vipVisitorsListRoute);
        break;
      case Constants.parking:
        Navigator.pushNamed(context, parkingListRoute);
        break;
      default:
        break;
    }
  }

  void _onGuardingOperationItemSelected(
      int index, BuildContext context, MenuItem item) {
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);

    switch (item.title) {
      case Constants.escalationMatrix:
        Navigator.pushNamed(context, contactDetailsListRoute);
        break;
      case Constants.guardingMasterData:
        Navigator.pushNamed(context, guardingMasterDataRoute);
        break;
      case Constants.guardingMasterReport:
        Navigator.pushNamed(context, guardingMasterReportRoute);
        break;
      case Constants.shiftOccurrence:
        Navigator.pushNamed(context, shiftOccurrenceRoute);
        break;
      case Constants.patrolling:
        Navigator.pushNamed(context, patrollingListRoute);
        break;
      default:
        break;
    }
  }

  void _onMaterialMovementItemSelected(int index, BuildContext context) {
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);

    switch (index) {
      case 0:
        Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
            arguments: {"isInward": true, "returnable": true});
        break;
      case 1:
        Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
            arguments: {"isInward": true, "returnable": false});
        break;
      case 2:
        Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
            arguments: {"isInward": false, "returnable": true});
        break;
      case 3:
        Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
            arguments: {"isInward": false, "returnable": false});
        break;
    }
  }

  void _onEventProtectionItemSelected(int index, BuildContext context) {
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);

    switch (index) {
      case 0:
        Navigator.pushNamed(context, eventProtectionListRoute);
        break;
      case 1:
        Navigator.pushNamed(context, csrEventListRoute, arguments: {
          ConstantsArgument.isCSREvent: true,
          ConstantsArgument.isSportEvent: false,
        });
        break;
      case 2:
        Navigator.pushNamed(context, csrEventListRoute, arguments: {
          ConstantsArgument.isSportEvent: true,
          ConstantsArgument.isCSREvent: false,
        });
        break;
    }
  }

  void _onIncidentManagementItemSelected(int index, BuildContext context) {
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);

    switch (index) {
      case 0:
        Navigator.pushNamed(context, incidentManagementsRoute);
        break;
      case 1:
        Navigator.pushNamed(context, transportMedicalListRoute,
            arguments: {ConstantsArgument.isTransport: true});
        break;
      case 2:
        Navigator.pushNamed(context, transportMedicalListRoute,
            arguments: {ConstantsArgument.isTransport: false});
        break;
    }
  }

  void _onSCRIItemSelected(int index, BuildContext context) {
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);

    if (index == 0) {
      Navigator.pushNamed(context, vipVisitorsListRoute);
    }
  }

  void _onSecurityFunctionsItemSelected(int index, BuildContext context) {
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);

    if (index == 0) {
      Navigator.pushNamed(context, sstIncidentListRoute);
    }
  }

  void _onSecurityExpansionSelectItem(int index, BuildContext context) {
    _securityfunfunctionslastSelectedItem = index;
    context.read<DrawerCubit>().getSecurityIndexChange(index);

    if (index == 0) {
      Navigator.pushNamed(context, sstIncidentListRoute);
    }
  }

  void _onSecuritySystemIncidentItemSelected(int index, BuildContext context) {
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);

    if (index == 0) {
      Navigator.pushNamed(context, sstIncidentListRoute,
          arguments: {"isInternal": true});
    }
  }

  void _onTicketingSystemItemSelected(int index, BuildContext context) {
    _ticketingSystemlastSelectedItem = index;
    context.read<DrawerCubit>().getTicketingSystemIndexChange(index);

    if (index == 0) {
      Navigator.pushNamed(context, ticketingSystemListRoute);
    }
  }

  void _onTrainingItemSelected(int index, BuildContext context) {
    _traininglastSelectedItem = index;
    context.read<DrawerCubit>().getTrainingIndexChange(index);

    switch (index) {
      case 0:
        Navigator.pushNamed(context, trainingModuleListRoute);
        break;
      case 1:
        Navigator.pushNamed(context, selfPacedTrainingListRoute);
        break;
    }
  }

  void _onKeyManagementItemSelected(int index, BuildContext context) {
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);

    switch (index) {
      case 0:
        Navigator.pushNamed(context, keyManagementMasterListRoute,
            arguments: {"Key Management Master": false});
        break;
      case 1:
        Navigator.pushNamed(context, keyManagementIssuanceListRoute,
            arguments: {"Key Management Issuance List": false});
        break;
      case 2:
        Navigator.pushNamed(context, keyLossDestructionListRoute,
            arguments: {"Key Loss Destruction List": false});
        break;
    }
  }

  void _onShiftScheduleItemSelected(int index, BuildContext context) {
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);

    switch (index) {
      case 0:
        Navigator.pushNamed(context, attendanceListRoute);
        break;
      case 1:
        Navigator.pushNamed(context, dutyPostMasterListRoute);
        break;
      case 2:
        Navigator.pushNamed(context, dutyPostNameMasterListRoute);
        break;
      case 3:
        Navigator.pushNamed(context, shiftScheduleListRoute);
        break;
      case 4:
        Navigator.pushNamed(context, attendanceReportBillingListRoute);
        break;
    }
  }

  void _onPassMgmtSelectItem(int index, BuildContext context) {
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);

    switch (index) {
      case 0:
        Navigator.pushNamed(context, dayPassManagementListRoute, arguments: {
          "passMngDetails": PassMngArguments(0, 'Day Pass Management', false),
        });
        break;
      case 1:
        Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
          "passMngRegisterDetails":
          PassMngArguments(0, 'Day Pass Register', true),
        });
        break;
      case 2:
        Navigator.pushNamed(context, vendorPassManagementListRoute,
            arguments: {
              "passMngDetails":
              PassMngArguments(2, 'Vendor Pass Management', false),
            });
        break;
      case 3:
        Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
          "passMngRegisterDetails":
          PassMngArguments(2, 'Vendor Pass Register', true),
        });
        break;
      case 4:
        Navigator.pushNamed(context, visitorPassManagementListRoute,
            arguments: {
              "passMngDetails":
              PassMngArguments(1, 'Visitor Pass Management', false),
            });
        break;
      case 5:
        Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
          "passMngRegisterDetails":
          PassMngArguments(1, 'Visitor Pass Register', true),
        });
        break;
      default:
        break;
    }
  }
}