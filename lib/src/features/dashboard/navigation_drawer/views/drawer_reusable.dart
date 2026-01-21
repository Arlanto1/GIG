// // import 'dart:developer';
// //
// // import 'package:db_atom/index.dart';
// // import 'package:db_atom/src/features/dashboard/navigation_drawer/views/menu_permissions.dart';
// //
// // class NavigationDrawer1 extends StatelessWidget {
// //   NavigationDrawer1(
// //     this._menuScaffoldKey,
// //     this.username,
// //     this.email, {
// //     super.key,
// //   }) {
// //     /// Initialize Display Menu
// //     initializeDrawerItems();
// //   }
// //
// //   late List<MenuItem> expansionTileDrawerItems = [];
// //   late List<MenuItem> costAndBillingExpansionTileDrawerItems = [];
// //   late List<MenuItem> securitySystemTicketsItems = [];
// //
// //   Future<void> initializeDrawerItems() async {
// //     expansionTileDrawerItems = await checkDisplayMenu();
// //     costAndBillingExpansionTileDrawerItems = await costBillingDisplayMenu();
// //     securitySystemTicketsItems = await securitySystemsDisplayMenu();
// //   }
// //
// //   DisplayMenu? displayMenu;
// //
// //   Future<List<MenuItem>> checkDisplayMenu() async {
// //     displayMenu = await SharedPrefs.getDisplayMenu();
// //     bool guardingOperations = ((displayMenu?.gM ?? false) ||
// //         (displayMenu?.cD ?? false) ||
// //         (displayMenu?.gR ?? false) ||
// //         (displayMenu?.oCC ?? false) ||
// //         (displayMenu?.sVP ?? false) ||
// //         (displayMenu?.gMR ?? false));
// //
// //     if (displayMenu == null) {
// //       return [];
// //     }
// //     List<MenuItem> expansionTileDrawerItems = [];
// //     if (displayMenu?.aps ?? false) {
// //       expansionTileDrawerItems.add(const MenuItem(
// //           Constants.annualPowerShutdownListTitle,
// //           AppIcon.annualPowerShutdownIcon,
// //           0));
// //     }
// //     if (displayMenu?.aF ?? false) {
// //       expansionTileDrawerItems.add(const MenuItem(
// //           Constants.articleFoundRegisterListTitle,
// //           AppIcon.articleFoundRegisterIcon,
// //           0));
// //     }
// //     if (displayMenu?.eP ?? false) {
// //       expansionTileDrawerItems.add(const MenuItem(
// //           Constants.eventProtectionList, AppIcon.eventProtectionIcon, 0));
// //     }
// //
// //     log('gm -- ${displayMenu?.gM}');
// //     if (guardingOperations) {
// //       expansionTileDrawerItems.add(const MenuItem(
// //           Constants.guardingOperations, AppIcon.guardingOperationIcon, 1));
// //     }
// //
// //     if (displayMenu?.iM ?? false) {
// //       expansionTileDrawerItems.add(const MenuItem(
// //           Constants.incidentManagementTitle,
// //           AppIcon.incidentManagementIcon,
// //           0));
// //     }
// //     if (displayMenu?.keyMM ?? false) {
// //       expansionTileDrawerItems.add(const MenuItem(
// //           Constants.keyManagementData, AppIcon.keyManagementDataIcon, 1));
// //     }
// //     if (displayMenu?.lEO ?? false) {
// //       expansionTileDrawerItems.add(const MenuItem(
// //           Constants.lawEnforcementVisitsListTitle,
// //           AppIcon.lawEnforcementIcon,
// //           0));
// //     }
// //
// //     if (displayMenu?.mM ?? false) {
// //       expansionTileDrawerItems.add(const MenuItem(
// //           Constants.materialMovement, AppIcon.materialMovementIcon, 1));
// //     }
// //     if (displayMenu?.pM ?? false) {
// //       expansionTileDrawerItems.add(const MenuItem(
// //           Constants.passManagement, AppIcon.passManagementIcon, 1));
// //     }
// //
// //     if (displayMenu?.sS ?? false) {
// //       expansionTileDrawerItems.add(
// //           const MenuItem(shiftSchedulingTitle, AppIcon.eventProtectionIcon, 1));
// //     }
// //
// //     if (displayMenu?.vIP ?? false) {
// //       expansionTileDrawerItems
// //           .add(const MenuItem(vVipVisitorsTitle, AppIcon.vvipVisitorIcon, 0));
// //     }
// //
// //     return expansionTileDrawerItems;
// //   }
// //
// //   Future<List<MenuItem>> costBillingDisplayMenu() async {
// //     displayMenu = await SharedPrefs.getDisplayMenu();
// //     if (displayMenu == null) {
// //       return [];
// //     }
// //     List<MenuItem> costAndBillingExpansionTileDrawerItems = [];
// //     if (displayMenu?.gR ?? false) {
// //       costAndBillingExpansionTileDrawerItems.add(const MenuItem(
// //           Constants.guardingRates, AppIcon.guardingRatesIcon, 0));
// //     }
// //     return costAndBillingExpansionTileDrawerItems;
// //   }
// //
// //   Future<List<MenuItem>> securitySystemsDisplayMenu() async {
// //     displayMenu = await SharedPrefs.getDisplayMenu();
// //     if (displayMenu == null) {
// //       return [];
// //     }
// //     List<MenuItem> securitySystemTicketsItems = [];
// //     if (displayMenu?.gR ?? false) {
// //       securitySystemTicketsItems
// //           .add(const MenuItem(Constants.incident, AppIcon.incidentIcon, 0));
// //     }
// //     return securitySystemTicketsItems;
// //   }
// //
// //   final String? username;
// //   final String? email;
// //   final GlobalKey<ScaffoldState> _menuScaffoldKey;
// //
// //   late int _lastSelectedItem = 0;
// //   late int _opearationsLastSelectedItem = 10;
// //   late int _passlastSelectedItem = 10;
// //   late int _securityfunfunctionslastSelectedItem = 10;
// //   late int _ticketingSystemlastSelectedItem = 1;
// //
// //   Future<void> getIndeifydrawerIndex() async {
// //     _lastSelectedItem = await SharedPrefs.getIdentifymenuindex();
// //   }
// //
// //   // TODO: Need to define all the Titles here
// //   static const String operationsTitle = Constants.operations;
// //   static const String costAndBillingTitle = Constants.costAndBilling;
// //   static const String shiftSchedulingTitle = Constants.shiftScheduling;
// //   static const String keyManagementDataTitle = Constants.keyManagementData;
// //   static const String vVipVisitorsTitle = Constants.vVipVisitorsTitle;
// //   static const String securitySystemsTitle = Constants.securitySystems;
// //   static const String ticketingSystemsTitle = Constants.ticketingSystem;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Theme(
// //       data: Theme.of(context).copyWith(
// //         canvasColor: AppColors
// //             .backgroundWhiteColor, //This will change the drawer background to blue.
// //         //other styles
// //       ),
// //       child: Drawer(
// //         child: BlocProvider(
// //           create: (context) => DrawerCubit(),
// //           child: BlocBuilder<DrawerCubit, DrawerState>(
// //             builder: (context, state) {
// //               switch (state.runtimeType) {
// //                 case DrawerInitial:
// //                   _lastSelectedItem = (state as DrawerInitial).index;
// //                   break;
// //                 case GetDrawerItemChange:
// //                   _lastSelectedItem = (state as GetDrawerItemChange).index;
// //                   break;
// //                 case OperationsGetDrawerItemChange:
// //                   log('drawer operation ');
// //                   _opearationsLastSelectedItem =
// //                       (state as OperationsGetDrawerItemChange).index;
// //                   break;
// //                 case SecurityFunctionsGetDrawerItemChange:
// //                   _securityfunfunctionslastSelectedItem =
// //                       (state as SecurityFunctionsGetDrawerItemChange).index;
// //                   break;
// //                 case PassMgmtGetDrawerItemChange:
// //                   _passlastSelectedItem =
// //                       (state as PassMgmtGetDrawerItemChange).index;
// //                   break;
// //                 case TicketingSystemGetDrawerItemChange:
// //                   _ticketingSystemlastSelectedItem =
// //                       (state as TicketingSystemGetDrawerItemChange).index;
// //                   break;
// //                 default:
// //                   break;
// //               }
// //
// //               return ListView(
// //                 children: <Widget>[
// //                   Column(
// //                     children: [
// //                       Padding(
// //                         padding: const EdgeInsets.only(right: 20.0),
// //                         child: Align(
// //                             alignment: Alignment.centerRight,
// //                             child: GestureDetector(
// //                                 onTap: () async {
// //                                   if (_menuScaffoldKey
// //                                       .currentState!.isDrawerOpen) {
// //                                     _menuScaffoldKey.currentState!
// //                                         .closeDrawer();
// //                                     //close drawer, if drawer is open
// //                                   } else {
// //                                     _menuScaffoldKey.currentState!.openDrawer();
// //                                     //open drawer, if drawer is closed
// //                                   }
// //                                 },
// //                                 child: SvgPicture.asset(
// //                                     AppIcon.closeicon) //Icon(Icons.cancel)
// //                                 // const Icon(
// //                                 //   Icons.cancel,
// //                                 // ),
// //                                 )),
// //                       ),
// //                       DrawerHeaderWidget(
// //                         username: username ?? '',
// //                         email: email ?? '',
// //                       ),
// //                       Column(
// //                         children: _buildDrawerChildren(context, state),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               );
// //             },
// //           ),
// //         ),
// //       ),
// //     ); //
// //   }
// //
// //   List<Widget> _genericItemSelection(
// //     BuildContext context,
// //     List<MenuItem> items,
// //     String title,
// //   ) {
// //     List<Widget> children = [];
// //
// //     for (int i = 0; i < items.length; i++) {
// //       MenuItem drawerItem = items[i];
// //       children.add(
// //         Container(
// //           decoration: const BoxDecoration(
// //             border: Border(
// //                 bottom: BorderSide(color: AppColors.divideLineGreyColor)),
// //           ),
// //           child: ListTile(
// //             leading: SizedBox(
// //                 width: 20,
// //                 height: 20,
// //                 child: Image.asset(drawerItem.imageName,
// //                     fit: BoxFit.scaleDown,
// //                     color: (i == _passlastSelectedItem)
// //                         ? AppColors.navigationSkyBlueColor
// //                         : AppColors.boldGreyBackground)),
// //             title: Text(drawerItem.title,
// //                 //style: Styles.textStyleBlack16,
// //                 style: TextStyle(
// //                     fontSize: 16,
// //                     fontFamily: Constants.customFontSemiBoldFamily,
// //                     fontWeight: FontWeight.w600,
// //                     color: (i == _passlastSelectedItem)
// //                         ? AppColors.navigationSkyBlueColor
// //                         : AppColors.textGreyThemeColor)),
// //             //selected: i == _lastSelectedItem,
// //             onTap: () {
// //               // log('-_genericItemSelection---title---$title---');
// //               switch (title) {
// //                 /// 2nd Level Menu
// //                 case Constants.materialMovement:
// //                   _onMaterialMovementItemSelected(i, context);
// //                   break;
// //                 case Constants.passManagement:
// //                   _onPassMgmtSelectItem(i, context);
// //                   break;
// //                 case Constants.sCRI:
// //                   _onSCRIItemSelected(i, context);
// //                   break;
// //                 case Constants.securityFunctions:
// //                   _onSecurityFunctionsItemSelected(i, context);
// //                   break;
// //
// //
// //                 case Constants.ticketingSystem:
// //                   _onTicketingSystemItemSelected(i, context);
// //                   break;
// //
// //                 /// 3nd Level Menu
// //                 case Constants.guardingOperations:
// //                   _onGuardingOperationItemSelected(i, context, drawerItem);
// //                   break;
// //
// //                 // case Constants.securitySystemTickets:
// //                 //   _onSecuritySystemIncidentItemSelected(i, context);
// //                 //   break;
// //
// //                 case operationsTitle:
// //                   buildDrawerChildren(context, drawerItem.title);
// //                   break;
// //
// //                 case Constants.costAndBilling:
// //                   _onCostAndBillingItemSelected(i, context);
// //                   break;
// //
// //                 case Constants.securitySystems:
// //                   _onSecuritySystemIncidentItemSelected(i, context);
// //                   break;
// //
// //                 case Constants.keyManagementData:
// //                   _onKeyManagementItemSelected(
// //                     i,
// //                     context,
// //                   );
// //                   break;
// //
// //                 case shiftSchedulingTitle:
// //                   _onShiftScheduleItemSelected(i, context);
// //                   break;
// //
// //
// //                 // case 'Guarding Operations':
// //                 //   log('----_genericExpandableDrawer--case keyManagementMaster--title----$title--');
// //                 //   _genericExpandableDrawer(
// //                 //     context,
// //                 //     keyManagementDataItems,
// //                 //     Constants.keyManagementMaster,
// //                 //   );
// //                 //   break;
// //                 // Add more cases for other titles as needed
// //                 default:
// //                   log('---default-------');
// //                   _onSecuritySystemIncidentItemSelected(i, context);
// //                 // Default case if title doesn't match any specific condition
// //               }
// //             },
// //           ),
// //         ),
// //       );
// //     }
// //
// //     return children;
// //   }
// //
// //   _onMaterialMovementItemSelected(int index, BuildContext context) async {
// //     // _menuScaffoldKey.currentState!.closeDrawer();
// //     _passlastSelectedItem = index;
// //     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
// //     if (index == 0) {
// //       Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
// //           arguments: {"isInward": true});
// //     } else if (index == 1) {
// //       Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
// //           arguments: {
// //             "isInward": false, "returnable": true,
// //           });
// //     }
// //     else if(index == 2){
// //       Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
// //           arguments: {
// //             "isInward": false, "returnable": false,
// //           });
// //     }
// //   }
// //
// //   _onSCRIItemSelected(int index, BuildContext context) async {
// //     // _menuScaffoldKey.currentState!.closeDrawer();
// //     _passlastSelectedItem = index;
// //     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
// //     if (index == 0) {
// //       Navigator.pushNamed(
// //         context,
// //         vipVisitorsListRoute,
// //       );
// //     }
// //   }
// //
// //   _onSecurityFunctionsItemSelected(int index, BuildContext context) async {
// //     // _menuScaffoldKey.currentState!.closeDrawer();
// //     _passlastSelectedItem = index;
// //     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
// //     if (index == 0) {
// //       Navigator.pushNamed(
// //         context,
// //         sstIncidentListRoute,
// //       );
// //     }
// //   }
// //   _onTicketingSystemItemSelected(int index, BuildContext context) async {
// //     // _menuScaffoldKey.currentState!.closeDrawer();
// //     _ticketingSystemlastSelectedItem = index;
// //     context.read<DrawerCubit>().getTicketingSystemIndexChange(index);
// //     if (index == 0) {
// //       Navigator.pushNamed(
// //         context,
// //         ticketingSystemListRoute,
// //       );
// //     }
// //   }
// //
// //   _onSecuritySystemIncidentItemSelected(int index, BuildContext context) async {
// //     log('-_onSecuritySystemIncidentItemSelected------');
// //
// //     // _menuScaffoldKey.currentState!.closeDrawer();
// //     _passlastSelectedItem = index;
// //     //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
// //     //state = const DrawerInitial();
// //     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
// //     if (index == 0) {
// //       Navigator.pushNamed(context, sstIncidentListRoute,
// //           arguments: {"isInternal": true});
// //     }
// //     // else if (index == 1) {
// //     //   Navigator.pushNamed(context, sstIncidentListRoute,
// //     //       arguments: {"isInternal": false});
// //     // }
// //   }
// //
// //   _onKeyManagementItemSelected(int index, BuildContext context) async {
// //     // _menuScaffoldKey.currentState!.closeDrawer();
// //     // _passlastSelectedItem = index;
// //     //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
// //     //state = const DrawerInitial();
// //     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
// //     switch (index) {
// //       case 0:
// //         Navigator.pushNamed(context, keyManagementMasterListRoute,
// //             arguments: {"Key Management Master": false});
// //         break;
// //       case 1:
// //         Navigator.pushNamed(context, keyManagementIssuanceListRoute,
// //             arguments: {"Key Management Issuance List": false});
// //         break;
// //       case 2:
// //         Navigator.pushNamed(context, keyLossDestructionListRoute,
// //             arguments: {"Key Loss Destruction List": false});
// //         break;
// //     }
// //   }
// //
// //   _onShiftScheduleItemSelected(int index, BuildContext context) async {
// //     // _menuScaffoldKey.currentState!.closeDrawer();
// //     _passlastSelectedItem = index;
// //
// //     //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
// //     //state = const DrawerInitial();
// //     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
// //     switch (index) {
// //       case 0:
// //         Navigator.pushNamed(context, attendanceListRoute);
// //         break;
// //       case 1:
// //         Navigator.pushNamed(context, dutyPostMasterListRoute);
// //         break;
// //       case 2:
// //         Navigator.pushNamed(context, dutyPostNameMasterListRoute);
// //         break;
// //       case 3:
// //         Navigator.pushNamed(context, shiftScheduleListRoute);
// //         break;
// //       case 4:
// //         Navigator.pushNamed(context, attendanceReportBillingListRoute);
// //         break;
// //       default:
// //         break;
// //     }
// //   }
// //
// //   _onCostAndBillingItemSelected(int index, BuildContext context) async {
// //     // _menuScaffoldKey.currentState!.closeDrawer();
// //     _passlastSelectedItem = index;
// //     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
// //     if (index == 0) {
// //       Navigator.pushNamed(context, guardingRatesRoute);
// //     }
// //   }
// //
// //   // TODO: Fix the Drawer Index
// //   _onGuardingOperationItemSelected(
// //       int index, BuildContext context, MenuItem item) async {
// //     // _menuScaffoldKey.currentState!.closeDrawer();
// //     _passlastSelectedItem = index;
// //     //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
// //     //state = const DrawerInitial();
// //     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
// //
// //     log('--item.title--${item.title}--');
// //
// //     switch (item.title) {
// //       case Constants.escalationMatrix:
// //         Navigator.pushNamed(context, contactDetailsListRoute);
// //         break;
// //       case Constants.guardingMasterData:
// //         Navigator.pushNamed(context, guardingMasterDataRoute);
// //         break;
// //       case Constants.guardingMasterReport:
// //         log('--Constants.guardingMasterReportTitle--${item.title}--');
// //         return Navigator.pushNamed(context, guardingMasterReportRoute);
// //       // break;
// //       case Constants.shiftOccurrence:
// //         Navigator.pushNamed(context, shiftOccurrenceRoute);
// //         break;
// //       case Constants.slaViolationPenaltyTitle:
// //         Navigator.pushNamed(context, slaViolationPenaltyListRoute);
// //         break;
// //       default:
// //         break;
// //     }
// //   }
// //
// //   List<Widget> _buildDrawerChildren(BuildContext context, DrawerState state) {
// //     List<Widget> children = [];
// //
// //     for (int i = 0; i < mainDrawerItems.length; i++) {
// //       MenuItem drawerItem = mainDrawerItems[i];
// //       children.add(
// //         drawerItem.numberOfChildren == 0
// //             ? Container(
// //                 decoration: const BoxDecoration(
// //                   border: Border(
// //                       bottom: BorderSide(color: AppColors.divideLineGreyColor)),
// //                 ),
// //                 child: ListTile(
// //                   leading: SizedBox(
// //                       width: 20,
// //                       height: 20,
// //                       child: Image.asset(drawerItem.imageName,
// //                           fit: BoxFit.cover,
// //                           color: (i == _lastSelectedItem)
// //                               ? AppColors.navigationSkyBlueColor
// //                               : AppColors.textGreyThemeColor)),
// //                   title: Text(drawerItem.title,
// //                       //style: Styles.textStyleBlack16,
// //                       style: TextStyle(
// //                           fontSize: 16,
// //                           fontFamily: Constants.customFontSemiBoldFamily,
// //                           fontWeight: FontWeight.w600,
// //                           color: (i == _lastSelectedItem)
// //                               ? AppColors.navigationSkyBlueColor
// //                               : AppColors.textGreyThemeColor)),
// //                   //selected: i == _lastSelectedItem,
// //                   onTap: () => _onSelectItem(
// //                     i,
// //                     context,
// //                   ),
// //                 ),
// //               )
// //             : Theme(
// //                 data: Theme.of(context)
// //                     .copyWith(dividerColor: Colors.transparent),
// //                 child: Container(
// //                   decoration: const BoxDecoration(
// //                     border: Border(
// //                         bottom:
// //                             BorderSide(color: AppColors.divideLineGreyColor)),
// //                   ),
// //                   child: ExpansionTile(
// //                       onExpansionChanged: (value) {
// //                         if (value == true) {
// //                           _lastSelectedItem = i;
// //                           //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
// //                           //state = const DrawerInitial();
// //                           context
// //                               .read<DrawerCubit>()
// //                               .getIndexChange(_lastSelectedItem);
// //                         } else{
// //                           _securityfunfunctionslastSelectedItem = 10;
// //                           context
// //                               .read<DrawerCubit>()
// //                               .getSecurityIndexChange(10);
// //                         }
// //
// //                       },
// //                       trailing: const Icon(Icons.arrow_drop_down_rounded),
// //                       // trailing: const SizedBox.shrink(),
// //                       title: Text(
// //                         drawerItem.title,
// //                         style: TextStyle(
// //                             fontSize: 16,
// //                             fontFamily: Constants.customFontSemiBoldFamily,
// //                             fontWeight: FontWeight.w600,
// //                             color: (i == _lastSelectedItem)
// //                                 ? AppColors.navigationSkyBlueColor
// //                                 : AppColors.textGreyThemeColor),
// //                         // style: Styles.textStyleBlack16,
// //                       ),
// //                       leading: SizedBox(
// //                           width: 20,
// //                           height: 20,
// //                           child: Image.asset(drawerItem.imageName,
// //                               fit: BoxFit.cover,
// //                               color: (i == _lastSelectedItem)
// //                                   ? AppColors.navigationSkyBlueColor
// //                                   : AppColors.textGreyThemeColor)),
// //                       childrenPadding: const EdgeInsets.only(left: 20),
// //                       //children padding
// //                       children: drawerItem.title == Constants.securityFunctions ? _buildOperationsFromSecurity(context, state) : _buildTicketingSystemFromSecurity(context,state)),
// //                 ),
// //               ),
// //       );
// //     }
// //
// //     return children;
// //   }
// //
// //     List<Widget> _buildOperationsFromSecurity(
// //         BuildContext context, DrawerState state) {
// //       List<Widget> children = [];
// //
// //       List<MenuItem> menuItems = [];
// //       menuItems
// //           .add(const MenuItem(Constants.operations, AppIcon.operationsIcon, 1));
// //       if (displayMenu?.gR ?? false) {
// //         menuItems.add(
// //             const MenuItem(Constants.costAndBilling, AppIcon.costBillingIcon, 1));
// //       }
// //       if (displayMenu?.sSSLA ?? false) {
// //         menuItems.add(const MenuItem(
// //             Constants.securitySystems, AppIcon.securitySystemIcon, 1));
// //       }
// //
// //       for (int i = 0; i < menuItems.length; i++) {
// //         MenuItem drawerItem = menuItems[i];
// //         children.add(
// //           drawerItem.numberOfChildren == 0
// //               ? Container(
// //                   decoration: const BoxDecoration(
// //                     border: Border(
// //                         bottom: BorderSide(color: AppColors.divideLineGreyColor)),
// //                   ),
// //                   child: ListTile(
// //                     leading: SizedBox(
// //                         width: 20,
// //                         height: 20,
// //                         child: Image.asset(
// //                           drawerItem.imageName,
// //                           //fit: BoxFit.cover,
// //                           color: (i == _securityfunfunctionslastSelectedItem)
// //                               ? AppColors.navigationSkyBlueColor
// //                               : AppColors.geryLightBackground,
// //                         )),
// //                     title: Text(drawerItem.title,
// //                         //style: Styles.textStyleBlack16,
// //                         style: TextStyle(
// //                             fontSize: 16,
// //                             fontFamily: Constants.customFontSemiBoldFamily,
// //                             fontWeight: FontWeight.w600,
// //                             color: (i == _securityfunfunctionslastSelectedItem)
// //                                 ? AppColors.navigationSkyBlueColor
// //                                 : AppColors.textGreyThemeColor)),
// //                     //selected: i == _lastSelectedItem,
// //                     onTap: () => _onSecurityExpansionSelectItem(i, context),
// //                   ),
// //                 )
// //               : Theme(
// //                   data: Theme.of(context)
// //                       .copyWith(dividerColor: Colors.transparent),
// //                   child: Container(
// //                     decoration: const BoxDecoration(
// //                       border: Border(
// //                           bottom:
// //                               BorderSide(color: AppColors.divideLineGreyColor)),
// //                     ),
// //                     child: ExpansionTile(
// //                       onExpansionChanged: (value) {
// //                         if (value == true) {
// //                           _securityfunfunctionslastSelectedItem = i;
// //                           //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
// //                           //state = const DrawerInitial();
// //                           context.read<DrawerCubit>().getSecurityIndexChange(
// //                               _securityfunfunctionslastSelectedItem);
// //                         } else {
// //                           _securityfunfunctionslastSelectedItem = 10;
// //                           context.read<DrawerCubit>().getSecurityIndexChange(
// //                               _securityfunfunctionslastSelectedItem);
// //                         }
// //                       },
// //                       trailing: const Icon(Icons.arrow_drop_down_rounded),
// //                       title: Text(
// //                         drawerItem.title,
// //                         style: TextStyle(
// //                             fontSize: 16,
// //                             fontFamily: Constants.customFontSemiBoldFamily,
// //                             fontWeight: FontWeight.w600,
// //                             color: (i == _lastSelectedItem)
// //                                 ? AppColors.navigationSkyBlueColor
// //                                 : AppColors.textGreyThemeColor),
// //                         // style: Styles.textStyleBlack16,
// //                       ),
// //                       leading: SizedBox(
// //                         width: 20,
// //                         height: 20,
// //                         child: Image.asset(
// //                             i == 0
// //                                 ? AppIcon.operationsIcon
// //                                 : i == 1
// //                                     ? AppIcon.costBillingIcon
// //                                     : AppIcon.securitySystemIcon,
// //                             fit: BoxFit.cover,
// //                             color: (i == _lastSelectedItem)
// //                                 ? AppColors.navigationSkyBlueColor
// //                                 : AppColors.textGreyThemeColor),
// //                       ),
// //                       childrenPadding: const EdgeInsets.only(left: 20),
// //                       //children padding
// //                       children: selectedChild(drawerItem, context),
// //                     ),
// //                   ),
// //                 ),
// //         );
// //       }
// //
// //       return children;
// //     }
// //
// //   List<Widget> _buildTicketingSystemFromSecurity(
// //       BuildContext context, DrawerState state) {
// //     List<Widget> children = [];
// //
// //     List<MenuItem> menuItems = [];
// //     menuItems
// //         .add(const MenuItem(Constants.tickets, AppIcon.ticketsIcon, 1));
// //
// //     for (int i = 0; i < menuItems.length; i++) {
// //       MenuItem drawerItem = menuItems[i];
// //       children.add(
// //       Container(
// //           decoration: const BoxDecoration(
// //             border: Border(
// //                 bottom: BorderSide(color: AppColors.divideLineGreyColor)),
// //           ),
// //           child: ListTile(
// //             leading: SizedBox(
// //                 width: 20,
// //                 height: 20,
// //                 child: Image.asset(
// //                   drawerItem.imageName,
// //                   //fit: BoxFit.cover,
// //                   color: (i == _ticketingSystemlastSelectedItem)
// //                       ? AppColors.navigationSkyBlueColor
// //                       : AppColors.textGreyThemeColor,
// //                 )),
// //             title: Text(drawerItem.title,
// //                 //style: Styles.textStyleBlack16,
// //                 style: TextStyle(
// //                     fontSize: 16,
// //                     fontFamily: Constants.customFontSemiBoldFamily,
// //                     fontWeight: FontWeight.w600,
// //                     color: (i == _ticketingSystemlastSelectedItem)
// //                         ? AppColors.navigationSkyBlueColor
// //                         : AppColors.textGreyThemeColor)),
// //             //selected: i == _lastSelectedItem,
// //             onTap: () => _onTicketingSystemItemSelected(i, context),
// //           ),
// //         )
// //       );
// //     }
// //
// //     return children;
// //   }
// //
// //
// //   List<Widget> selectedChild(MenuItem drawerItem, BuildContext context) {
// //     switch (drawerItem.title) {
// //       case operationsTitle:
// //         return _genericItemExpandable(
// //           context,
// //           expansionTileDrawerItems,
// //           operationsTitle,
// //         );
// //
// //       case Constants.costAndBilling:
// //         return _genericItemExpandable(
// //           context,
// //           costAndBillingExpansionTileDrawerItems,
// //           Constants.costAndBilling,
// //         );
// //
// //       case Constants.securitySystems:
// //         return _genericItemExpandable(
// //           context,
// //           securitySystemTicketsItems,
// //           Constants.securitySystems,
// //         );
// //       case ticketingSystemsTitle:
// //         return _genericItemExpandable(
// //           context,
// //           expansionTileDrawerItems,
// //           ticketingSystemsTitle,
// //         );
// //       default:
// //         return [];
// //     }
// //   }
// //
// //   List<Widget> _genericItemExpandable(
// //     BuildContext context,
// //     List<MenuItem> items,
// //     String title,
// //   ) {
// //     List<Widget> children = [];
// //
// //     for (int i = 0; i < items.length; i++) {
// //       MenuItem drawerItem = items[i];
// //       // log('--drawerItem-title-${drawerItem.title}--');
// //       children.add(
// //         drawerItem.numberOfChildren == 0
// //             ? Container(
// //                 decoration: const BoxDecoration(
// //                   border: Border(
// //                       bottom: BorderSide(color: AppColors.divideLineGreyColor)),
// //                 ),
// //                 child: ListTile(
// //                   leading: SizedBox(
// //                       width: 20,
// //                       height: 20,
// //                       child: Image.asset(drawerItem.imageName,
// //                           fit: BoxFit.cover,
// //                           color: (i == _opearationsLastSelectedItem)
// //                               ? AppColors.navigationSkyBlueColor
// //                               : AppColors.textGreyThemeColor)),
// //                   title: Text(drawerItem.title,
// //                       //style: Styles.textStyleBlack16,
// //                       style: TextStyle(
// //                           fontSize: 16,
// //                           fontFamily: Constants.customFontSemiBoldFamily,
// //                           fontWeight: FontWeight.w600,
// //                           color: (i == _opearationsLastSelectedItem)
// //                               ? AppColors.navigationSkyBlueColor
// //                               : AppColors.textGreyThemeColor)),
// //                   // selected: i == _lastSelectedItem,
// //                   onTap: () {
// //                     // log('-onTap-----title---$title---');
// //                     if (title == Constants.guardingOperations) {
// //                       _onGuardingOperationItemSelected(i, context, drawerItem);
// //                       return;
// //                     }
// //
// //                     if (title == Constants.keyManagementData) {
// //                       _onKeyManagementItemSelected(i, context);
// //                       return;
// //                     }
// //                     if (title == Constants.shiftSchedule) {
// //                       _onShiftScheduleItemSelected(i, context);
// //                       return;
// //                     }
// //                     if (title == Constants.costAndBilling) {
// //                       _onCostAndBillingItemSelected(i, context);
// //                       return;
// //                     }
// //
// //                     log('--title-$title-');
// //                     if (title == Constants.securitySystems) {
// //                       _onSecuritySystemIncidentItemSelected(i, context);
// //                       return;
// //                     }
// //
// //                     _onExpansionSelectItem(i, context, drawerItem);
// //                   },
// //                 ),
// //               )
// //             : Theme(
// //                 data: Theme.of(context)
// //                     .copyWith(dividerColor: Colors.transparent),
// //                 child: Container(
// //                   decoration: const BoxDecoration(
// //                     border: Border(
// //                         bottom:
// //                             BorderSide(color: AppColors.divideLineGreyColor)),
// //                   ),
// //                   child: ExpansionTile(
// //                     onExpansionChanged: (value) {
// //                       if (value == true) {
// //                         _opearationsLastSelectedItem = i;
// //                         //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
// //                         //state = const DrawerInitial();
// //                         context.read<DrawerCubit>().getOperationsIndexChange(
// //                             _opearationsLastSelectedItem);
// //                       } else {
// //                         _opearationsLastSelectedItem = 10;
// //                         context
// //                             .read<DrawerCubit>()
// //                             .getOperationsIndexChange(10);
// //                       }
// //                     },
// //                     trailing: const Icon(Icons.arrow_drop_down_rounded),
// //                     title: Text(
// //                       drawerItem.title,
// //                       style: TextStyle(
// //                           fontSize: 16,
// //                           fontFamily: Constants.customFontSemiBoldFamily,
// //                           fontWeight: FontWeight.w600,
// //                           color: (i == _opearationsLastSelectedItem)
// //                               ? AppColors.navigationSkyBlueColor
// //                               : AppColors.textGreyThemeColor),
// //                       // style: Styles.textStyleBlack16,
// //                     ),
// //                     leading: SizedBox(
// //                       width: 18,
// //                       height: 18,
// //                       child: Image.asset(drawerItem.imageName,
// //                           fit: BoxFit.fitHeight,
// //                           color: (i == _opearationsLastSelectedItem)
// //                               ? AppColors.navigationSkyBlueColor
// //                               : AppColors.textGreyThemeColor),
// //                     ),
// //                     childrenPadding: const EdgeInsets.only(left: 20),
// //                     //children padding
// //                     children: buildDrawerChildren(context, drawerItem.title),
// //                   ),
// //                 ),
// //               ),
// //       );
// //     }
// //
// //     return children;
// //   }
// //
// //   _onExpansionSelectItem(int index, BuildContext context, MenuItem item) async {
// //     log('---_onExpansionSelectItem--$index-');
// //     // _menuScaffoldKey.currentState!.closeDrawer();
// //     _opearationsLastSelectedItem = index;
// //     //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
// //     //state = const DrawerInitial();
// //     context.read<DrawerCubit>().getOperationsIndexChange(index);
// //     log('---item.title--${item.title}-');
// //
// //     switch (item.title) {
// //       case Constants.annualPowerShutdownListTitle:
// //         Navigator.pushNamed(context, annualPowerShutdownListRoute);
// //         break;
// //       case Constants.articleFoundRegisterListTitle:
// //         Navigator.pushNamed(context, articleFoundNewListRoute);
// //         break;
// //       case Constants.eventProtectionList:
// //         Navigator.pushNamed(context, eventProtectionListRoute);
// //         break;
// //       // case Constants.annualPowerShutdownListTitle:
// //       //   Navigator.pushNamed(context, annualPowerShutdownListRoute);
// //       //   break;
// //       case Constants.incidentManagementTitle:
// //         Navigator.pushNamed(context, incidentManagementsRoute);
// //         break;
// //       case Constants.lawEnforcementVisitsListTitle:
// //         Navigator.pushNamed(context, lawEnforcementNewListRoute);
// //         break;
// //       case Constants.vVipVisitorsTitle:
// //         Navigator.pushNamed(context, vipVisitorsListRoute);
// //         break;
// //
// //       default:
// //         break;
// //     }
// //     // if (index == 0) {
// //     //   Navigator.pushNamed(context, annualPowerShutdownListRoute);
// //     // } else if (index == 1) {
// //     //   Navigator.pushNamed(context, articleFoundListRoute);
// //     // } else if (index == 2) {
// //     //   Navigator.pushNamed(context, eventProtectionListRoute);
// //     // } else if (index == 3) {
// //     //   log('Index 3 -$index--- ');
// //     //   Navigator.pushNamed(context, annualPowerShutdownListRoute);
// //     // } else if (index == 4) {
// //     //   Navigator.pushNamed(context, incidentManagementsRoute);
// //     // } else if (index == 5) {
// //     // } else if (index == 6) {
// //     //   Navigator.pushNamed(context, lawEnforcementListRoute);
// //     // } else if (index == 10) {
// //     //   Navigator.pushNamed(context, vipVisitorsListRoute);
// //     // }
// //   }
// //
// //   _onPassMgmtSelectItem(int index, BuildContext context) async {
// //     // _menuScaffoldKey.currentState!.closeDrawer();
// //     _passlastSelectedItem = index;
// //     //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
// //     //state = const DrawerInitial();
// //     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
// //     switch (index) {
// //       case 0:
// //         log('day pass management index0');
// //         Navigator.pushNamed(context, dayPassManagementListRoute, arguments: {
// //           "passMngDetails": PassMngArguments(0, 'Day Pass Management', false)
// //         });
// //         break;
// //       case 1:
// //         log('day pass registry index1');
// //         Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
// //           "passMngRegisterDetails":
// //               PassMngArguments(0, 'Day Pass Register', true)
// //         });
// //         break;
// //       case 2:
// //         log('Sez pass Management index6');
// //         Navigator.pushNamed(context, sezPassManagementListRoute, arguments: {
// //           "passMngDetails": PassMngArguments(3, 'Sez Pass Management', false)
// //         });
// //         break;
// //       case 3:
// //         log('Sez pass registry index7');
// //         Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
// //           "passMngRegisterDetails":
// //               PassMngArguments(3, 'Sez Pass Register', true)
// //         });
// //         break;
// //       case 4:
// //         log('vendor pass management index4');
// //         Navigator.pushNamed(context, vendorPassManagementListRoute, arguments: {
// //           "passMngDetails": PassMngArguments(2, 'Vendor Pass Management', false)
// //         });
// //         break;
// //       case 5:
// //         log('vendor pass registry index5');
// //         Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
// //           "passMngRegisterDetails":
// //               PassMngArguments(2, 'Vendor Pass Register', true)
// //         });
// //         break;
// //       case 6:
// //         log('visitor pass management index2');
// //         Navigator.pushNamed(context, visitorPassManagementListRoute, arguments: {
// //           "passMngDetails":
// //               PassMngArguments(1, 'Visitor Pass Management', false)
// //         });
// //         break;
// //       case 7:
// //         log('visitor pass registry index3');
// //         Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
// //           "passMngRegisterDetails":
// //               PassMngArguments(1, 'Visitor Pass Register', true)
// //         });
// //         break;
// //       default:
// //         break;
// //     }
// //     // if (index == 0) {
// //     //   //day pass mng = 0
// //     //   log('day pass mangement index0');
// //     //   Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
// //     //     "passMngDetails": PassMngArguments(0, 'Day Pass Management', false)
// //     //   });
// //     // } else if (index == 1) {
// //     //   log('day pass registry index1');
// //     //   //day pass mng = 0
// //     //   Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
// //     //     "passMngRegisterDetails": PassMngArguments(0, 'Day Pass Register', true)
// //     //   });
// //     // } else if (index == 2) {
// //     //   //vendor pass mng = 3
// //     //
// //     //   log('Sez pass Management index6');
// //     //   Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
// //     //     "passMngDetails": PassMngArguments(3, 'Sez Pass Management', false)
// //     //   });
// //     // } else if (index == 3) {
// //     //   log('Sez pass registory index7');
// //     //   Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
// //     //     "passMngRegisterDetails": PassMngArguments(3, 'Sez Pass Register', true)
// //     //   });
// //     // } else if (index == 4) {
// //     //   log('vendor pass management index4');
// //     //   Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
// //     //     "passMngDetails": PassMngArguments(2, 'Vendor Pass Management', false)
// //     //   });
// //     // } else if (index == 5) {
// //     //   //vendor pass mng = 2
// //     //
// //     //   log('vendor pass registory index5');
// //     //   Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
// //     //     "passMngRegisterDetails":
// //     //         PassMngArguments(2, 'Vendor Pass Register', true)
// //     //   });
// //     // } else if (index == 6) {
// //     //   //visitor pass mng = 1
// //     //
// //     //   log('visitor pass mangement index2');
// //     //   Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
// //     //     "passMngDetails": PassMngArguments(1, 'Visitor Pass Management', false)
// //     //   });
// //     // } else if (index == 7) {
// //     //   //visitor pass mng = 1
// //     //   log('visitor pass registory index3');
// //     //   Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
// //     //     "passMngRegisterDetails":
// //     //         PassMngArguments(1, 'Visitor Pass Register', true)
// //     //   });
// //     // }
// //   }
// //
// //   _onSecurityExpansionSelectItem(int index, BuildContext context) async {
// //     // _menuScaffoldKey.currentState!.closeDrawer();
// //     _securityfunfunctionslastSelectedItem = index;
// //     //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
// //     //state = const DrawerInitial();
// //     context.read<DrawerCubit>().getSecurityIndexChange(index);
// //     if (index == 0) {
// //       Navigator.pushNamed(context, sstIncidentListRoute);
// //     }
// //   }
// //
// //   _onSelectItem(
// //     int index,
// //     BuildContext context,
// //   ) async {
// //     //Navigator.pop(context)
// //     if (index != 5) {
// //       // _menuScaffoldKey.currentState!.closeDrawer();
// //     }
// //     _lastSelectedItem = index;
// //     // var lastindex = await SharedPrefs.setIdentifymenuindex(index);
// //
// //     //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
// //     //state = const DrawerInitial();
// //
// //     context.read<DrawerCubit>().getIndexChange(index);
// //     if (index != 2) {
// //       _opearationsLastSelectedItem = 10;
// //     }
// //     //SetState(){}
// //     if (index == 0) {
// //     } else if (index == 1) {
// //       // _logout(context);
// //     } else if (index == 3) {
// //       Navigator.pushNamed(
// //         context,
// //         resetPwdScreenRoute,
// //         arguments: {'viaNavigationDrawer': true},
// //       );
// //     } else if (index == 4) {}
// //   }
// //
// //   // _logout(BuildContext context) {
// //   //   var dialog = CustomAlertDialog(
// //   //       title: Constants.logout,
// //   //       message: Constants.logoutValidation,
// //   //       onPositivePressed: () {
// //   //         InactivityFunctions().logoutUser(navigatorKey);
// //   //       },
// //   //       positiveBtnText: Constants.yes,
// //   //       negativeBtnText: Constants.no);
// //   //   showDialog(context: context, builder: (BuildContext context) => dialog);
// //   // }
// //
// //   List<Widget> buildDrawerChildren(
// //     BuildContext context,
// //     String title,
// //   ) {
// //     // log('--title---$title--');
// //     switch (title) {
// //       case Constants.materialMovement:
// //         return _genericItemSelection(
// //             context, materialMovementDrawerItemsWithReturnable, title);
// //       // case Constants.securitySystemTickets:
// //       //   return _genericItemExpandable(
// //       //     context,
// //       //     securitySystemTicketsItems,
// //       //     Constants.securitySystemTickets,
// //       //   );
// //       // case Constants.guardingOperations:
// //       //   return _genericItemExpandable(
// //       //     context,
// //       //     guardingOperationDrawerItems,
// //       //     Constants.guardingOperations,
// //       //   );
// //       case Constants.guardingOperations:
// //         List<MenuItem> menuItems = [];
// //         checkMenuPermissionsGuardingOperations(displayMenu, menuItems);
// //
// //         // if (displayMenu?.cD ?? false) {
// //         //   menuItems.add(const MenuItem(
// //         //       Constants.escalationMatrix, AppIcon.escalationMatrixIcon, 0));
// //         // }
// //         //
// //         // if (displayMenu?.gM ?? false) {
// //         //   menuItems.add(const MenuItem(
// //         //       Constants.guardingMasterData, AppIcon.guardingMasterDataIcon, 0));
// //         // }
// //         //
// //         // if (displayMenu?.gMR ?? false) {
// //         //   menuItems.add(const MenuItem(Constants.guardingMasterReport,
// //         //       AppIcon.guardingMasterReportIcon, 0));
// //         // }
// //         //
// //         // if (displayMenu?.oCC ?? false) {
// //         //   menuItems.add(const MenuItem(
// //         //       Constants.shiftOccurrence, AppIcon.shiftOccurrenceIcon, 0));
// //         // }
// //         // if (displayMenu?.sVP ?? false) {
// //         //   menuItems.add(const MenuItem(Constants.slaViolationPenaltyTitle,
// //         //       AppIcon.slaViolationPenaltyIcon, 0));
// //         // }
// //         return _genericItemExpandable(
// //           context,
// //           menuItems,
// //           Constants.guardingOperations,
// //         );
// //
// //       // case Constants.securityFunctions:
// //       //   return _genericItemSelection(
// //       //     context,
// //       //     securitySystemTicketsItems,
// //       //     title,
// //       //   );
// //
// //       // case keyManagementDataTitle:
// //       //   return _genericItemSelection(
// //       //     context,
// //       //     keyManagementDataItems,
// //       //     title,
// //       //   );
// //       case Constants.keyManagementData:
// //         List<MenuItem> menuItems = [];
// //
// //         MenuPermissions()
// //             .checkMenuPermissionsKeyManagementData(displayMenu, menuItems);
// //         return _genericItemExpandable(
// //           context,
// //           menuItems,
// //           Constants.keyManagementData,
// //         );
// //
// //       // case shiftSchedulingTitle:
// //       //   return _genericItemSelection(
// //       //     context,
// //       //     shiftSchedulingDataItems,
// //       //     title,
// //       //   );
// //
// //       case shiftSchedulingTitle:
// //         List<MenuItem> menuItems = [];
// //
// //         MenuPermissions()
// //             .checkMenuPermissionsShiftSchedule(displayMenu, menuItems);
// //         return _genericItemExpandable(
// //           context,
// //           menuItems,
// //           Constants.shiftSchedule,
// //         );
// //
// //       case Constants.passManagement:
// //         return _genericItemSelection(
// //           context,
// //           passTileDrawerItems,
// //           title,
// //         );
// //       case Constants.sCRI:
// //         return _genericItemSelection(
// //           context,
// //           sCRIItems,
// //           title,
// //         );
// //       default:
// //         log('-buildDrawerChildren-----else-----title--$title--');
// //         return _genericItemSelection(
// //             context, guardingOperationDrawerItems, title);
// //     }
// //   }
// //
// //   void checkMenuPermissionsGuardingOperations(
// //     DisplayMenu? displayMenu,
// //     List<MenuItem> menuItems,
// //   ) {
// //     if (displayMenu?.cD ?? false) {
// //       menuItems.add(const MenuItem(
// //           Constants.escalationMatrix, AppIcon.escalationMatrixIcon, 0));
// //     }
// //
// //     if (displayMenu?.gM ?? false) {
// //       menuItems.add(const MenuItem(
// //           Constants.guardingMasterData, AppIcon.guardingMasterDataIcon, 0));
// //     }
// //
// //     if (displayMenu?.gMR ?? false) {
// //       menuItems.add(const MenuItem(
// //           Constants.guardingMasterReport, AppIcon.guardingMasterReportIcon, 0));
// //     }
// //
// //     if (displayMenu?.oCC ?? false) {
// //       menuItems.add(const MenuItem(
// //           Constants.shiftOccurrence, AppIcon.shiftOccurrenceIcon, 0));
// //     }
// //     if (displayMenu?.sVP ?? false) {
// //       menuItems.add(const MenuItem(Constants.slaViolationPenaltyTitle,
// //           AppIcon.slaViolationPenaltyIcon, 0));
// //     }
// //   }
// // }
// //
// //
// // // import 'dart:developer';
// // // import 'dart:ui';
// // // import 'package:db_atom/index.dart';
// // // import 'package:db_atom/src/features/dashboard/navigation_drawer/views/menu_permissions.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_bloc/flutter_bloc.dart';
// // // import 'package:flutter_svg/flutter_svg.dart';
// // //
// // // class NavigationDrawer1 extends StatelessWidget {
// // //   NavigationDrawer1(
// // //       this._menuScaffoldKey,
// // //       this.username,
// // //       this.email, {
// // //         super.key,
// // //       }) {
// // //     initializeDrawerItems();
// // //   }
// // //
// // //   late List<MenuItem> expansionTileDrawerItems = [];
// // //   late List<MenuItem> costAndBillingExpansionTileDrawerItems = [];
// // //   late List<MenuItem> securitySystemTicketsItems = [];
// // //
// // //   Future<void> initializeDrawerItems() async {
// // //     expansionTileDrawerItems = await checkDisplayMenu();
// // //     costAndBillingExpansionTileDrawerItems = await costBillingDisplayMenu();
// // //     securitySystemTicketsItems = await securitySystemsDisplayMenu();
// // //   }
// // //
// // //   DisplayMenu? displayMenu;
// // //   final String? username;
// // //   final String? email;
// // //   final GlobalKey<ScaffoldState> _menuScaffoldKey;
// // //
// // //   late int _lastSelectedItem = 0;
// // //   late int _opearationsLastSelectedItem = 10;
// // //   late int _passlastSelectedItem = 10;
// // //   late int _securityfunfunctionslastSelectedItem = 10;
// // //   late int _ticketingSystemlastSelectedItem = 1;
// // //
// // //   Future<List<MenuItem>> checkDisplayMenu() async {
// // //     displayMenu = await SharedPrefs.getDisplayMenu();
// // //     bool guardingOperations = ((displayMenu?.gM ?? false) ||
// // //         (displayMenu?.cD ?? false) ||
// // //         (displayMenu?.gR ?? false) ||
// // //         (displayMenu?.oCC ?? false) ||
// // //         (displayMenu?.sVP ?? false) ||
// // //         (displayMenu?.gMR ?? false));
// // //
// // //     if (displayMenu == null) return [];
// // //     List<MenuItem> expansionTileDrawerItems = [];
// // //
// // //     if (displayMenu?.aF ?? false) {
// // //       expansionTileDrawerItems.add(const MenuItem(
// // //           Constants.articleFoundRegisterListTitle,
// // //           AppIcon.articleFoundRegisterIcon,
// // //           0));
// // //     }
// // //
// // //     if (guardingOperations) {
// // //       expansionTileDrawerItems.add(const MenuItem(
// // //           Constants.guardingOperations, AppIcon.guardingOperationIcon, 1));
// // //     }
// // //
// // //     if (displayMenu?.lEO ?? false) {
// // //       expansionTileDrawerItems.add(const MenuItem(
// // //           Constants.lawEnforcementVisitsListTitle,
// // //           AppIcon.lawEnforcementIcon,
// // //           0));
// // //     }
// // //
// // //     if (displayMenu?.pM ?? false) {
// // //       expansionTileDrawerItems.add(const MenuItem(
// // //           Constants.passManagement, AppIcon.passManagementIcon, 1));
// // //     }
// // //
// // //     if (displayMenu?.sS ?? false) {
// // //       expansionTileDrawerItems.add(const MenuItem(
// // //           shiftSchedulingTitle, AppIcon.eventProtectionIcon, 1));
// // //     }
// // //
// // //     return expansionTileDrawerItems;
// // //   }
// // //
// // //   Future<List<MenuItem>> costBillingDisplayMenu() async {
// // //     displayMenu = await SharedPrefs.getDisplayMenu();
// // //     if (displayMenu == null) return [];
// // //     List<MenuItem> costAndBillingExpansionTileDrawerItems = [];
// // //     if (displayMenu?.gR ?? false) {
// // //       costAndBillingExpansionTileDrawerItems.add(const MenuItem(
// // //           Constants.guardingRates, AppIcon.guardingRatesIcon, 0));
// // //     }
// // //     return costAndBillingExpansionTileDrawerItems;
// // //   }
// // //
// // //   Future<List<MenuItem>> securitySystemsDisplayMenu() async {
// // //     displayMenu = await SharedPrefs.getDisplayMenu();
// // //     if (displayMenu == null) return [];
// // //     List<MenuItem> securitySystemTicketsItems = [];
// // //     if (displayMenu?.gR ?? false) {
// // //       securitySystemTicketsItems
// // //           .add(const MenuItem(Constants.incident, AppIcon.incidentIcon, 0));
// // //     }
// // //     return securitySystemTicketsItems;
// // //   }
// // //
// // //   static const String shiftSchedulingTitle = Constants.shiftScheduling;
// //
// //   // @override
// //   // Widget build(BuildContext context) {
// //   //   return Theme(
// //   //     data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
// //   //     child: Drawer(
// //   //       child: Row(
// //   //         children: [
// //   //           // -------------------- LEFT SIDEBAR --------------------
// //   //           Container(
// //   //             width: 70,
// //   //             decoration: const BoxDecoration(
// //   //               gradient: LinearGradient(
// //   //                 colors: [Color(0xFF0000CC), Color(0xFFA08256)],
// //   //                 begin: Alignment.topCenter,
// //   //                 end: Alignment.bottomCenter,
// //   //               ),
// //   //             ),
// //   //             child: Column(
// //   //               mainAxisAlignment: MainAxisAlignment.center,
// //   //               children: [
// //   //                 _sidebarIcon(AppIcon.searchIcon),
// //   //                 const SizedBox(height: 20),
// //   //                 _sidebarIcon(AppIcon.searchIcon),
// //   //                 const SizedBox(height: 20),
// //   //                 _sidebarIcon(AppIcon.searchIcon),
// //   //                 const SizedBox(height: 20),
// //   //                 _sidebarIcon(AppIcon.searchIcon),
// //   //               ],
// //   //             ),
// //   //           ),
// //   //
// //   //           // -------------------- MAIN CONTENT --------------------
// //   //           Expanded(
// //   //             child: BlocProvider(
// //   //               create: (context) => DrawerCubit(),
// //   //               child: BlocBuilder<DrawerCubit, DrawerState>(
// //   //                 builder: (context, state) {
// //   //                   switch (state.runtimeType) {
// //   //                     case DrawerInitial:
// //   //                       _lastSelectedItem = (state as DrawerInitial).index;
// //   //                       break;
// //   //                     case GetDrawerItemChange:
// //   //                       _lastSelectedItem =
// //   //                           (state as GetDrawerItemChange).index;
// //   //                       break;
// //   //                     case OperationsGetDrawerItemChange:
// //   //                       _opearationsLastSelectedItem =
// //   //                           (state as OperationsGetDrawerItemChange).index;
// //   //                       break;
// //   //                     case PassMgmtGetDrawerItemChange:
// //   //                       _passlastSelectedItem =
// //   //                           (state as PassMgmtGetDrawerItemChange).index;
// //   //                       break;
// //   //                     default:
// //   //                       break;
// //   //                   }
// //   //
// //   //                   return Column(
// //   //                     crossAxisAlignment: CrossAxisAlignment.start,
// //   //                     children: [
// //   //                       // ------------- PROFILE HEADER -------------
// //   //                       Container(
// //   //                         width: double.infinity,
// //   //                         padding: const EdgeInsets.all(10),
// //   //                         decoration: const BoxDecoration(
// //   //                           gradient: LinearGradient(
// //   //                             colors: [Color(0xFF0000CC), Color(0xFFA08256)],
// //   //                             begin: Alignment.topLeft,
// //   //                             end: Alignment.bottomRight,
// //   //                           ),
// //   //                           borderRadius: BorderRadius.only(
// //   //                             bottomLeft: Radius.circular(10),
// //   //                           ),
// //   //                         ),
// //   //                         child: Row(
// //   //                           children: [
// //   //                             const CircleAvatar(
// //   //                               radius: 24,
// //   //                               backgroundImage:
// //   //                               AssetImage('assets/images/profile.png'),
// //   //                             ),
// //   //                             const SizedBox(width: 10),
// //   //                             Expanded(
// //   //                               child: Column(
// //   //                                 crossAxisAlignment: CrossAxisAlignment.start,
// //   //                                 children: [
// //   //                                   Text(username ?? '',
// //   //                                       style: const TextStyle(
// //   //                                           fontWeight: FontWeight.bold,
// //   //                                           color: Colors.white)),
// //   //                                   Text(email ?? '',
// //   //                                       style: const TextStyle(
// //   //                                           color: Colors.white70,
// //   //                                           fontSize: 12)),
// //   //                                 ],
// //   //                               ),
// //   //                             ),
// //   //                             GestureDetector(
// //   //                               onTap: () {
// //   //                                 _menuScaffoldKey.currentState?.closeDrawer();
// //   //                               },
// //   //                               child: const Icon(Icons.close,
// //   //                                   color: Colors.white),
// //   //                             )
// //   //                           ],
// //   //                         ),
// //   //                       ),
// //   //
// //   //                       // ------------- BODY -------------
// //   //                       Expanded(
// //   //                         child: Container(
// //   //                           decoration: const BoxDecoration(
// //   //                             color: Colors.blue,
// //   //                             boxShadow: [
// //   //                               BoxShadow(
// //   //                                 color: Colors.black12,
// //   //                                 blurRadius: 3,
// //   //                               )
// //   //                             ],
// //   //                           ),
// //   //                           child: ListView(
// //   //                             padding:
// //   //                             const EdgeInsets.only(left: 10, right: 10),
// //   //                             children: [
// //   //                               const SizedBox(height: 20),
// //   //                               const Text(
// //   //                                 "Security Functions",
// //   //                                 style: TextStyle(
// //   //                                   fontSize: 18,
// //   //                                   fontWeight: FontWeight.w700,
// //   //                                   color: Colors.black87,
// //   //                                 ),
// //   //                               ),
// //   //                               const SizedBox(height: 10),
// //   //                               _buildOperationsMenu(context),
// //   //                             ],
// //   //                           ),
// //   //                         ),
// //   //                       ),
// //   //                     ],
// //   //                   );
// //   //                 },
// //   //               ),
// //   //             ),
// //   //           ),
// //   //         ],
// //   //       ),
// //   //     ),
// //   //   );
// //   // }
// //   // @override
// //   // Widget build(BuildContext context) {
// //   //   return Theme(
// //   //     data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
// //   //     child: Drawer(
// //   //       child: Row(
// //   //         children: [
// //   //           // -------------------- LEFT SIDEBAR --------------------
// //   //           Container(
// //   //             width: 70,
// //   //             decoration: BoxDecoration(
// //   //               borderRadius: const BorderRadius.only(
// //   //                 topRight: Radius.circular(20),
// //   //                 bottomRight: Radius.circular(20),
// //   //               ),
// //   //               color: Color(0xFF000080).withValues(alpha: 0.2),
// //   //               boxShadow: [
// //   //                 BoxShadow(
// //   //                   color: Color(0xFF000080).withValues(alpha: 0.8),
// //   //                   blurRadius: 10,
// //   //                   offset: const Offset(0, 4),
// //   //                 ),
// //   //               ],
// //   //             ),
// //   //             child: ClipRRect(
// //   //               borderRadius: const BorderRadius.only(
// //   //                 topRight: Radius.circular(20),
// //   //                 bottomRight: Radius.circular(20),
// //   //               ),
// //   //               child: BackdropFilter(
// //   //                 filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
// //   //                 child: Column(
// //   //                   mainAxisAlignment: MainAxisAlignment.center,
// //   //                   children: [
// //   //                     _sidebarIcon(AppIcon.searchIcon),
// //   //                     const SizedBox(height: 20),
// //   //                     _sidebarIcon(AppIcon.searchIcon),
// //   //                     const SizedBox(height: 20),
// //   //                     _sidebarIcon(AppIcon.searchIcon),
// //   //                     const SizedBox(height: 20),
// //   //                     _sidebarIcon(AppIcon.searchIcon),
// //   //                   ],
// //   //                 ),
// //   //               ),
// //   //             ),
// //   //           ),
// //   //
// //   //           // -------------------- MAIN CONTENT --------------------
// //   //           Expanded(
// //   //             child: BlocProvider(
// //   //               create: (context) => DrawerCubit(),
// //   //               child: BlocBuilder<DrawerCubit, DrawerState>(
// //   //                 builder: (context, state) {
// //   //                   switch (state.runtimeType) {
// //   //                     case DrawerInitial:
// //   //                       _lastSelectedItem = (state as DrawerInitial).index;
// //   //                       break;
// //   //                     case GetDrawerItemChange:
// //   //                       _lastSelectedItem =
// //   //                           (state as GetDrawerItemChange).index;
// //   //                       break;
// //   //                     case OperationsGetDrawerItemChange:
// //   //                       _opearationsLastSelectedItem =
// //   //                           (state as OperationsGetDrawerItemChange).index;
// //   //                       break;
// //   //                     case PassMgmtGetDrawerItemChange:
// //   //                       _passlastSelectedItem =
// //   //                           (state as PassMgmtGetDrawerItemChange).index;
// //   //                       break;
// //   //                     default:
// //   //                       break;
// //   //                   }
// //   //
// //   //                   return ClipRRect(
// //   //                     borderRadius: const BorderRadius.only(
// //   //                       topLeft: Radius.circular(25),
// //   //                       bottomLeft: Radius.circular(25),
// //   //                     ),
// //   //                     child: BackdropFilter(
// //   //                       filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
// //   //                       child: Container(
// //   //                         decoration: BoxDecoration(
// //   //                           color:Color(0xFF000080).withValues(alpha: 0.4),
// //   //                           borderRadius: const BorderRadius.only(
// //   //                             topLeft: Radius.circular(25),
// //   //                             bottomLeft: Radius.circular(25),
// //   //                           ),
// //   //                           border: Border.all(
// //   //                             color: Color(0xFF000080).withValues(alpha: 0.8),
// //   //                             width: 1,
// //   //                           ),
// //   //                           boxShadow: [
// //   //                             BoxShadow(
// //   //                               color: Color(0xFF000080).withValues(alpha: 0.4),
// //   //                               blurRadius: 8,
// //   //                               offset: const Offset(0, 4),
// //   //                             ),
// //   //                           ],
// //   //                         ),
// //   //                         child: Column(
// //   //                           crossAxisAlignment: CrossAxisAlignment.start,
// //   //                           children: [
// //   //                             // ------------- PROFILE HEADER -------------
// //   //                             Container(
// //   //                               width: double.infinity,
// //   //                               padding: const EdgeInsets.all(10),
// //   //                               decoration: BoxDecoration(
// //   //                                 gradient: LinearGradient(
// //   //                                   colors: [
// //   //                                     Colors.white.withOpacity(0.3),
// //   //                                     Colors.white.withOpacity(0.1),
// //   //                                   ],
// //   //                                   begin: Alignment.topLeft,
// //   //                                   end: Alignment.bottomRight,
// //   //                                 ),
// //   //                                 borderRadius: const BorderRadius.only(
// //   //                                   bottomLeft: Radius.circular(10),
// //   //                                 ),
// //   //                                 border: Border.all(
// //   //                                   color: Colors.white.withOpacity(0.2),
// //   //                                 ),
// //   //                               ),
// //   //                               child: Row(
// //   //                                 children: [
// //   //                                   const CircleAvatar(
// //   //                                     radius: 24,
// //   //                                     backgroundImage: AssetImage(
// //   //                                       'assets/images/profile.png',
// //   //                                     ),
// //   //                                   ),
// //   //                                   const SizedBox(width: 10),
// //   //                                   Expanded(
// //   //                                     child: Column(
// //   //                                       crossAxisAlignment:
// //   //                                       CrossAxisAlignment.start,
// //   //                                       children: [
// //   //                                         Text(
// //   //                                           username ?? '',
// //   //                                           style: const TextStyle(
// //   //                                             fontWeight: FontWeight.bold,
// //   //                                             color: Colors.white,
// //   //                                           ),
// //   //                                         ),
// //   //                                         Text(
// //   //                                           email ?? '',
// //   //                                           style: const TextStyle(
// //   //                                             color: Colors.white70,
// //   //                                             fontSize: 12,
// //   //                                           ),
// //   //                                         ),
// //   //                                       ],
// //   //                                     ),
// //   //                                   ),
// //   //                                   GestureDetector(
// //   //                                     onTap: () {
// //   //                                       _menuScaffoldKey.currentState
// //   //                                           ?.closeDrawer();
// //   //                                     },
// //   //                                     child: const Icon(
// //   //                                       Icons.close,
// //   //                                       color: Colors.white,
// //   //                                     ),
// //   //                                   ),
// //   //                                 ],
// //   //                               ),
// //   //                             ),
// //   //
// //   //                             // ------------- BODY -------------
// //   //                             Expanded(
// //   //                               child: Container(
// //   //                                 margin: const EdgeInsets.all(8),
// //   //                                 decoration: BoxDecoration(
// //   //                                   color: Colors.white.withOpacity(0.05),
// //   //                                   borderRadius: BorderRadius.circular(20),
// //   //                                   border: Border.all(
// //   //                                     color: Colors.white.withOpacity(0.15),
// //   //                                   ),
// //   //                                   boxShadow: [
// //   //                                     BoxShadow(
// //   //                                       color: Colors.black.withOpacity(0.2),
// //   //                                       blurRadius: 10,
// //   //                                       offset: const Offset(0, 4),
// //   //                                     ),
// //   //                                   ],
// //   //                                 ),
// //   //                                 child: ListView(
// //   //                                   padding: const EdgeInsets.only(
// //   //                                     left: 10,
// //   //                                     right: 10,
// //   //                                   ),
// //   //                                   children: [
// //   //                                     const SizedBox(height: 20),
// //   //                                     const Text(
// //   //                                       "Security Functions",
// //   //                                       style: TextStyle(
// //   //                                         fontSize: 18,
// //   //                                         fontWeight: FontWeight.w700,
// //   //                                         color: Colors.white,
// //   //                                       ),
// //   //                                     ),
// //   //                                     const SizedBox(height: 10),
// //   //                                     _buildOperationsMenu(context),
// //   //                                   ],
// //   //                                 ),
// //   //                               ),
// //   //                             ),
// //   //                           ],
// //   //                         ),
// //   //                       ),
// //   //                     ),
// //   //                   );
// //   //                 },
// //   //               ),
// //   //             ),
// //   //           ),
// //   //         ],
// //   //       ),
// //   //     ),
// //   //   );
// //   // }
// // //   Widget build(BuildContext context) {
// // //     final double drawerWidth = MediaQuery.of(context).size.width * 0.85;
// // //
// // //     return Theme(
// // //       data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
// // //       child: Drawer(
// // //         width: drawerWidth,
// // //         backgroundColor: Colors.transparent,
// // //         elevation: 0,
// // //         child: Row(
// // //           children: [
// // //             // -------------------- LEFT SIDEBAR --------------------
// // //             Container(
// // //               width: 70,
// // //               decoration: BoxDecoration(
// // //                 gradient: LinearGradient(
// // //                   colors: [
// // //                     const Color(0xFF001F5B).withOpacity(0.8),
// // //                     const Color(0xFFA08256).withOpacity(0.6),
// // //                   ],
// // //                   begin: Alignment.topCenter,
// // //                   end: Alignment.bottomCenter,
// // //                 ),
// // //                 borderRadius: const BorderRadius.only(
// // //                   topRight: Radius.circular(30),
// // //                   bottomRight: Radius.circular(30),
// // //                 ),
// // //                 boxShadow: [
// // //                   BoxShadow(
// // //                     color: Colors.black.withOpacity(0.3),
// // //                     blurRadius: 10,
// // //                     offset: const Offset(2, 4),
// // //                   ),
// // //                 ],
// // //               ),
// // //               child: Column(
// // //                 mainAxisAlignment: MainAxisAlignment.center,
// // //                 children: [
// // //                   _sidebarIcon(AppIcon.searchIcon),
// // //                   const SizedBox(height: 25),
// // //                   _sidebarIcon(AppIcon.searchIcon),
// // //                   const SizedBox(height: 25),
// // //                   _sidebarIcon(AppIcon.searchIcon),
// // //                   const SizedBox(height: 25),
// // //                   _sidebarIcon(AppIcon.searchIcon),
// // //                 ],
// // //               ),
// // //             ),
// // //
// // //             // -------------------- MAIN CONTENT --------------------
// // //             Expanded(
// // //               child: BlocProvider(
// // //                 create: (context) => DrawerCubit(),
// // //                 child: BlocBuilder<DrawerCubit, DrawerState>(
// // //                   builder: (context, state) {
// // //                     switch (state.runtimeType) {
// // //                       case DrawerInitial:
// // //                         _lastSelectedItem = (state as DrawerInitial).index;
// // //                         break;
// // //                       case GetDrawerItemChange:
// // //                         _lastSelectedItem = (state as GetDrawerItemChange).index;
// // //                         break;
// // //                       case OperationsGetDrawerItemChange:
// // //                         _opearationsLastSelectedItem =
// // //                             (state as OperationsGetDrawerItemChange).index;
// // //                         break;
// // //                       case PassMgmtGetDrawerItemChange:
// // //                         _passlastSelectedItem =
// // //                             (state as PassMgmtGetDrawerItemChange).index;
// // //                         break;
// // //                       default:
// // //                         break;
// // //                     }
// // //
// // //                     return ClipRRect(
// // //                       borderRadius: const BorderRadius.only(
// // //                         topLeft: Radius.circular(30),
// // //                         bottomLeft: Radius.circular(30),
// // //                       ),
// // //                       child: BackdropFilter(
// // //                         filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
// // //                         child: Container(
// // //                           decoration: BoxDecoration(
// // //                             color: Colors.white.withOpacity(0.1),
// // //                             borderRadius: const BorderRadius.only(
// // //                               topLeft: Radius.circular(30),
// // //                               bottomLeft: Radius.circular(30),
// // //                             ),
// // //                             border: Border.all(
// // //                               color: Colors.white.withOpacity(0.15),
// // //                             ),
// // //                           ),
// // //                           child: Column(
// // //                             crossAxisAlignment: CrossAxisAlignment.start,
// // //                             children: [
// // //                               // ------------- PROFILE HEADER (FULL WIDTH) -------------
// // //                               Container(
// // //                                 width: double.infinity,
// // //                                 padding: const EdgeInsets.all(16),
// // //                                 decoration: BoxDecoration(
// // //                                   gradient: LinearGradient(
// // //                                     colors: [
// // //                                       Colors.white.withOpacity(0.25),
// // //                                       Colors.white.withOpacity(0.05),
// // //                                     ],
// // //                                     begin: Alignment.topLeft,
// // //                                     end: Alignment.bottomRight,
// // //                                   ),
// // //                                   border: Border(
// // //                                     bottom: BorderSide(
// // //                                       color: Colors.white.withOpacity(0.2),
// // //                                     ),
// // //                                   ),
// // //                                 ),
// // //                                 child: Row(
// // //                                   children: [
// // //                                     const CircleAvatar(
// // //                                       radius: 26,
// // //                                       backgroundImage: AssetImage(
// // //                                           'assets/images/profile.png'),
// // //                                     ),
// // //                                     const SizedBox(width: 12),
// // //                                     Expanded(
// // //                                       child: Column(
// // //                                         crossAxisAlignment:
// // //                                         CrossAxisAlignment.start,
// // //                                         children: [
// // //                                           Text(
// // //                                            username ?? '',
// // //                                             style: const TextStyle(
// // //                                               fontWeight: FontWeight.bold,
// // //                                               color: Colors.white,
// // //                                               fontSize: 16,
// // //                                             ),
// // //                                           ),
// // //                                           Text(
// // //                                            email ?? '',
// // //                                             style: const TextStyle(
// // //                                               color: Colors.white70,
// // //                                               fontSize: 12,
// // //                                             ),
// // //                                           ),
// // //                                         ],
// // //                                       ),
// // //                                     ),
// // //                                     GestureDetector(
// // //                                       onTap: () {
// // //                                         _menuScaffoldKey.currentState
// // //                                             ?.closeDrawer();
// // //                                       },
// // //                                       child: Container(
// // //                                         decoration: BoxDecoration(
// // //                                           color:
// // //                                           Colors.white.withOpacity(0.2),
// // //                                           shape: BoxShape.circle,
// // //                                         ),
// // //                                         padding: const EdgeInsets.all(4),
// // //                                         child: const Icon(
// // //                                           Icons.close,
// // //                                           color: Colors.white,
// // //                                           size: 20,
// // //                                         ),
// // //                                       ),
// // //                                     ),
// // //                                   ],
// // //                                 ),
// // //                               ),
// // //
// // //                               // ------------- BODY -------------
// // //                               Expanded(
// // //                                 child: Container(
// // //                                   margin: const EdgeInsets.all(16),
// // //                                   padding: const EdgeInsets.all(12),
// // //                                   decoration: BoxDecoration(
// // //                                     color: Colors.white.withOpacity(0.05),
// // //                                     borderRadius: BorderRadius.circular(20),
// // //                                     border: Border.all(
// // //                                       color: Colors.white.withOpacity(0.15),
// // //                                     ),
// // //                                     boxShadow: [
// // //                                       BoxShadow(
// // //                                         color: Colors.black.withOpacity(0.2),
// // //                                         blurRadius: 12,
// // //                                         offset: const Offset(0, 4),
// // //                                       ),
// // //                                     ],
// // //                                   ),
// // //                                   child: ListView(
// // //                                     children: [
// // //                                       const Text(
// // //                                         "Security Functions",
// // //                                         style: TextStyle(
// // //                                           fontSize: 18,
// // //                                           fontWeight: FontWeight.w700,
// // //                                           color: Colors.white,
// // //                                         ),
// // //                                       ),
// // //                                       const SizedBox(height: 10),
// // //                                       _buildOperationsMenu(context),
// // //                                       const SizedBox(height: 25),
// // //                                       const Text(
// // //                                         "Settings",
// // //                                         style: TextStyle(
// // //                                           fontSize: 18,
// // //                                           fontWeight: FontWeight.w700,
// // //                                           color: Colors.white,
// // //                                         ),
// // //                                       ),
// // //                                       const SizedBox(height: 10),
// // //                                       ListTile(
// // //                                         leading: const Icon(
// // //                                           Icons.settings,
// // //                                           color: Colors.white70,
// // //                                         ),
// // //                                         title: const Text(
// // //                                           "System Settings",
// // //                                           style: TextStyle(color: Colors.white),
// // //                                         ),
// // //                                         onTap: () {},
// // //                                       ),
// // //                                     ],
// // //                                   ),
// // //                                 ),
// // //                               ),
// // //                             ],
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     );
// // //                   },
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //
// // //
// // //   Widget _sidebarIcon(String assetName) {
// // //     return Container(
// // //       padding: const EdgeInsets.all(10),
// // //       decoration: const BoxDecoration(
// // //         shape: BoxShape.circle,
// // //         color: Colors.white24,
// // //       ),
// // //       child: SvgPicture.asset(
// // //         assetName,
// // //         height: 22,
// // //         color: Colors.white,
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildOperationsMenu(BuildContext context) {
// // //     return ExpansionTile(
// // //       leading: const Icon(Icons.camera_alt_outlined, color: Colors.black54),
// // //       title: const Text(
// // //         "Operations",
// // //         style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
// // //       ),
// // //       children: [
// // //         _menuText("Article Found"),
// // //         _menuText("Law Enforcement"),
// // //         ExpansionTile(
// // //           leading: const Icon(Icons.folder_open, color: Colors.black54),
// // //           title: const Text(
// // //             "Pass Management",
// // //             style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
// // //           ),
// // //           children: [
// // //             _subMenuText("Day Pass Management", selected: true),
// // //             _subMenuText("Visitor Pass Management"),
// // //             _subMenuText("Vendor Pass Management"),
// // //             _subMenuText("Sez Pass Management"),
// // //           ],
// // //         ),
// // //         _menuText("Shift Schedule"),
// // //       ],
// // //     );
// // //   }
// // //
// // //   Widget _menuText(String title) {
// // //     return ListTile(
// // //       dense: true,
// // //       title: Text(
// // //         title,
// // //         style: const TextStyle(
// // //           color: Colors.black87,
// // //           fontWeight: FontWeight.w500,
// // //           fontSize: 15,
// // //         ),
// // //       ),
// // //       contentPadding: const EdgeInsets.only(left: 40),
// // //     );
// // //   }
// // //
// // //   Widget _subMenuText(String title, {bool selected = false}) {
// // //     return Padding(
// // //       padding: const EdgeInsets.only(left: 70),
// // //       child: Row(
// // //         children: [
// // //           const Icon(Icons.insert_drive_file_outlined,
// // //               size: 16, color: Colors.black45),
// // //           const SizedBox(width: 5),
// // //           Text(
// // //             title,
// // //             style: TextStyle(
// // //               color: selected ? const Color(0xFFB87333) : Colors.black87,
// // //               fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// //
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
//     costAndBillingExpansionTileDrawerItems = await costBillingDisplayMenu();
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
//           Constants.eventProtectionList, AppIcon.eventProtectionIcon, 0));
//     }
//
//     log('gm -- ${displayMenu?.gM}');
//     if (guardingOperations) {
//       expansionTileDrawerItems.add(const MenuItem(
//           Constants.guardingOperations, AppIcon.guardingOperationIcon, 1));
//     }
//
//     if (displayMenu?.iM ?? false) {
//       expansionTileDrawerItems.add(const MenuItem(
//           Constants.incidentManagementTitle,
//           AppIcon.incidentManagementIcon,
//           0));
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
//     return expansionTileDrawerItems;
//   }
//
//   Future<List<MenuItem>> costBillingDisplayMenu() async {
//     displayMenu = await SharedPrefs.getDisplayMenu();
//     if (displayMenu == null) {
//       return [];
//     }
//     List<MenuItem> costAndBillingExpansionTileDrawerItems = [];
//     if (displayMenu?.gR ?? false) {
//       costAndBillingExpansionTileDrawerItems.add(const MenuItem(
//           Constants.guardingRates, AppIcon.guardingRatesIcon, 0));
//     }
//     return costAndBillingExpansionTileDrawerItems;
//   }
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
//
//   Future<void> getIndeifydrawerIndex() async {
//     _lastSelectedItem = await SharedPrefs.getIdentifymenuindex();
//   }
//
//   // TODO: Need to define all the Titles here
//   static const String operationsTitle = Constants.operations;
//   static const String costAndBillingTitle = Constants.costAndBilling;
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
//             Container(
//               decoration:  BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.newColor,
//                     AppColors.newColor,
//                     // Color(0xFF0F172A), // deep navy
//                     // Color(0xFF071130),
//                   //   Color(0xFF111827),
//                   //   Color(0xFF111827)
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
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
//                       case DrawerInitial:
//                         _lastSelectedItem = (state as DrawerInitial).index;
//                         break;
//                       case GetDrawerItemChange:
//                         _lastSelectedItem =
//                             (state as GetDrawerItemChange).index;
//                         break;
//                       case OperationsGetDrawerItemChange:
//                         log('drawer operation ');
//                         _opearationsLastSelectedItem =
//                             (state as OperationsGetDrawerItemChange).index;
//                         break;
//                       case SecurityFunctionsGetDrawerItemChange:
//                         _securityfunfunctionslastSelectedItem =
//                             (state as SecurityFunctionsGetDrawerItemChange)
//                                 .index;
//                         break;
//                       case PassMgmtGetDrawerItemChange:
//                         _passlastSelectedItem =
//                             (state as PassMgmtGetDrawerItemChange).index;
//                         break;
//                       case TicketingSystemGetDrawerItemChange:
//                         _ticketingSystemlastSelectedItem =
//                             (state as TicketingSystemGetDrawerItemChange)
//                                 .index;
//                         break;
//                       default:
//                         break;
//                     }
//
//                     return ListView(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 12.0, horizontal: 12.0),
//                       children: <Widget>[
//                         // Close icon top-right
//                         Padding(
//                           padding: const EdgeInsets.only(right: 6.0),
//                           child: Align(
//                             alignment: Alignment.centerRight,
//                             child: GestureDetector(
//                                 onTap: () async {
//                                   if (_menuScaffoldKey
//                                       .currentState!.isDrawerOpen) {
//                                     _menuScaffoldKey.currentState!.closeDrawer();
//                                   } else {
//                                     _menuScaffoldKey.currentState!.openDrawer();
//                                   }
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.all(6),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white.withValues(alpha: 0.04),
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(
//                                         color: Colors.white.withValues(alpha: 0.6)),
//                                   ),
//                                   child:
//                                   SvgPicture.asset(AppIcon.closeicon,color: Colors.white),
//                                 )),
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
//                             color: Colors.blue[200]?.withValues(alpha: 0.6),
//                             borderRadius: BorderRadius.circular(16),
//                             border: Border.all(
//                                 color: Colors.blueAccent.withValues(alpha: 0.1)),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.blueAccent.withValues(alpha: 0.4),
//                                 blurRadius: 15,
//                                 offset: const Offset(0, 6),
//                               ),
//                             ],
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
//                                       AppColors.white
//                                           .withValues(alpha: 0.9),
//                                       AppColors.navigationSkyBlueColor
//                                           .withValues(alpha: 0.6),
//                                     ],
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: AppColors.navigationSkyBlueColor
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
//                                         color: Colors.black,
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
//                                       style: TextStyle(
//                                         color: AppColors.black
//                                             .withValues(alpha: 0.95),
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w900,
//                                         fontFamily:
//                                         Constants.customFontSemiBoldFamily,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       email ?? '',
//                                       style: TextStyle(
//                                         color: AppColors.black
//                                             .withValues(alpha: 0.6),
//                                         fontSize: 15,
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
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 6, horizontal: 6),
//                           decoration: BoxDecoration(
//                             color:   AppColors.newColor3.withValues(alpha: 0.2),
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           child: Column(
//                             children: _buildDrawerChildren(context, state),
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
//   // -------------------- UI helper: glass tile wrapper --------------------
//   // Widget _glassyTile({
//   //   required Widget child,
//   //   bool isSelected = false,
//   //   EdgeInsets margin = const EdgeInsets.symmetric(vertical: 4),
//   // }) {
//   //   // return Container(
//   //   //   margin: margin,
//   //   //   padding: const EdgeInsets.symmetric(horizontal: 6),
//   //   //   decoration: BoxDecoration(
//   //   //     color: isSelected
//   //   //         ? Color(0xFF071130).withValues(alpha: 0.6)
//   //   //         :  const Color(0xFF071130),
//   //   //     borderRadius: BorderRadius.circular(12),
//   //   //     border: Border.all(
//   //   //         color: isSelected
//   //   //             ? AppColors.white.withValues(alpha: 0.1)
//   //   //             : Colors.white.withValues(alpha: 0.2),
//   //   //         width: 1),
//   //   //   ),
//   //   //   child: child,
//   //   // );
//   //   return AnimatedContainer(
//   //     duration: const Duration(milliseconds: 200),
//   //     curve: Curves.easeOutBack,
//   //     margin: margin,
//   //     padding: const EdgeInsets.symmetric(horizontal: 6),
//   //     transform: Matrix4.identity()
//   //       ..scale(isSelected ? 1.08 : 1.0), // 🔹 Pop-out animation
//   //     decoration: BoxDecoration(
//   //       color: isSelected
//   //           ? const Color(0xFF071130).withValues(alpha: 0.6)
//   //           : const Color(0xFF071130),
//   //       borderRadius: BorderRadius.circular(12),
//   //       border: Border.all(
//   //         color: isSelected
//   //             ? AppColors.white.withValues(alpha: 0.1)
//   //             : Colors.white.withValues(alpha: 0.2),
//   //         width: 1,
//   //       ),
//   //       boxShadow: isSelected
//   //           ? [
//   //         BoxShadow(
//   //           color: Colors.white.withOpacity(0.15),
//   //           blurRadius: 12,
//   //           offset: const Offset(0, 4),
//   //         ),
//   //       ]
//   //           : [],
//   //     ),
//   //     child: child,
//   //   );
//   //
//   // }
//   // Widget _glassyTile({
//   //   required Widget child,
//   //   bool isSelected = false,
//   //   EdgeInsets margin = const EdgeInsets.symmetric(vertical: 4),
//   // }) {
//   //   return StatefulBuilder(
//   //     builder: (context, setState) {
//   //       bool isHovered = false;
//   //
//   //       return MouseRegion(
//   //         onEnter: (_) => setState(() => isHovered = true),
//   //         onExit: (_) => setState(() => isHovered = false),
//   //         child: AnimatedContainer(
//   //           duration: const Duration(milliseconds: 200),
//   //           curve: Curves.easeOutBack,
//   //           margin: margin,
//   //           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//   //           decoration: BoxDecoration(
//   //             color: (isHovered || isSelected)
//   //                 ? const Color(0xFF0D173D).withOpacity(0.9)
//   //                 : const Color(0xFF071130),
//   //             borderRadius: BorderRadius.circular(12),
//   //             border: Border.all(
//   //               color: (isHovered || isSelected)
//   //                   ? Colors.white.withOpacity(0.25)
//   //                   : Colors.white.withOpacity(0.15),
//   //               width: 1,
//   //             ),
//   //             boxShadow: [
//   //               BoxShadow(
//   //                 color: (isHovered || isSelected)
//   //                     ? Colors.blueAccent.withOpacity(0.25)
//   //                     : Colors.transparent,
//   //                 blurRadius: 12,
//   //                 spreadRadius: 1,
//   //                 offset: const Offset(0, 3),
//   //               ),
//   //             ],
//   //           ),
//   //           child: AnimatedDefaultTextStyle(
//   //             duration: const Duration(milliseconds: 200),
//   //             style: TextStyle(
//   //               color: (isHovered || isSelected)
//   //                   ? Colors.white
//   //                   : Colors.white.withOpacity(0.7),
//   //               fontWeight: (isHovered || isSelected)
//   //                   ? FontWeight.w600
//   //                   : FontWeight.w500,
//   //             ),
//   //             child: AnimatedOpacity(
//   //               duration: const Duration(milliseconds: 200),
//   //               opacity: (isHovered || isSelected) ? 1.0 : 0.85,
//   //               child: child,
//   //             ),
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }
//   //
//   //
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
//                   ? AppColors.newColor
//                   : AppColors.newColor,
//               borderRadius: BorderRadius.circular(12),
//
//               // 🌟 Highlight border when selected
//               border: Border.all(
//                 color: isSelected
//                     ? Colors.white.withOpacity(0.45)
//                     : (isHovered
//                     ? Colors.white.withOpacity(0.25)
//                     : Colors.white.withOpacity(0.45)),
//                 width: isSelected ? 1.3 : 1.3,
//               ),
//
//               // 🌈 Add subtle glowing shadow when selected
//               boxShadow: [
//                 if (isHovered || isSelected)
//                   BoxShadow(
//                     color: isSelected
//                         ? Colors.white.withOpacity(0.25)
//                         : Colors.white.withOpacity(0.25),
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
//                     : Colors.white.withOpacity(0.7),
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
//                     fontWeight: FontWeight.w600,
//                     color: (i == _passlastSelectedItem)
//                         ? AppColors.white
//                         : AppColors.white)),
//             onTap: () {
//               switch (title) {
//               /// 2nd Level Menu
//                 case Constants.materialMovement:
//                   _onMaterialMovementItemSelected(i, context);
//                   break;
//                 case Constants.passManagement:
//                   _onPassMgmtSelectItem(i, context);
//                   break;
//                 case Constants.sCRI:
//                   _onSCRIItemSelected(i, context);
//                   break;
//                 case Constants.securityFunctions:
//                   _onSecurityFunctionsItemSelected(i, context);
//                   break;
//
//                 case Constants.ticketingSystem:
//                   _onTicketingSystemItemSelected(i, context);
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
//                 case Constants.costAndBilling:
//                   _onCostAndBillingItemSelected(i, context);
//                   break;
//
//                 case Constants.securitySystems:
//                   _onSecuritySystemIncidentItemSelected(i, context);
//                   break;
//
//                 case Constants.keyManagementData:
//                   _onKeyManagementItemSelected(
//                     i,
//                     context,
//                   );
//                   break;
//
//                 case shiftSchedulingTitle:
//                   _onShiftScheduleItemSelected(i, context);
//                   break;
//                 default:
//                   _onSecuritySystemIncidentItemSelected(i, context);
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
//           arguments: {"isInward": true});
//     } else if (index == 1) {
//       Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
//           arguments: {
//             "isInward": false, "returnable": true,
//           });
//     } else if (index == 2) {
//       Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
//           arguments: {"isInward": false, "returnable": false});
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
//
//   _onCostAndBillingItemSelected(int index, BuildContext context) async {
//     _passlastSelectedItem = index;
//     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
//     if (index == 0) {
//       Navigator.pushNamed(context, guardingRatesRoute);
//     }
//   }
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
//       case Constants.slaViolationPenaltyTitle:
//         Navigator.pushNamed(context, slaViolationPenaltyListRoute);
//         break;
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
//                     fontSize: 16,
//                     fontFamily: Constants.customFontSemiBoldFamily,
//                     fontWeight: FontWeight.w600,
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
//                       fontSize: 16,
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
//                 children: drawerItem.title == Constants.securityFunctions
//                     ? _buildOperationsFromSecurity(context, state)
//                     : _buildTicketingSystemFromSecurity(context, state)),
//           ),
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
//     if (displayMenu?.gR ?? false) {
//       menuItems.add(
//           const MenuItem(Constants.costAndBilling, AppIcon.costBillingIcon, 1));
//     }
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
//                     fontSize: 16,
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
//                     fontSize: 16,
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
//                     fontSize: 16,
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
//   List<Widget> selectedChild(MenuItem drawerItem, BuildContext context) {
//     switch (drawerItem.title) {
//       case operationsTitle:
//         return _genericItemExpandable(
//           context,
//           expansionTileDrawerItems,
//           operationsTitle,
//         );
//
//       case Constants.costAndBilling:
//         return _genericItemExpandable(
//           context,
//           costAndBillingExpansionTileDrawerItems,
//           Constants.costAndBilling,
//         );
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
//                     fontSize: 16,
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
//               if (title == Constants.costAndBilling) {
//                 _onCostAndBillingItemSelected(i, context);
//                 return;
//               }
//
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
//       case Constants.eventProtectionList:
//         Navigator.pushNamed(context, eventProtectionListRoute);
//         break;
//       case Constants.incidentManagementTitle:
//         Navigator.pushNamed(context, incidentManagementsRoute);
//         break;
//       case Constants.lawEnforcementVisitsListTitle:
//         Navigator.pushNamed(context, lawEnforcementNewListRoute);
//         break;
//       case Constants.vVipVisitorsTitle:
//         Navigator.pushNamed(context, vipVisitorsListRoute);
//         break;
//
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
//       case 2:
//         log('Sez pass Management index6');
//         Navigator.pushNamed(context, sezPassManagementListRoute, arguments: {
//           "passMngDetails": PassMngArguments(3, 'Sez Pass Management', false)
//         });
//         break;
//       case 3:
//         log('Sez pass registry index7');
//         Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
//           "passMngRegisterDetails":
//           PassMngArguments(3, 'Sez Pass Register', true)
//         });
//         break;
//       case 4:
//         log('vendor pass management index4');
//         Navigator.pushNamed(context, vendorPassManagementListRoute, arguments: {
//           "passMngDetails": PassMngArguments(2, 'Vendor Pass Management', false)
//         });
//         break;
//       case 5:
//         log('vendor pass registry index5');
//         Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
//           "passMngRegisterDetails":
//           PassMngArguments(2, 'Vendor Pass Register', true)
//         });
//         break;
//       case 6:
//         log('visitor pass management index2');
//         Navigator.pushNamed(context, visitorPassManagementListRoute, arguments: {
//           "passMngDetails":
//           PassMngArguments(1, 'Visitor Pass Management', false)
//         });
//         break;
//       case 7:
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
//     } else if (index == 4) {}
//   }
//
//   List<Widget> buildDrawerChildren(
//       BuildContext context,
//       String title,
//       ) {
//     // log('--title---$title--');
//     switch (title) {
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
//     if (displayMenu?.sVP ?? false) {
//       menuItems.add(const MenuItem(Constants.slaViolationPenaltyTitle,
//           AppIcon.slaViolationPenaltyIcon, 0));
//     }
//   }
// }
//
//
// import 'dart:developer';
//
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/features/dashboard/navigation_drawer/views/menu_permissions.dart';
//
// class NavigationDrawer1 extends StatelessWidget {
//   NavigationDrawer1(
//     this._menuScaffoldKey,
//     this.username,
//     this.email, {
//     super.key,
//   }) {
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
//     costAndBillingExpansionTileDrawerItems = await costBillingDisplayMenu();
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
//           Constants.eventProtectionList, AppIcon.eventProtectionIcon, 0));
//     }
//
//     log('gm -- ${displayMenu?.gM}');
//     if (guardingOperations) {
//       expansionTileDrawerItems.add(const MenuItem(
//           Constants.guardingOperations, AppIcon.guardingOperationIcon, 1));
//     }
//
//     if (displayMenu?.iM ?? false) {
//       expansionTileDrawerItems.add(const MenuItem(
//           Constants.incidentManagementTitle,
//           AppIcon.incidentManagementIcon,
//           0));
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
//     return expansionTileDrawerItems;
//   }
//
//   Future<List<MenuItem>> costBillingDisplayMenu() async {
//     displayMenu = await SharedPrefs.getDisplayMenu();
//     if (displayMenu == null) {
//       return [];
//     }
//     List<MenuItem> costAndBillingExpansionTileDrawerItems = [];
//     if (displayMenu?.gR ?? false) {
//       costAndBillingExpansionTileDrawerItems.add(const MenuItem(
//           Constants.guardingRates, AppIcon.guardingRatesIcon, 0));
//     }
//     return costAndBillingExpansionTileDrawerItems;
//   }
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
//
//   Future<void> getIndeifydrawerIndex() async {
//     _lastSelectedItem = await SharedPrefs.getIdentifymenuindex();
//   }
//
//   // TODO: Need to define all the Titles here
//   static const String operationsTitle = Constants.operations;
//   static const String costAndBillingTitle = Constants.costAndBilling;
//   static const String shiftSchedulingTitle = Constants.shiftScheduling;
//   static const String keyManagementDataTitle = Constants.keyManagementData;
//   static const String vVipVisitorsTitle = Constants.vVipVisitorsTitle;
//   static const String securitySystemsTitle = Constants.securitySystems;
//   static const String ticketingSystemsTitle = Constants.ticketingSystem;
//
//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: Theme.of(context).copyWith(
//         canvasColor: AppColors
//             .backgroundWhiteColor, //This will change the drawer background to blue.
//         //other styles
//       ),
//       child: Drawer(
//         child: BlocProvider(
//           create: (context) => DrawerCubit(),
//           child: BlocBuilder<DrawerCubit, DrawerState>(
//             builder: (context, state) {
//               switch (state.runtimeType) {
//                 case DrawerInitial:
//                   _lastSelectedItem = (state as DrawerInitial).index;
//                   break;
//                 case GetDrawerItemChange:
//                   _lastSelectedItem = (state as GetDrawerItemChange).index;
//                   break;
//                 case OperationsGetDrawerItemChange:
//                   log('drawer operation ');
//                   _opearationsLastSelectedItem =
//                       (state as OperationsGetDrawerItemChange).index;
//                   break;
//                 case SecurityFunctionsGetDrawerItemChange:
//                   _securityfunfunctionslastSelectedItem =
//                       (state as SecurityFunctionsGetDrawerItemChange).index;
//                   break;
//                 case PassMgmtGetDrawerItemChange:
//                   _passlastSelectedItem =
//                       (state as PassMgmtGetDrawerItemChange).index;
//                   break;
//                 case TicketingSystemGetDrawerItemChange:
//                   _ticketingSystemlastSelectedItem =
//                       (state as TicketingSystemGetDrawerItemChange).index;
//                   break;
//                 default:
//                   break;
//               }
//
//               return ListView(
//                 children: <Widget>[
//                   Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(right: 20.0),
//                         child: Align(
//                             alignment: Alignment.centerRight,
//                             child: GestureDetector(
//                                 onTap: () async {
//                                   if (_menuScaffoldKey
//                                       .currentState!.isDrawerOpen) {
//                                     _menuScaffoldKey.currentState!
//                                         .closeDrawer();
//                                     //close drawer, if drawer is open
//                                   } else {
//                                     _menuScaffoldKey.currentState!.openDrawer();
//                                     //open drawer, if drawer is closed
//                                   }
//                                 },
//                                 child: SvgPicture.asset(
//                                     AppIcon.closeicon) //Icon(Icons.cancel)
//                                 // const Icon(
//                                 //   Icons.cancel,
//                                 // ),
//                                 )),
//                       ),
//                       DrawerHeaderWidget(
//                         username: username ?? '',
//                         email: email ?? '',
//                       ),
//                       Column(
//                         children: _buildDrawerChildren(context, state),
//                       ),
//                     ],
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     ); //
//   }
//
//   List<Widget> _genericItemSelection(
//     BuildContext context,
//     List<MenuItem> items,
//     String title,
//   ) {
//     List<Widget> children = [];
//
//     for (int i = 0; i < items.length; i++) {
//       MenuItem drawerItem = items[i];
//       children.add(
//         Container(
//           decoration: const BoxDecoration(
//             border: Border(
//                 bottom: BorderSide(color: AppColors.divideLineGreyColor)),
//           ),
//           child: ListTile(
//             leading: SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: Image.asset(drawerItem.imageName,
//                     fit: BoxFit.scaleDown,
//                     color: (i == _passlastSelectedItem)
//                         ? AppColors.navigationSkyBlueColor
//                         : AppColors.boldGreyBackground)),
//             title: Text(drawerItem.title,
//                 //style: Styles.textStyleBlack16,
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontFamily: Constants.customFontSemiBoldFamily,
//                     fontWeight: FontWeight.w600,
//                     color: (i == _passlastSelectedItem)
//                         ? AppColors.navigationSkyBlueColor
//                         : AppColors.textGreyThemeColor)),
//             //selected: i == _lastSelectedItem,
//             onTap: () {
//               // log('-_genericItemSelection---title---$title---');
//               switch (title) {
//                 /// 2nd Level Menu
//                 case Constants.materialMovement:
//                   _onMaterialMovementItemSelected(i, context);
//                   break;
//                 case Constants.passManagement:
//                   _onPassMgmtSelectItem(i, context);
//                   break;
//                 case Constants.sCRI:
//                   _onSCRIItemSelected(i, context);
//                   break;
//                 case Constants.securityFunctions:
//                   _onSecurityFunctionsItemSelected(i, context);
//                   break;
//
//
//                 case Constants.ticketingSystem:
//                   _onTicketingSystemItemSelected(i, context);
//                   break;
//
//                 /// 3nd Level Menu
//                 case Constants.guardingOperations:
//                   _onGuardingOperationItemSelected(i, context, drawerItem);
//                   break;
//
//                 // case Constants.securitySystemTickets:
//                 //   _onSecuritySystemIncidentItemSelected(i, context);
//                 //   break;
//
//                 case operationsTitle:
//                   buildDrawerChildren(context, drawerItem.title);
//                   break;
//
//                 case Constants.costAndBilling:
//                   _onCostAndBillingItemSelected(i, context);
//                   break;
//
//                 case Constants.securitySystems:
//                   _onSecuritySystemIncidentItemSelected(i, context);
//                   break;
//
//                 case Constants.keyManagementData:
//                   _onKeyManagementItemSelected(
//                     i,
//                     context,
//                   );
//                   break;
//
//                 case shiftSchedulingTitle:
//                   _onShiftScheduleItemSelected(i, context);
//                   break;
//
//
//                 // case 'Guarding Operations':
//                 //   log('----_genericExpandableDrawer--case keyManagementMaster--title----$title--');
//                 //   _genericExpandableDrawer(
//                 //     context,
//                 //     keyManagementDataItems,
//                 //     Constants.keyManagementMaster,
//                 //   );
//                 //   break;
//                 // Add more cases for other titles as needed
//                 default:
//                   log('---default-------');
//                   _onSecuritySystemIncidentItemSelected(i, context);
//                 // Default case if title doesn't match any specific condition
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
//           arguments: {"isInward": true});
//     } else if (index == 1) {
//       Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
//           arguments: {
//             "isInward": false, "returnable": true,
//           });
//     }
//     else if(index == 2){
//       Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
//           arguments: {
//             "isInward": false, "returnable": false,
//           });
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
//     // _menuScaffoldKey.currentState!.closeDrawer();
//     _passlastSelectedItem = index;
//     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
//     if (index == 0) {
//       Navigator.pushNamed(
//         context,
//         sstIncidentListRoute,
//       );
//     }
//   }
//   _onTicketingSystemItemSelected(int index, BuildContext context) async {
//     // _menuScaffoldKey.currentState!.closeDrawer();
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
//   _onSecuritySystemIncidentItemSelected(int index, BuildContext context) async {
//     log('-_onSecuritySystemIncidentItemSelected------');
//
//     // _menuScaffoldKey.currentState!.closeDrawer();
//     _passlastSelectedItem = index;
//     //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
//     //state = const DrawerInitial();
//     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
//     if (index == 0) {
//       Navigator.pushNamed(context, sstIncidentListRoute,
//           arguments: {"isInternal": true});
//     }
//     // else if (index == 1) {
//     //   Navigator.pushNamed(context, sstIncidentListRoute,
//     //       arguments: {"isInternal": false});
//     // }
//   }
//
//   _onKeyManagementItemSelected(int index, BuildContext context) async {
//     // _menuScaffoldKey.currentState!.closeDrawer();
//     // _passlastSelectedItem = index;
//     //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
//     //state = const DrawerInitial();
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
//     // _menuScaffoldKey.currentState!.closeDrawer();
//     _passlastSelectedItem = index;
//
//     //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
//     //state = const DrawerInitial();
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
//
//   _onCostAndBillingItemSelected(int index, BuildContext context) async {
//     // _menuScaffoldKey.currentState!.closeDrawer();
//     _passlastSelectedItem = index;
//     context.read<DrawerCubit>().getPassMgmtIndexChange(index);
//     if (index == 0) {
//       Navigator.pushNamed(context, guardingRatesRoute);
//     }
//   }
//
//   // TODO: Fix the Drawer Index
//   _onGuardingOperationItemSelected(
//       int index, BuildContext context, MenuItem item) async {
//     // _menuScaffoldKey.currentState!.closeDrawer();
//     _passlastSelectedItem = index;
//     //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
//     //state = const DrawerInitial();
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
//       // break;
//       case Constants.shiftOccurrence:
//         Navigator.pushNamed(context, shiftOccurrenceRoute);
//         break;
//       case Constants.slaViolationPenaltyTitle:
//         Navigator.pushNamed(context, slaViolationPenaltyListRoute);
//         break;
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
//             ? Container(
//                 decoration: const BoxDecoration(
//                   border: Border(
//                       bottom: BorderSide(color: AppColors.divideLineGreyColor)),
//                 ),
//                 child: ListTile(
//                   leading: SizedBox(
//                       width: 20,
//                       height: 20,
//                       child: Image.asset(drawerItem.imageName,
//                           fit: BoxFit.cover,
//                           color: (i == _lastSelectedItem)
//                               ? AppColors.navigationSkyBlueColor
//                               : AppColors.textGreyThemeColor)),
//                   title: Text(drawerItem.title,
//                       //style: Styles.textStyleBlack16,
//                       style: TextStyle(
//                           fontSize: 16,
//                           fontFamily: Constants.customFontSemiBoldFamily,
//                           fontWeight: FontWeight.w600,
//                           color: (i == _lastSelectedItem)
//                               ? AppColors.navigationSkyBlueColor
//                               : AppColors.textGreyThemeColor)),
//                   //selected: i == _lastSelectedItem,
//                   onTap: () => _onSelectItem(
//                     i,
//                     context,
//                   ),
//                 ),
//               )
//             : Theme(
//                 data: Theme.of(context)
//                     .copyWith(dividerColor: Colors.transparent),
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     border: Border(
//                         bottom:
//                             BorderSide(color: AppColors.divideLineGreyColor)),
//                   ),
//                   child: ExpansionTile(
//                       onExpansionChanged: (value) {
//                         if (value == true) {
//                           _lastSelectedItem = i;
//                           //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
//                           //state = const DrawerInitial();
//                           context
//                               .read<DrawerCubit>()
//                               .getIndexChange(_lastSelectedItem);
//                         } else{
//                           _securityfunfunctionslastSelectedItem = 10;
//                           context
//                               .read<DrawerCubit>()
//                               .getSecurityIndexChange(10);
//                         }
//
//                       },
//                       trailing: const Icon(Icons.arrow_drop_down_rounded),
//                       // trailing: const SizedBox.shrink(),
//                       title: Text(
//                         drawerItem.title,
//                         style: TextStyle(
//                             fontSize: 16,
//                             fontFamily: Constants.customFontSemiBoldFamily,
//                             fontWeight: FontWeight.w600,
//                             color: (i == _lastSelectedItem)
//                                 ? AppColors.navigationSkyBlueColor
//                                 : AppColors.textGreyThemeColor),
//                         // style: Styles.textStyleBlack16,
//                       ),
//                       leading: SizedBox(
//                           width: 20,
//                           height: 20,
//                           child: Image.asset(drawerItem.imageName,
//                               fit: BoxFit.cover,
//                               color: (i == _lastSelectedItem)
//                                   ? AppColors.navigationSkyBlueColor
//                                   : AppColors.textGreyThemeColor)),
//                       childrenPadding: const EdgeInsets.only(left: 20),
//                       //children padding
//                       children: drawerItem.title == Constants.securityFunctions ? _buildOperationsFromSecurity(context, state) : _buildTicketingSystemFromSecurity(context,state)),
//                 ),
//               ),
//       );
//     }
//
//     return children;
//   }
//
//     List<Widget> _buildOperationsFromSecurity(
//         BuildContext context, DrawerState state) {
//       List<Widget> children = [];
//
//       List<MenuItem> menuItems = [];
//       menuItems
//           .add(const MenuItem(Constants.operations, AppIcon.operationsIcon, 1));
//       if (displayMenu?.gR ?? false) {
//         menuItems.add(
//             const MenuItem(Constants.costAndBilling, AppIcon.costBillingIcon, 1));
//       }
//       if (displayMenu?.sSSLA ?? false) {
//         menuItems.add(const MenuItem(
//             Constants.securitySystems, AppIcon.securitySystemIcon, 1));
//       }
//
//       for (int i = 0; i < menuItems.length; i++) {
//         MenuItem drawerItem = menuItems[i];
//         children.add(
//           drawerItem.numberOfChildren == 0
//               ? Container(
//                   decoration: const BoxDecoration(
//                     border: Border(
//                         bottom: BorderSide(color: AppColors.divideLineGreyColor)),
//                   ),
//                   child: ListTile(
//                     leading: SizedBox(
//                         width: 20,
//                         height: 20,
//                         child: Image.asset(
//                           drawerItem.imageName,
//                           //fit: BoxFit.cover,
//                           color: (i == _securityfunfunctionslastSelectedItem)
//                               ? AppColors.navigationSkyBlueColor
//                               : AppColors.geryLightBackground,
//                         )),
//                     title: Text(drawerItem.title,
//                         //style: Styles.textStyleBlack16,
//                         style: TextStyle(
//                             fontSize: 16,
//                             fontFamily: Constants.customFontSemiBoldFamily,
//                             fontWeight: FontWeight.w600,
//                             color: (i == _securityfunfunctionslastSelectedItem)
//                                 ? AppColors.navigationSkyBlueColor
//                                 : AppColors.textGreyThemeColor)),
//                     //selected: i == _lastSelectedItem,
//                     onTap: () => _onSecurityExpansionSelectItem(i, context),
//                   ),
//                 )
//               : Theme(
//                   data: Theme.of(context)
//                       .copyWith(dividerColor: Colors.transparent),
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       border: Border(
//                           bottom:
//                               BorderSide(color: AppColors.divideLineGreyColor)),
//                     ),
//                     child: ExpansionTile(
//                       onExpansionChanged: (value) {
//                         if (value == true) {
//                           _securityfunfunctionslastSelectedItem = i;
//                           //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
//                           //state = const DrawerInitial();
//                           context.read<DrawerCubit>().getSecurityIndexChange(
//                               _securityfunfunctionslastSelectedItem);
//                         } else {
//                           _securityfunfunctionslastSelectedItem = 10;
//                           context.read<DrawerCubit>().getSecurityIndexChange(
//                               _securityfunfunctionslastSelectedItem);
//                         }
//                       },
//                       trailing: const Icon(Icons.arrow_drop_down_rounded),
//                       title: Text(
//                         drawerItem.title,
//                         style: TextStyle(
//                             fontSize: 16,
//                             fontFamily: Constants.customFontSemiBoldFamily,
//                             fontWeight: FontWeight.w600,
//                             color: (i == _lastSelectedItem)
//                                 ? AppColors.navigationSkyBlueColor
//                                 : AppColors.textGreyThemeColor),
//                         // style: Styles.textStyleBlack16,
//                       ),
//                       leading: SizedBox(
//                         width: 20,
//                         height: 20,
//                         child: Image.asset(
//                             i == 0
//                                 ? AppIcon.operationsIcon
//                                 : i == 1
//                                     ? AppIcon.costBillingIcon
//                                     : AppIcon.securitySystemIcon,
//                             fit: BoxFit.cover,
//                             color: (i == _lastSelectedItem)
//                                 ? AppColors.navigationSkyBlueColor
//                                 : AppColors.textGreyThemeColor),
//                       ),
//                       childrenPadding: const EdgeInsets.only(left: 20),
//                       //children padding
//                       children: selectedChild(drawerItem, context),
//                     ),
//                   ),
//                 ),
//         );
//       }
//
//       return children;
//     }
//
//   List<Widget> _buildTicketingSystemFromSecurity(
//       BuildContext context, DrawerState state) {
//     List<Widget> children = [];
//
//     List<MenuItem> menuItems = [];
//     menuItems
//         .add(const MenuItem(Constants.tickets, AppIcon.ticketsIcon, 1));
//
//     for (int i = 0; i < menuItems.length; i++) {
//       MenuItem drawerItem = menuItems[i];
//       children.add(
//       Container(
//           decoration: const BoxDecoration(
//             border: Border(
//                 bottom: BorderSide(color: AppColors.divideLineGreyColor)),
//           ),
//           child: ListTile(
//             leading: SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: Image.asset(
//                   drawerItem.imageName,
//                   //fit: BoxFit.cover,
//                   color: (i == _ticketingSystemlastSelectedItem)
//                       ? AppColors.navigationSkyBlueColor
//                       : AppColors.textGreyThemeColor,
//                 )),
//             title: Text(drawerItem.title,
//                 //style: Styles.textStyleBlack16,
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontFamily: Constants.customFontSemiBoldFamily,
//                     fontWeight: FontWeight.w600,
//                     color: (i == _ticketingSystemlastSelectedItem)
//                         ? AppColors.navigationSkyBlueColor
//                         : AppColors.textGreyThemeColor)),
//             //selected: i == _lastSelectedItem,
//             onTap: () => _onTicketingSystemItemSelected(i, context),
//           ),
//         )
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
//       case Constants.costAndBilling:
//         return _genericItemExpandable(
//           context,
//           costAndBillingExpansionTileDrawerItems,
//           Constants.costAndBilling,
//         );
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
//     BuildContext context,
//     List<MenuItem> items,
//     String title,
//   ) {
//     List<Widget> children = [];
//
//     for (int i = 0; i < items.length; i++) {
//       MenuItem drawerItem = items[i];
//       // log('--drawerItem-title-${drawerItem.title}--');
//       children.add(
//         drawerItem.numberOfChildren == 0
//             ? Container(
//                 decoration: const BoxDecoration(
//                   border: Border(
//                       bottom: BorderSide(color: AppColors.divideLineGreyColor)),
//                 ),
//                 child: ListTile(
//                   leading: SizedBox(
//                       width: 20,
//                       height: 20,
//                       child: Image.asset(drawerItem.imageName,
//                           fit: BoxFit.cover,
//                           color: (i == _opearationsLastSelectedItem)
//                               ? AppColors.navigationSkyBlueColor
//                               : AppColors.textGreyThemeColor)),
//                   title: Text(drawerItem.title,
//                       //style: Styles.textStyleBlack16,
//                       style: TextStyle(
//                           fontSize: 16,
//                           fontFamily: Constants.customFontSemiBoldFamily,
//                           fontWeight: FontWeight.w600,
//                           color: (i == _opearationsLastSelectedItem)
//                               ? AppColors.navigationSkyBlueColor
//                               : AppColors.textGreyThemeColor)),
//                   // selected: i == _lastSelectedItem,
//                   onTap: () {
//                     // log('-onTap-----title---$title---');
//                     if (title == Constants.guardingOperations) {
//                       _onGuardingOperationItemSelected(i, context, drawerItem);
//                       return;
//                     }
//
//                     if (title == Constants.keyManagementData) {
//                       _onKeyManagementItemSelected(i, context);
//                       return;
//                     }
//                     if (title == Constants.shiftSchedule) {
//                       _onShiftScheduleItemSelected(i, context);
//                       return;
//                     }
//                     if (title == Constants.costAndBilling) {
//                       _onCostAndBillingItemSelected(i, context);
//                       return;
//                     }
//
//                     log('--title-$title-');
//                     if (title == Constants.securitySystems) {
//                       _onSecuritySystemIncidentItemSelected(i, context);
//                       return;
//                     }
//
//                     _onExpansionSelectItem(i, context, drawerItem);
//                   },
//                 ),
//               )
//             : Theme(
//                 data: Theme.of(context)
//                     .copyWith(dividerColor: Colors.transparent),
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     border: Border(
//                         bottom:
//                             BorderSide(color: AppColors.divideLineGreyColor)),
//                   ),
//                   child: ExpansionTile(
//                     onExpansionChanged: (value) {
//                       if (value == true) {
//                         _opearationsLastSelectedItem = i;
//                         //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
//                         //state = const DrawerInitial();
//                         context.read<DrawerCubit>().getOperationsIndexChange(
//                             _opearationsLastSelectedItem);
//                       } else {
//                         _opearationsLastSelectedItem = 10;
//                         context
//                             .read<DrawerCubit>()
//                             .getOperationsIndexChange(10);
//                       }
//                     },
//                     trailing: const Icon(Icons.arrow_drop_down_rounded),
//                     title: Text(
//                       drawerItem.title,
//                       style: TextStyle(
//                           fontSize: 16,
//                           fontFamily: Constants.customFontSemiBoldFamily,
//                           fontWeight: FontWeight.w600,
//                           color: (i == _opearationsLastSelectedItem)
//                               ? AppColors.navigationSkyBlueColor
//                               : AppColors.textGreyThemeColor),
//                       // style: Styles.textStyleBlack16,
//                     ),
//                     leading: SizedBox(
//                       width: 18,
//                       height: 18,
//                       child: Image.asset(drawerItem.imageName,
//                           fit: BoxFit.fitHeight,
//                           color: (i == _opearationsLastSelectedItem)
//                               ? AppColors.navigationSkyBlueColor
//                               : AppColors.textGreyThemeColor),
//                     ),
//                     childrenPadding: const EdgeInsets.only(left: 20),
//                     //children padding
//                     children: buildDrawerChildren(context, drawerItem.title),
//                   ),
//                 ),
//               ),
//       );
//     }
//
//     return children;
//   }
//
//   _onExpansionSelectItem(int index, BuildContext context, MenuItem item) async {
//     log('---_onExpansionSelectItem--$index-');
//     // _menuScaffoldKey.currentState!.closeDrawer();
//     _opearationsLastSelectedItem = index;
//     //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
//     //state = const DrawerInitial();
//     context.read<DrawerCubit>().getOperationsIndexChange(index);
//     log('---item.title--${item.title}-');
//
//     switch (item.title) {
//       case Constants.annualPowerShutdownListTitle:
//         Navigator.pushNamed(context, annualPowerShutdownListRoute);
//         break;
//       case Constants.articleFoundRegisterListTitle:
//         Navigator.pushNamed(context, articleFoundNewListRoute);
//         break;
//       case Constants.eventProtectionList:
//         Navigator.pushNamed(context, eventProtectionListRoute);
//         break;
//       // case Constants.annualPowerShutdownListTitle:
//       //   Navigator.pushNamed(context, annualPowerShutdownListRoute);
//       //   break;
//       case Constants.incidentManagementTitle:
//         Navigator.pushNamed(context, incidentManagementsRoute);
//         break;
//       case Constants.lawEnforcementVisitsListTitle:
//         Navigator.pushNamed(context, lawEnforcementNewListRoute);
//         break;
//       case Constants.vVipVisitorsTitle:
//         Navigator.pushNamed(context, vipVisitorsListRoute);
//         break;
//
//       default:
//         break;
//     }
//     // if (index == 0) {
//     //   Navigator.pushNamed(context, annualPowerShutdownListRoute);
//     // } else if (index == 1) {
//     //   Navigator.pushNamed(context, articleFoundListRoute);
//     // } else if (index == 2) {
//     //   Navigator.pushNamed(context, eventProtectionListRoute);
//     // } else if (index == 3) {
//     //   log('Index 3 -$index--- ');
//     //   Navigator.pushNamed(context, annualPowerShutdownListRoute);
//     // } else if (index == 4) {
//     //   Navigator.pushNamed(context, incidentManagementsRoute);
//     // } else if (index == 5) {
//     // } else if (index == 6) {
//     //   Navigator.pushNamed(context, lawEnforcementListRoute);
//     // } else if (index == 10) {
//     //   Navigator.pushNamed(context, vipVisitorsListRoute);
//     // }
//   }
//
//   _onPassMgmtSelectItem(int index, BuildContext context) async {
//     // _menuScaffoldKey.currentState!.closeDrawer();
//     _passlastSelectedItem = index;
//     //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
//     //state = const DrawerInitial();
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
//               PassMngArguments(0, 'Day Pass Register', true)
//         });
//         break;
//       case 2:
//         log('Sez pass Management index6');
//         Navigator.pushNamed(context, sezPassManagementListRoute, arguments: {
//           "passMngDetails": PassMngArguments(3, 'Sez Pass Management', false)
//         });
//         break;
//       case 3:
//         log('Sez pass registry index7');
//         Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
//           "passMngRegisterDetails":
//               PassMngArguments(3, 'Sez Pass Register', true)
//         });
//         break;
//       case 4:
//         log('vendor pass management index4');
//         Navigator.pushNamed(context, vendorPassManagementListRoute, arguments: {
//           "passMngDetails": PassMngArguments(2, 'Vendor Pass Management', false)
//         });
//         break;
//       case 5:
//         log('vendor pass registry index5');
//         Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
//           "passMngRegisterDetails":
//               PassMngArguments(2, 'Vendor Pass Register', true)
//         });
//         break;
//       case 6:
//         log('visitor pass management index2');
//         Navigator.pushNamed(context, visitorPassManagementListRoute, arguments: {
//           "passMngDetails":
//               PassMngArguments(1, 'Visitor Pass Management', false)
//         });
//         break;
//       case 7:
//         log('visitor pass registry index3');
//         Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
//           "passMngRegisterDetails":
//               PassMngArguments(1, 'Visitor Pass Register', true)
//         });
//         break;
//       default:
//         break;
//     }
//     // if (index == 0) {
//     //   //day pass mng = 0
//     //   log('day pass mangement index0');
//     //   Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
//     //     "passMngDetails": PassMngArguments(0, 'Day Pass Management', false)
//     //   });
//     // } else if (index == 1) {
//     //   log('day pass registry index1');
//     //   //day pass mng = 0
//     //   Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
//     //     "passMngRegisterDetails": PassMngArguments(0, 'Day Pass Register', true)
//     //   });
//     // } else if (index == 2) {
//     //   //vendor pass mng = 3
//     //
//     //   log('Sez pass Management index6');
//     //   Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
//     //     "passMngDetails": PassMngArguments(3, 'Sez Pass Management', false)
//     //   });
//     // } else if (index == 3) {
//     //   log('Sez pass registory index7');
//     //   Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
//     //     "passMngRegisterDetails": PassMngArguments(3, 'Sez Pass Register', true)
//     //   });
//     // } else if (index == 4) {
//     //   log('vendor pass management index4');
//     //   Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
//     //     "passMngDetails": PassMngArguments(2, 'Vendor Pass Management', false)
//     //   });
//     // } else if (index == 5) {
//     //   //vendor pass mng = 2
//     //
//     //   log('vendor pass registory index5');
//     //   Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
//     //     "passMngRegisterDetails":
//     //         PassMngArguments(2, 'Vendor Pass Register', true)
//     //   });
//     // } else if (index == 6) {
//     //   //visitor pass mng = 1
//     //
//     //   log('visitor pass mangement index2');
//     //   Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
//     //     "passMngDetails": PassMngArguments(1, 'Visitor Pass Management', false)
//     //   });
//     // } else if (index == 7) {
//     //   //visitor pass mng = 1
//     //   log('visitor pass registory index3');
//     //   Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
//     //     "passMngRegisterDetails":
//     //         PassMngArguments(1, 'Visitor Pass Register', true)
//     //   });
//     // }
//   }
//
//   _onSecurityExpansionSelectItem(int index, BuildContext context) async {
//     // _menuScaffoldKey.currentState!.closeDrawer();
//     _securityfunfunctionslastSelectedItem = index;
//     //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
//     //state = const DrawerInitial();
//     context.read<DrawerCubit>().getSecurityIndexChange(index);
//     if (index == 0) {
//       Navigator.pushNamed(context, sstIncidentListRoute);
//     }
//   }
//
//   _onSelectItem(
//     int index,
//     BuildContext context,
//   ) async {
//     //Navigator.pop(context)
//     if (index != 5) {
//       // _menuScaffoldKey.currentState!.closeDrawer();
//     }
//     _lastSelectedItem = index;
//     // var lastindex = await SharedPrefs.setIdentifymenuindex(index);
//
//     //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
//     //state = const DrawerInitial();
//
//     context.read<DrawerCubit>().getIndexChange(index);
//     if (index != 2) {
//       _opearationsLastSelectedItem = 10;
//     }
//     //SetState(){}
//     if (index == 0) {
//     } else if (index == 1) {
//       // _logout(context);
//     } else if (index == 3) {
//       Navigator.pushNamed(
//         context,
//         resetPwdScreenRoute,
//         arguments: {'viaNavigationDrawer': true},
//       );
//     } else if (index == 4) {}
//   }
//
//   // _logout(BuildContext context) {
//   //   var dialog = CustomAlertDialog(
//   //       title: Constants.logout,
//   //       message: Constants.logoutValidation,
//   //       onPositivePressed: () {
//   //         InactivityFunctions().logoutUser(navigatorKey);
//   //       },
//   //       positiveBtnText: Constants.yes,
//   //       negativeBtnText: Constants.no);
//   //   showDialog(context: context, builder: (BuildContext context) => dialog);
//   // }
//
//   List<Widget> buildDrawerChildren(
//     BuildContext context,
//     String title,
//   ) {
//     // log('--title---$title--');
//     switch (title) {
//       case Constants.materialMovement:
//         return _genericItemSelection(
//             context, materialMovementDrawerItemsWithReturnable, title);
//       // case Constants.securitySystemTickets:
//       //   return _genericItemExpandable(
//       //     context,
//       //     securitySystemTicketsItems,
//       //     Constants.securitySystemTickets,
//       //   );
//       // case Constants.guardingOperations:
//       //   return _genericItemExpandable(
//       //     context,
//       //     guardingOperationDrawerItems,
//       //     Constants.guardingOperations,
//       //   );
//       case Constants.guardingOperations:
//         List<MenuItem> menuItems = [];
//         checkMenuPermissionsGuardingOperations(displayMenu, menuItems);
//
//         // if (displayMenu?.cD ?? false) {
//         //   menuItems.add(const MenuItem(
//         //       Constants.escalationMatrix, AppIcon.escalationMatrixIcon, 0));
//         // }
//         //
//         // if (displayMenu?.gM ?? false) {
//         //   menuItems.add(const MenuItem(
//         //       Constants.guardingMasterData, AppIcon.guardingMasterDataIcon, 0));
//         // }
//         //
//         // if (displayMenu?.gMR ?? false) {
//         //   menuItems.add(const MenuItem(Constants.guardingMasterReport,
//         //       AppIcon.guardingMasterReportIcon, 0));
//         // }
//         //
//         // if (displayMenu?.oCC ?? false) {
//         //   menuItems.add(const MenuItem(
//         //       Constants.shiftOccurrence, AppIcon.shiftOccurrenceIcon, 0));
//         // }
//         // if (displayMenu?.sVP ?? false) {
//         //   menuItems.add(const MenuItem(Constants.slaViolationPenaltyTitle,
//         //       AppIcon.slaViolationPenaltyIcon, 0));
//         // }
//         return _genericItemExpandable(
//           context,
//           menuItems,
//           Constants.guardingOperations,
//         );
//
//       // case Constants.securityFunctions:
//       //   return _genericItemSelection(
//       //     context,
//       //     securitySystemTicketsItems,
//       //     title,
//       //   );
//
//       // case keyManagementDataTitle:
//       //   return _genericItemSelection(
//       //     context,
//       //     keyManagementDataItems,
//       //     title,
//       //   );
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
//       // case shiftSchedulingTitle:
//       //   return _genericItemSelection(
//       //     context,
//       //     shiftSchedulingDataItems,
//       //     title,
//       //   );
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
//     DisplayMenu? displayMenu,
//     List<MenuItem> menuItems,
//   ) {
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
//     if (displayMenu?.sVP ?? false) {
//       menuItems.add(const MenuItem(Constants.slaViolationPenaltyTitle,
//           AppIcon.slaViolationPenaltyIcon, 0));
//     }
//   }
// }
//
//
// // import 'dart:developer';
// // import 'dart:ui';
// // import 'package:db_atom/index.dart';
// // import 'package:db_atom/src/features/dashboard/navigation_drawer/views/menu_permissions.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// //
// // class NavigationDrawer1 extends StatelessWidget {
// //   NavigationDrawer1(
// //       this._menuScaffoldKey,
// //       this.username,
// //       this.email, {
// //         super.key,
// //       }) {
// //     initializeDrawerItems();
// //   }
// //
// //   late List<MenuItem> expansionTileDrawerItems = [];
// //   late List<MenuItem> costAndBillingExpansionTileDrawerItems = [];
// //   late List<MenuItem> securitySystemTicketsItems = [];
// //
// //   Future<void> initializeDrawerItems() async {
// //     expansionTileDrawerItems = await checkDisplayMenu();
// //     costAndBillingExpansionTileDrawerItems = await costBillingDisplayMenu();
// //     securitySystemTicketsItems = await securitySystemsDisplayMenu();
// //   }
// //
// //   DisplayMenu? displayMenu;
// //   final String? username;
// //   final String? email;
// //   final GlobalKey<ScaffoldState> _menuScaffoldKey;
// //
// //   late int _lastSelectedItem = 0;
// //   late int _opearationsLastSelectedItem = 10;
// //   late int _passlastSelectedItem = 10;
// //   late int _securityfunfunctionslastSelectedItem = 10;
// //   late int _ticketingSystemlastSelectedItem = 1;
// //
// //   Future<List<MenuItem>> checkDisplayMenu() async {
// //     displayMenu = await SharedPrefs.getDisplayMenu();
// //     bool guardingOperations = ((displayMenu?.gM ?? false) ||
// //         (displayMenu?.cD ?? false) ||
// //         (displayMenu?.gR ?? false) ||
// //         (displayMenu?.oCC ?? false) ||
// //         (displayMenu?.sVP ?? false) ||
// //         (displayMenu?.gMR ?? false));
// //
// //     if (displayMenu == null) return [];
// //     List<MenuItem> expansionTileDrawerItems = [];
// //
// //     if (displayMenu?.aF ?? false) {
// //       expansionTileDrawerItems.add(const MenuItem(
// //           Constants.articleFoundRegisterListTitle,
// //           AppIcon.articleFoundRegisterIcon,
// //           0));
// //     }
// //
// //     if (guardingOperations) {
// //       expansionTileDrawerItems.add(const MenuItem(
// //           Constants.guardingOperations, AppIcon.guardingOperationIcon, 1));
// //     }
// //
// //     if (displayMenu?.lEO ?? false) {
// //       expansionTileDrawerItems.add(const MenuItem(
// //           Constants.lawEnforcementVisitsListTitle,
// //           AppIcon.lawEnforcementIcon,
// //           0));
// //     }
// //
// //     if (displayMenu?.pM ?? false) {
// //       expansionTileDrawerItems.add(const MenuItem(
// //           Constants.passManagement, AppIcon.passManagementIcon, 1));
// //     }
// //
// //     if (displayMenu?.sS ?? false) {
// //       expansionTileDrawerItems.add(const MenuItem(
// //           shiftSchedulingTitle, AppIcon.eventProtectionIcon, 1));
// //     }
// //
// //     return expansionTileDrawerItems;
// //   }
// //
// //   Future<List<MenuItem>> costBillingDisplayMenu() async {
// //     displayMenu = await SharedPrefs.getDisplayMenu();
// //     if (displayMenu == null) return [];
// //     List<MenuItem> costAndBillingExpansionTileDrawerItems = [];
// //     if (displayMenu?.gR ?? false) {
// //       costAndBillingExpansionTileDrawerItems.add(const MenuItem(
// //           Constants.guardingRates, AppIcon.guardingRatesIcon, 0));
// //     }
// //     return costAndBillingExpansionTileDrawerItems;
// //   }
// //
// //   Future<List<MenuItem>> securitySystemsDisplayMenu() async {
// //     displayMenu = await SharedPrefs.getDisplayMenu();
// //     if (displayMenu == null) return [];
// //     List<MenuItem> securitySystemTicketsItems = [];
// //     if (displayMenu?.gR ?? false) {
// //       securitySystemTicketsItems
// //           .add(const MenuItem(Constants.incident, AppIcon.incidentIcon, 0));
// //     }
// //     return securitySystemTicketsItems;
// //   }
// //
// //   static const String shiftSchedulingTitle = Constants.shiftScheduling;
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Theme(
//   //     data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
//   //     child: Drawer(
//   //       child: Row(
//   //         children: [
//   //           // -------------------- LEFT SIDEBAR --------------------
//   //           Container(
//   //             width: 70,
//   //             decoration: const BoxDecoration(
//   //               gradient: LinearGradient(
//   //                 colors: [Color(0xFF0000CC), Color(0xFFA08256)],
//   //                 begin: Alignment.topCenter,
//   //                 end: Alignment.bottomCenter,
//   //               ),
//   //             ),
//   //             child: Column(
//   //               mainAxisAlignment: MainAxisAlignment.center,
//   //               children: [
//   //                 _sidebarIcon(AppIcon.searchIcon),
//   //                 const SizedBox(height: 20),
//   //                 _sidebarIcon(AppIcon.searchIcon),
//   //                 const SizedBox(height: 20),
//   //                 _sidebarIcon(AppIcon.searchIcon),
//   //                 const SizedBox(height: 20),
//   //                 _sidebarIcon(AppIcon.searchIcon),
//   //               ],
//   //             ),
//   //           ),
//   //
//   //           // -------------------- MAIN CONTENT --------------------
//   //           Expanded(
//   //             child: BlocProvider(
//   //               create: (context) => DrawerCubit(),
//   //               child: BlocBuilder<DrawerCubit, DrawerState>(
//   //                 builder: (context, state) {
//   //                   switch (state.runtimeType) {
//   //                     case DrawerInitial:
//   //                       _lastSelectedItem = (state as DrawerInitial).index;
//   //                       break;
//   //                     case GetDrawerItemChange:
//   //                       _lastSelectedItem =
//   //                           (state as GetDrawerItemChange).index;
//   //                       break;
//   //                     case OperationsGetDrawerItemChange:
//   //                       _opearationsLastSelectedItem =
//   //                           (state as OperationsGetDrawerItemChange).index;
//   //                       break;
//   //                     case PassMgmtGetDrawerItemChange:
//   //                       _passlastSelectedItem =
//   //                           (state as PassMgmtGetDrawerItemChange).index;
//   //                       break;
//   //                     default:
//   //                       break;
//   //                   }
//   //
//   //                   return Column(
//   //                     crossAxisAlignment: CrossAxisAlignment.start,
//   //                     children: [
//   //                       // ------------- PROFILE HEADER -------------
//   //                       Container(
//   //                         width: double.infinity,
//   //                         padding: const EdgeInsets.all(10),
//   //                         decoration: const BoxDecoration(
//   //                           gradient: LinearGradient(
//   //                             colors: [Color(0xFF0000CC), Color(0xFFA08256)],
//   //                             begin: Alignment.topLeft,
//   //                             end: Alignment.bottomRight,
//   //                           ),
//   //                           borderRadius: BorderRadius.only(
//   //                             bottomLeft: Radius.circular(10),
//   //                           ),
//   //                         ),
//   //                         child: Row(
//   //                           children: [
//   //                             const CircleAvatar(
//   //                               radius: 24,
//   //                               backgroundImage:
//   //                               AssetImage('assets/images/profile.png'),
//   //                             ),
//   //                             const SizedBox(width: 10),
//   //                             Expanded(
//   //                               child: Column(
//   //                                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                                 children: [
//   //                                   Text(username ?? '',
//   //                                       style: const TextStyle(
//   //                                           fontWeight: FontWeight.bold,
//   //                                           color: Colors.white)),
//   //                                   Text(email ?? '',
//   //                                       style: const TextStyle(
//   //                                           color: Colors.white70,
//   //                                           fontSize: 12)),
//   //                                 ],
//   //                               ),
//   //                             ),
//   //                             GestureDetector(
//   //                               onTap: () {
//   //                                 _menuScaffoldKey.currentState?.closeDrawer();
//   //                               },
//   //                               child: const Icon(Icons.close,
//   //                                   color: Colors.white),
//   //                             )
//   //                           ],
//   //                         ),
//   //                       ),
//   //
//   //                       // ------------- BODY -------------
//   //                       Expanded(
//   //                         child: Container(
//   //                           decoration: const BoxDecoration(
//   //                             color: Colors.blue,
//   //                             boxShadow: [
//   //                               BoxShadow(
//   //                                 color: Colors.black12,
//   //                                 blurRadius: 3,
//   //                               )
//   //                             ],
//   //                           ),
//   //                           child: ListView(
//   //                             padding:
//   //                             const EdgeInsets.only(left: 10, right: 10),
//   //                             children: [
//   //                               const SizedBox(height: 20),
//   //                               const Text(
//   //                                 "Security Functions",
//   //                                 style: TextStyle(
//   //                                   fontSize: 18,
//   //                                   fontWeight: FontWeight.w700,
//   //                                   color: Colors.black87,
//   //                                 ),
//   //                               ),
//   //                               const SizedBox(height: 10),
//   //                               _buildOperationsMenu(context),
//   //                             ],
//   //                           ),
//   //                         ),
//   //                       ),
//   //                     ],
//   //                   );
//   //                 },
//   //               ),
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Theme(
//   //     data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
//   //     child: Drawer(
//   //       child: Row(
//   //         children: [
//   //           // -------------------- LEFT SIDEBAR --------------------
//   //           Container(
//   //             width: 70,
//   //             decoration: BoxDecoration(
//   //               borderRadius: const BorderRadius.only(
//   //                 topRight: Radius.circular(20),
//   //                 bottomRight: Radius.circular(20),
//   //               ),
//   //               color: Color(0xFF000080).withValues(alpha: 0.2),
//   //               boxShadow: [
//   //                 BoxShadow(
//   //                   color: Color(0xFF000080).withValues(alpha: 0.8),
//   //                   blurRadius: 10,
//   //                   offset: const Offset(0, 4),
//   //                 ),
//   //               ],
//   //             ),
//   //             child: ClipRRect(
//   //               borderRadius: const BorderRadius.only(
//   //                 topRight: Radius.circular(20),
//   //                 bottomRight: Radius.circular(20),
//   //               ),
//   //               child: BackdropFilter(
//   //                 filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
//   //                 child: Column(
//   //                   mainAxisAlignment: MainAxisAlignment.center,
//   //                   children: [
//   //                     _sidebarIcon(AppIcon.searchIcon),
//   //                     const SizedBox(height: 20),
//   //                     _sidebarIcon(AppIcon.searchIcon),
//   //                     const SizedBox(height: 20),
//   //                     _sidebarIcon(AppIcon.searchIcon),
//   //                     const SizedBox(height: 20),
//   //                     _sidebarIcon(AppIcon.searchIcon),
//   //                   ],
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //
//   //           // -------------------- MAIN CONTENT --------------------
//   //           Expanded(
//   //             child: BlocProvider(
//   //               create: (context) => DrawerCubit(),
//   //               child: BlocBuilder<DrawerCubit, DrawerState>(
//   //                 builder: (context, state) {
//   //                   switch (state.runtimeType) {
//   //                     case DrawerInitial:
//   //                       _lastSelectedItem = (state as DrawerInitial).index;
//   //                       break;
//   //                     case GetDrawerItemChange:
//   //                       _lastSelectedItem =
//   //                           (state as GetDrawerItemChange).index;
//   //                       break;
//   //                     case OperationsGetDrawerItemChange:
//   //                       _opearationsLastSelectedItem =
//   //                           (state as OperationsGetDrawerItemChange).index;
//   //                       break;
//   //                     case PassMgmtGetDrawerItemChange:
//   //                       _passlastSelectedItem =
//   //                           (state as PassMgmtGetDrawerItemChange).index;
//   //                       break;
//   //                     default:
//   //                       break;
//   //                   }
//   //
//   //                   return ClipRRect(
//   //                     borderRadius: const BorderRadius.only(
//   //                       topLeft: Radius.circular(25),
//   //                       bottomLeft: Radius.circular(25),
//   //                     ),
//   //                     child: BackdropFilter(
//   //                       filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//   //                       child: Container(
//   //                         decoration: BoxDecoration(
//   //                           color:Color(0xFF000080).withValues(alpha: 0.4),
//   //                           borderRadius: const BorderRadius.only(
//   //                             topLeft: Radius.circular(25),
//   //                             bottomLeft: Radius.circular(25),
//   //                           ),
//   //                           border: Border.all(
//   //                             color: Color(0xFF000080).withValues(alpha: 0.8),
//   //                             width: 1,
//   //                           ),
//   //                           boxShadow: [
//   //                             BoxShadow(
//   //                               color: Color(0xFF000080).withValues(alpha: 0.4),
//   //                               blurRadius: 8,
//   //                               offset: const Offset(0, 4),
//   //                             ),
//   //                           ],
//   //                         ),
//   //                         child: Column(
//   //                           crossAxisAlignment: CrossAxisAlignment.start,
//   //                           children: [
//   //                             // ------------- PROFILE HEADER -------------
//   //                             Container(
//   //                               width: double.infinity,
//   //                               padding: const EdgeInsets.all(10),
//   //                               decoration: BoxDecoration(
//   //                                 gradient: LinearGradient(
//   //                                   colors: [
//   //                                     Colors.white.withOpacity(0.3),
//   //                                     Colors.white.withOpacity(0.1),
//   //                                   ],
//   //                                   begin: Alignment.topLeft,
//   //                                   end: Alignment.bottomRight,
//   //                                 ),
//   //                                 borderRadius: const BorderRadius.only(
//   //                                   bottomLeft: Radius.circular(10),
//   //                                 ),
//   //                                 border: Border.all(
//   //                                   color: Colors.white.withOpacity(0.2),
//   //                                 ),
//   //                               ),
//   //                               child: Row(
//   //                                 children: [
//   //                                   const CircleAvatar(
//   //                                     radius: 24,
//   //                                     backgroundImage: AssetImage(
//   //                                       'assets/images/profile.png',
//   //                                     ),
//   //                                   ),
//   //                                   const SizedBox(width: 10),
//   //                                   Expanded(
//   //                                     child: Column(
//   //                                       crossAxisAlignment:
//   //                                       CrossAxisAlignment.start,
//   //                                       children: [
//   //                                         Text(
//   //                                           username ?? '',
//   //                                           style: const TextStyle(
//   //                                             fontWeight: FontWeight.bold,
//   //                                             color: Colors.white,
//   //                                           ),
//   //                                         ),
//   //                                         Text(
//   //                                           email ?? '',
//   //                                           style: const TextStyle(
//   //                                             color: Colors.white70,
//   //                                             fontSize: 12,
//   //                                           ),
//   //                                         ),
//   //                                       ],
//   //                                     ),
//   //                                   ),
//   //                                   GestureDetector(
//   //                                     onTap: () {
//   //                                       _menuScaffoldKey.currentState
//   //                                           ?.closeDrawer();
//   //                                     },
//   //                                     child: const Icon(
//   //                                       Icons.close,
//   //                                       color: Colors.white,
//   //                                     ),
//   //                                   ),
//   //                                 ],
//   //                               ),
//   //                             ),
//   //
//   //                             // ------------- BODY -------------
//   //                             Expanded(
//   //                               child: Container(
//   //                                 margin: const EdgeInsets.all(8),
//   //                                 decoration: BoxDecoration(
//   //                                   color: Colors.white.withOpacity(0.05),
//   //                                   borderRadius: BorderRadius.circular(20),
//   //                                   border: Border.all(
//   //                                     color: Colors.white.withOpacity(0.15),
//   //                                   ),
//   //                                   boxShadow: [
//   //                                     BoxShadow(
//   //                                       color: Colors.black.withOpacity(0.2),
//   //                                       blurRadius: 10,
//   //                                       offset: const Offset(0, 4),
//   //                                     ),
//   //                                   ],
//   //                                 ),
//   //                                 child: ListView(
//   //                                   padding: const EdgeInsets.only(
//   //                                     left: 10,
//   //                                     right: 10,
//   //                                   ),
//   //                                   children: [
//   //                                     const SizedBox(height: 20),
//   //                                     const Text(
//   //                                       "Security Functions",
//   //                                       style: TextStyle(
//   //                                         fontSize: 18,
//   //                                         fontWeight: FontWeight.w700,
//   //                                         color: Colors.white,
//   //                                       ),
//   //                                     ),
//   //                                     const SizedBox(height: 10),
//   //                                     _buildOperationsMenu(context),
//   //                                   ],
//   //                                 ),
//   //                               ),
//   //                             ),
//   //                           ],
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   );
//   //                 },
//   //               ),
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
// //   Widget build(BuildContext context) {
// //     final double drawerWidth = MediaQuery.of(context).size.width * 0.85;
// //
// //     return Theme(
// //       data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
// //       child: Drawer(
// //         width: drawerWidth,
// //         backgroundColor: Colors.transparent,
// //         elevation: 0,
// //         child: Row(
// //           children: [
// //             // -------------------- LEFT SIDEBAR --------------------
// //             Container(
// //               width: 70,
// //               decoration: BoxDecoration(
// //                 gradient: LinearGradient(
// //                   colors: [
// //                     const Color(0xFF001F5B).withOpacity(0.8),
// //                     const Color(0xFFA08256).withOpacity(0.6),
// //                   ],
// //                   begin: Alignment.topCenter,
// //                   end: Alignment.bottomCenter,
// //                 ),
// //                 borderRadius: const BorderRadius.only(
// //                   topRight: Radius.circular(30),
// //                   bottomRight: Radius.circular(30),
// //                 ),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.black.withOpacity(0.3),
// //                     blurRadius: 10,
// //                     offset: const Offset(2, 4),
// //                   ),
// //                 ],
// //               ),
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   _sidebarIcon(AppIcon.searchIcon),
// //                   const SizedBox(height: 25),
// //                   _sidebarIcon(AppIcon.searchIcon),
// //                   const SizedBox(height: 25),
// //                   _sidebarIcon(AppIcon.searchIcon),
// //                   const SizedBox(height: 25),
// //                   _sidebarIcon(AppIcon.searchIcon),
// //                 ],
// //               ),
// //             ),
// //
// //             // -------------------- MAIN CONTENT --------------------
// //             Expanded(
// //               child: BlocProvider(
// //                 create: (context) => DrawerCubit(),
// //                 child: BlocBuilder<DrawerCubit, DrawerState>(
// //                   builder: (context, state) {
// //                     switch (state.runtimeType) {
// //                       case DrawerInitial:
// //                         _lastSelectedItem = (state as DrawerInitial).index;
// //                         break;
// //                       case GetDrawerItemChange:
// //                         _lastSelectedItem = (state as GetDrawerItemChange).index;
// //                         break;
// //                       case OperationsGetDrawerItemChange:
// //                         _opearationsLastSelectedItem =
// //                             (state as OperationsGetDrawerItemChange).index;
// //                         break;
// //                       case PassMgmtGetDrawerItemChange:
// //                         _passlastSelectedItem =
// //                             (state as PassMgmtGetDrawerItemChange).index;
// //                         break;
// //                       default:
// //                         break;
// //                     }
// //
// //                     return ClipRRect(
// //                       borderRadius: const BorderRadius.only(
// //                         topLeft: Radius.circular(30),
// //                         bottomLeft: Radius.circular(30),
// //                       ),
// //                       child: BackdropFilter(
// //                         filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
// //                         child: Container(
// //                           decoration: BoxDecoration(
// //                             color: Colors.white.withOpacity(0.1),
// //                             borderRadius: const BorderRadius.only(
// //                               topLeft: Radius.circular(30),
// //                               bottomLeft: Radius.circular(30),
// //                             ),
// //                             border: Border.all(
// //                               color: Colors.white.withOpacity(0.15),
// //                             ),
// //                           ),
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               // ------------- PROFILE HEADER (FULL WIDTH) -------------
// //                               Container(
// //                                 width: double.infinity,
// //                                 padding: const EdgeInsets.all(16),
// //                                 decoration: BoxDecoration(
// //                                   gradient: LinearGradient(
// //                                     colors: [
// //                                       Colors.white.withOpacity(0.25),
// //                                       Colors.white.withOpacity(0.05),
// //                                     ],
// //                                     begin: Alignment.topLeft,
// //                                     end: Alignment.bottomRight,
// //                                   ),
// //                                   border: Border(
// //                                     bottom: BorderSide(
// //                                       color: Colors.white.withOpacity(0.2),
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 child: Row(
// //                                   children: [
// //                                     const CircleAvatar(
// //                                       radius: 26,
// //                                       backgroundImage: AssetImage(
// //                                           'assets/images/profile.png'),
// //                                     ),
// //                                     const SizedBox(width: 12),
// //                                     Expanded(
// //                                       child: Column(
// //                                         crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                         children: [
// //                                           Text(
// //                                            username ?? '',
// //                                             style: const TextStyle(
// //                                               fontWeight: FontWeight.bold,
// //                                               color: Colors.white,
// //                                               fontSize: 16,
// //                                             ),
// //                                           ),
// //                                           Text(
// //                                            email ?? '',
// //                                             style: const TextStyle(
// //                                               color: Colors.white70,
// //                                               fontSize: 12,
// //                                             ),
// //                                           ),
// //                                         ],
// //                                       ),
// //                                     ),
// //                                     GestureDetector(
// //                                       onTap: () {
// //                                         _menuScaffoldKey.currentState
// //                                             ?.closeDrawer();
// //                                       },
// //                                       child: Container(
// //                                         decoration: BoxDecoration(
// //                                           color:
// //                                           Colors.white.withOpacity(0.2),
// //                                           shape: BoxShape.circle,
// //                                         ),
// //                                         padding: const EdgeInsets.all(4),
// //                                         child: const Icon(
// //                                           Icons.close,
// //                                           color: Colors.white,
// //                                           size: 20,
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //
// //                               // ------------- BODY -------------
// //                               Expanded(
// //                                 child: Container(
// //                                   margin: const EdgeInsets.all(16),
// //                                   padding: const EdgeInsets.all(12),
// //                                   decoration: BoxDecoration(
// //                                     color: Colors.white.withOpacity(0.05),
// //                                     borderRadius: BorderRadius.circular(20),
// //                                     border: Border.all(
// //                                       color: Colors.white.withOpacity(0.15),
// //                                     ),
// //                                     boxShadow: [
// //                                       BoxShadow(
// //                                         color: Colors.black.withOpacity(0.2),
// //                                         blurRadius: 12,
// //                                         offset: const Offset(0, 4),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                   child: ListView(
// //                                     children: [
// //                                       const Text(
// //                                         "Security Functions",
// //                                         style: TextStyle(
// //                                           fontSize: 18,
// //                                           fontWeight: FontWeight.w700,
// //                                           color: Colors.white,
// //                                         ),
// //                                       ),
// //                                       const SizedBox(height: 10),
// //                                       _buildOperationsMenu(context),
// //                                       const SizedBox(height: 25),
// //                                       const Text(
// //                                         "Settings",
// //                                         style: TextStyle(
// //                                           fontSize: 18,
// //                                           fontWeight: FontWeight.w700,
// //                                           color: Colors.white,
// //                                         ),
// //                                       ),
// //                                       const SizedBox(height: 10),
// //                                       ListTile(
// //                                         leading: const Icon(
// //                                           Icons.settings,
// //                                           color: Colors.white70,
// //                                         ),
// //                                         title: const Text(
// //                                           "System Settings",
// //                                           style: TextStyle(color: Colors.white),
// //                                         ),
// //                                         onTap: () {},
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //
// //
// //   Widget _sidebarIcon(String assetName) {
// //     return Container(
// //       padding: const EdgeInsets.all(10),
// //       decoration: const BoxDecoration(
// //         shape: BoxShape.circle,
// //         color: Colors.white24,
// //       ),
// //       child: SvgPicture.asset(
// //         assetName,
// //         height: 22,
// //         color: Colors.white,
// //       ),
// //     );
// //   }
// //
// //   Widget _buildOperationsMenu(BuildContext context) {
// //     return ExpansionTile(
// //       leading: const Icon(Icons.camera_alt_outlined, color: Colors.black54),
// //       title: const Text(
// //         "Operations",
// //         style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
// //       ),
// //       children: [
// //         _menuText("Article Found"),
// //         _menuText("Law Enforcement"),
// //         ExpansionTile(
// //           leading: const Icon(Icons.folder_open, color: Colors.black54),
// //           title: const Text(
// //             "Pass Management",
// //             style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
// //           ),
// //           children: [
// //             _subMenuText("Day Pass Management", selected: true),
// //             _subMenuText("Visitor Pass Management"),
// //             _subMenuText("Vendor Pass Management"),
// //             _subMenuText("Sez Pass Management"),
// //           ],
// //         ),
// //         _menuText("Shift Schedule"),
// //       ],
// //     );
// //   }
// //
// //   Widget _menuText(String title) {
// //     return ListTile(
// //       dense: true,
// //       title: Text(
// //         title,
// //         style: const TextStyle(
// //           color: Colors.black87,
// //           fontWeight: FontWeight.w500,
// //           fontSize: 15,
// //         ),
// //       ),
// //       contentPadding: const EdgeInsets.only(left: 40),
// //     );
// //   }
// //
// //   Widget _subMenuText(String title, {bool selected = false}) {
// //     return Padding(
// //       padding: const EdgeInsets.only(left: 70),
// //       child: Row(
// //         children: [
// //           const Icon(Icons.insert_drive_file_outlined,
// //               size: 16, color: Colors.black45),
// //           const SizedBox(width: 5),
// //           Text(
// //             title,
// //             style: TextStyle(
// //               color: selected ? const Color(0xFFB87333) : Colors.black87,
// //               fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
//


import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/dashboard/navigation_drawer/views/menu_permissions.dart';

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
  late List<MenuItem> costAndBillingExpansionTileDrawerItems = [];
  late List<MenuItem> securitySystemTicketsItems = [];

  Future<void> initializeDrawerItems() async {
    expansionTileDrawerItems = await checkDisplayMenu();
    // costAndBillingExpansionTileDrawerItems = await costBillingDisplayMenu();
    // securitySystemTicketsItems = await securitySystemsDisplayMenu();
  }

  DisplayMenu? displayMenu;

  Future<List<MenuItem>> checkDisplayMenu() async {
    displayMenu = await SharedPrefs.getDisplayMenu();
    bool guardingOperations = ((displayMenu?.gM ?? false) ||
        (displayMenu?.cD ?? false) ||
        (displayMenu?.gR ?? false) ||
        (displayMenu?.oCC ?? false) ||
        (displayMenu?.sVP ?? false) ||
        (displayMenu?.gMR ?? false));

    if (displayMenu == null) {
      return [];
    }
    List<MenuItem> expansionTileDrawerItems = [];
    if (displayMenu?.aps ?? false) {
      expansionTileDrawerItems.add(const MenuItem(
          Constants.annualPowerShutdownListTitle,
          AppIcon.annualPowerShutdownIcon,
          0));
    }
    if (displayMenu?.aF ?? false) {
      expansionTileDrawerItems.add(const MenuItem(
          Constants.articleFoundRegisterListTitle,
          AppIcon.articleFoundRegisterIcon,
          0));
    }
    if (displayMenu?.eP ?? false) {
      expansionTileDrawerItems.add(const MenuItem(
          Constants.eventProtectionList, AppIcon.eventProtectionIcon, 0));
    }

    log('gm -- ${displayMenu?.gM}');
    if (guardingOperations) {
      expansionTileDrawerItems.add(const MenuItem(
          Constants.guardingOperations, AppIcon.guardingOperationIcon, 1));
    }

    if (displayMenu?.iM ?? false) {
      expansionTileDrawerItems.add(const MenuItem(
          Constants.incidentManagementTitle,
          AppIcon.incidentManagementIcon,
          0));
    }
    if (displayMenu?.keyMM ?? false) {
      expansionTileDrawerItems.add(const MenuItem(
          Constants.keyManagementData, AppIcon.keyManagementDataIcon, 1));
    }
    if (displayMenu?.lEO ?? false) {
      expansionTileDrawerItems.add(const MenuItem(
          Constants.lawEnforcementVisitsListTitle,
          AppIcon.lawEnforcementIcon,
          0));
    }

    if (displayMenu?.mM ?? false) {
      expansionTileDrawerItems.add(const MenuItem(
          Constants.materialMovement, AppIcon.materialMovementIcon, 1));
    }
    if (displayMenu?.pM ?? false) {
      expansionTileDrawerItems.add(const MenuItem(
          Constants.passManagement, AppIcon.passManagementIcon, 1));
    }

    if (displayMenu?.sS ?? false) {
      expansionTileDrawerItems.add(
          const MenuItem(shiftSchedulingTitle, AppIcon.eventProtectionIcon, 1));
    }

    if (displayMenu?.vIP ?? false) {
      expansionTileDrawerItems
          .add(const MenuItem(vVipVisitorsTitle, AppIcon.vvipVisitorIcon, 0));
    }

    return expansionTileDrawerItems;
  }

  Future<List<MenuItem>> costBillingDisplayMenu() async {
    displayMenu = await SharedPrefs.getDisplayMenu();
    if (displayMenu == null) {
      return [];
    }
    List<MenuItem> costAndBillingExpansionTileDrawerItems = [];
    if (displayMenu?.gR ?? false) {
      costAndBillingExpansionTileDrawerItems.add(const MenuItem(
          Constants.guardingRates, AppIcon.guardingRatesIcon, 0));
    }
    return costAndBillingExpansionTileDrawerItems;
  }

  Future<List<MenuItem>> securitySystemsDisplayMenu() async {
    displayMenu = await SharedPrefs.getDisplayMenu();
    if (displayMenu == null) {
      return [];
    }
    List<MenuItem> securitySystemTicketsItems = [];
    if (displayMenu?.gR ?? false) {
      securitySystemTicketsItems
          .add(const MenuItem(Constants.incident, AppIcon.incidentIcon, 0));
    }
    return securitySystemTicketsItems;
  }

  final String? username;
  final String? email;
  final GlobalKey<ScaffoldState> _menuScaffoldKey;

  late int _lastSelectedItem = 0;
  late int _opearationsLastSelectedItem = 10;
  late int _passlastSelectedItem = 10;
  late int _securityfunfunctionslastSelectedItem = 10;
  late int _ticketingSystemlastSelectedItem = 1;

  Future<void> getIndeifydrawerIndex() async {
    _lastSelectedItem = await SharedPrefs.getIdentifymenuindex();
  }

  // TODO: Need to define all the Titles here
  static const String operationsTitle = Constants.operations;
  static const String costAndBillingTitle = Constants.costAndBilling;
  static const String shiftSchedulingTitle = Constants.shiftScheduling;
  static const String keyManagementDataTitle = Constants.keyManagementData;
  static const String vVipVisitorsTitle = Constants.vVipVisitorsTitle;
  static const String securitySystemsTitle = Constants.securitySystems;
  static const String ticketingSystemsTitle = Constants.ticketingSystem;

  @override
  Widget build(BuildContext context) {
    // Glassy background gradient and blur
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
      ),
      child: Drawer(
        width: MediaQuery.of(context).size.width,
        elevation: 0,
        child: Stack(
          children: [
            // BACKGROUND GRADIENT
            Container(
              decoration:  BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.newColor,
                    AppColors.newColor,
                    // Color(0xFF0F172A), // deep navy
                    // Color(0xFF071130),
                    //   Color(0xFF111827),
                    //   Color(0xFF111827)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            // FROSTED BLUR LAYER
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14.0, sigmaY: 14.0),
                child: Container(
                  color:AppColors.newColor.withValues(alpha: 0.1),
                ),
              ),
            ),

            // CONTENT
            SafeArea(
              child: BlocProvider(
                create: (context) => DrawerCubit(),
                child: BlocBuilder<DrawerCubit, DrawerState>(
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case DrawerInitial:
                        _lastSelectedItem = (state as DrawerInitial).index;
                        break;
                      case GetDrawerItemChange:
                        _lastSelectedItem =
                            (state as GetDrawerItemChange).index;
                        break;
                      case OperationsGetDrawerItemChange:
                        log('drawer operation ');
                        _opearationsLastSelectedItem =
                            (state as OperationsGetDrawerItemChange).index;
                        break;
                    case SecurityFunctionsGetDrawerItemChange:
                      _securityfunfunctionslastSelectedItem =
                          (state as SecurityFunctionsGetDrawerItemChange)
                              .index;
                      break;
                      case PassMgmtGetDrawerItemChange:
                        _passlastSelectedItem =
                            (state as PassMgmtGetDrawerItemChange).index;
                        break;
                    case TicketingSystemGetDrawerItemChange:
                      _ticketingSystemlastSelectedItem =
                          (state as TicketingSystemGetDrawerItemChange)
                              .index;
                      break;
                      default:
                        break;
                    }

                    return ListView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 5.0),
                      children: <Widget>[
                        // Close icon top-right
                        Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () async {
                                if (_menuScaffoldKey
                                    .currentState!.isDrawerOpen) {
                                  _menuScaffoldKey.currentState!.closeDrawer();
                                } else {
                                  _menuScaffoldKey.currentState!.openDrawer();
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.04),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.white.withValues(alpha: 0.6)),
                                ),
                                child:
                                SvgPicture.asset(AppIcon.closeicon,color: Colors.white),
                              )
                              // child: Row(
                              //   children: [
                              //     //  LEFT BOX — LOGO
                              //     Container(
                              //       padding: const EdgeInsets.all(6),
                              //       decoration: BoxDecoration(
                              //         color: Colors.white.withValues(alpha: 0.04),
                              //         borderRadius: BorderRadius.circular(10),
                              //         border: Border.all(
                              //           color: Colors.white.withValues(alpha: 0.6),
                              //         ),
                              //       ),
                              //       child: Image.asset(
                              //         'assets/images/fedex.png',
                              //         height: 35,
                              //         fit: BoxFit.contain,
                              //       ),
                              //     ),

                                  // Padding(
                                  //   padding: const EdgeInsets.all(0),
                                  //   child: Image.asset(
                                  //     'assets/images/logo1.png',
                                  //     height: 50,
                                  //     // fit: BoxFit.contain,
                                  //   ),
                                  // ),
                                  //
                                  // const Spacer(),

                                  //  RIGHT BOX — CLOSE ICON
                              //     Container(
                              //       padding: const EdgeInsets.all(6),
                              //       decoration: BoxDecoration(
                              //         color: Colors.white.withValues(alpha: 0.04),
                              //         borderRadius: BorderRadius.circular(10),
                              //         border: Border.all(
                              //           color: Colors.white.withValues(alpha: 0.6),
                              //         ),
                              //       ),
                              //       child: SvgPicture.asset(
                              //         AppIcon.closeicon,
                              //         color: Colors.white,
                              //         height: 35,
                              //       ),
                              //     ),
                              //   ],
                              // ),


                            ),

                          ),
                        ),

                        const SizedBox(height: 8),

                        // PROFILE HEADER (glassy card)
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 6),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.newColor7,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: Colors.white.withValues(alpha: 0.1)),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.white.withValues(alpha: 0.4),
                            //     blurRadius: 15,
                            //     offset: const Offset(0, 6),
                            //   ),
                            // ],
                          ),
                          child: Row(
                            children: [
                              // Avatar
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      AppColors.newColor,
                                      AppColors.newColor,
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColors.white
                                            .withValues(alpha: 0.18),
                                        blurRadius: 8,
                                        offset: const Offset(0, 6)),
                                  ],
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Text(
                                    (username?.isNotEmpty ?? false)
                                        ? username!.substring(0, 1).toUpperCase()
                                        : 'U',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 25),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),

                              // Name & Email
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      username ?? '',
                                      style: const TextStyle(
                                        color: AppColors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        fontFamily:
                                        Constants.customFontSemiBoldFamily,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      email ?? '',
                                      style: const TextStyle(
                                        color: AppColors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily:
                                        Constants.customFontSemiBoldFamily,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),

                        // MAIN MENU ITEMS (keeps all logic)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 6),
                          decoration: BoxDecoration(
                            color:   AppColors.newColor3.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: _buildDrawerChildren(context, state),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------- UI helper: glass tile wrapper --------------------
  // Widget _glassyTile({
  //   required Widget child,
  //   bool isSelected = false,
  //   EdgeInsets margin = const EdgeInsets.symmetric(vertical: 4),
  // }) {
  //   // return Container(
  //   //   margin: margin,
  //   //   padding: const EdgeInsets.symmetric(horizontal: 6),
  //   //   decoration: BoxDecoration(
  //   //     color: isSelected
  //   //         ? Color(0xFF071130).withValues(alpha: 0.6)
  //   //         :  const Color(0xFF071130),
  //   //     borderRadius: BorderRadius.circular(12),
  //   //     border: Border.all(
  //   //         color: isSelected
  //   //             ? AppColors.white.withValues(alpha: 0.1)
  //   //             : Colors.white.withValues(alpha: 0.2),
  //   //         width: 1),
  //   //   ),
  //   //   child: child,
  //   // );
  //   return AnimatedContainer(
  //     duration: const Duration(milliseconds: 200),
  //     curve: Curves.easeOutBack,
  //     margin: margin,
  //     padding: const EdgeInsets.symmetric(horizontal: 6),
  //     transform: Matrix4.identity()
  //       ..scale(isSelected ? 1.08 : 1.0), // 🔹 Pop-out animation
  //     decoration: BoxDecoration(
  //       color: isSelected
  //           ? const Color(0xFF071130).withValues(alpha: 0.6)
  //           : const Color(0xFF071130),
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(
  //         color: isSelected
  //             ? AppColors.white.withValues(alpha: 0.1)
  //             : Colors.white.withValues(alpha: 0.2),
  //         width: 1,
  //       ),
  //       boxShadow: isSelected
  //           ? [
  //         BoxShadow(
  //           color: Colors.white.withOpacity(0.15),
  //           blurRadius: 12,
  //           offset: const Offset(0, 4),
  //         ),
  //       ]
  //           : [],
  //     ),
  //     child: child,
  //   );
  //
  // }
  // Widget _glassyTile({
  //   required Widget child,
  //   bool isSelected = false,
  //   EdgeInsets margin = const EdgeInsets.symmetric(vertical: 4),
  // }) {
  //   return StatefulBuilder(
  //     builder: (context, setState) {
  //       bool isHovered = false;
  //
  //       return MouseRegion(
  //         onEnter: (_) => setState(() => isHovered = true),
  //         onExit: (_) => setState(() => isHovered = false),
  //         child: AnimatedContainer(
  //           duration: const Duration(milliseconds: 200),
  //           curve: Curves.easeOutBack,
  //           margin: margin,
  //           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  //           decoration: BoxDecoration(
  //             color: (isHovered || isSelected)
  //                 ? const Color(0xFF0D173D).withOpacity(0.9)
  //                 : const Color(0xFF071130),
  //             borderRadius: BorderRadius.circular(12),
  //             border: Border.all(
  //               color: (isHovered || isSelected)
  //                   ? Colors.white.withOpacity(0.25)
  //                   : Colors.white.withOpacity(0.15),
  //               width: 1,
  //             ),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: (isHovered || isSelected)
  //                     ? Colors.blueAccent.withOpacity(0.25)
  //                     : Colors.transparent,
  //                 blurRadius: 12,
  //                 spreadRadius: 1,
  //                 offset: const Offset(0, 3),
  //               ),
  //             ],
  //           ),
  //           child: AnimatedDefaultTextStyle(
  //             duration: const Duration(milliseconds: 200),
  //             style: TextStyle(
  //               color: (isHovered || isSelected)
  //                   ? Colors.white
  //                   : Colors.white.withOpacity(0.7),
  //               fontWeight: (isHovered || isSelected)
  //                   ? FontWeight.w600
  //                   : FontWeight.w500,
  //             ),
  //             child: AnimatedOpacity(
  //               duration: const Duration(milliseconds: 200),
  //               opacity: (isHovered || isSelected) ? 1.0 : 0.85,
  //               child: child,
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  //
  Widget _glassyTile({
    required Widget child,
    bool isSelected = false,
    EdgeInsets margin = const EdgeInsets.symmetric(vertical: 4),
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            margin: margin,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: (isHovered || isSelected)
                  ? AppColors.newColor
                  : AppColors.newColor,
              borderRadius: BorderRadius.circular(12),

              // 🌟 Highlight border when selected
              border: Border.all(
                color: isSelected
                    ? Colors.white.withOpacity(0.45)
                    : (isHovered
                    ? Colors.white.withOpacity(0.25)
                    : Colors.white.withOpacity(0.45)),
                width: isSelected ? 1.3 : 1.3,
              ),

              // 🌈 Add subtle glowing shadow when selected
              boxShadow: [
                if (isHovered || isSelected)
                  BoxShadow(
                    color: isSelected
                        ? Colors.white.withOpacity(0.25)
                        : Colors.white.withOpacity(0.25),
                    blurRadius: isSelected ? 12 : 12,
                    spreadRadius: isSelected ? 1 : 1,
                    offset: const Offset(0, 3),
                  ),
              ],
            ),

            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                color: (isHovered || isSelected)
                    ? Colors.white
                    : Colors.white.withOpacity(0.7),
                fontWeight:
                (isHovered || isSelected) ? FontWeight.w600 : FontWeight.w500,
              ),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: (isHovered || isSelected) ? 1.0 : 0.85,
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }


  List<Widget> _genericItemSelection(
      BuildContext context,
      List<MenuItem> items,
      String title,
      ) {
    List<Widget> children = [];

    for (int i = 0; i < items.length; i++) {
      MenuItem drawerItem = items[i];
      final bool selected = (i == _passlastSelectedItem);

      children.add(
        _glassyTile(
          isSelected: selected,
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 6),
            leading: SizedBox(
                width: 22,
                height: 22,
                child: Image.asset(drawerItem.imageName,
                    fit: BoxFit.scaleDown,
                    color: (i == _passlastSelectedItem)
                        ? AppColors.white
                        : AppColors.white)),
            title: Text(drawerItem.title,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: Constants.customFontSemiBoldFamily,
                    fontWeight: FontWeight.w600,
                    color: (i == _passlastSelectedItem)
                        ? AppColors.white
                        : AppColors.white)),
            onTap: () {
              switch (title) {
              /// 2nd Level Menu
                case Constants.materialMovement:
                  _onMaterialMovementItemSelected(i, context);
                  break;
                case Constants.passManagement:
                  _onPassMgmtSelectItem(i, context);
                  break;
              case Constants.sCRI:
                _onSCRIItemSelected(i, context);
                break;
              case Constants.securityFunctions:
                _onSecurityFunctionsItemSelected(i, context);
                break;

              case Constants.ticketingSystem:
                _onTicketingSystemItemSelected(i, context);
                break;

              /// 3nd Level Menu
                case Constants.guardingOperations:
                  _onGuardingOperationItemSelected(i, context, drawerItem);
                  break;
                case operationsTitle:
                  buildDrawerChildren(context, drawerItem.title);
                  break;

              case Constants.costAndBilling:
                _onCostAndBillingItemSelected(i, context);
                break;

              case Constants.securitySystems:
                _onSecuritySystemIncidentItemSelected(i, context);
                break;

              case Constants.keyManagementData:
                _onKeyManagementItemSelected(
                  i,
                  context,
                );
                break;

              case shiftSchedulingTitle:
                _onShiftScheduleItemSelected(i, context);
                break;
              default:
                _onSecuritySystemIncidentItemSelected(i, context);
              // Default case if title doesn't match any specific condition
              }
            },
          ),
        ),
      );
    }

    return children;
  }

  _onMaterialMovementItemSelected(int index, BuildContext context) async {
    // _menuScaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
          arguments: {"isInward": true});
    } else if (index == 1) {
      Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
          arguments: {
            "isInward": false, "returnable": true,
          });
    } else if (index == 2) {
      Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
          arguments: {"isInward": false, "returnable": false});
    }
  }

  _onSCRIItemSelected(int index, BuildContext context) async {
    // _menuScaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(
        context,
        vipVisitorsListRoute,
      );
    }
  }

  _onSecurityFunctionsItemSelected(int index, BuildContext context) async {
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(
        context,
        sstIncidentListRoute,
      );
    }
  }

  _onTicketingSystemItemSelected(int index, BuildContext context) async {
    _ticketingSystemlastSelectedItem = index;
    context.read<DrawerCubit>().getTicketingSystemIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(
        context,
        ticketingSystemListRoute,
      );
    }
  }

  _onSecuritySystemIncidentItemSelected(int index, BuildContext context) async {
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, sstIncidentListRoute,
          arguments: {"isInternal": true});
    }
  }

  _onKeyManagementItemSelected(int index, BuildContext context) async {
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

  _onShiftScheduleItemSelected(int index, BuildContext context) async {
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
      default:
        break;
    }
  }

  _onCostAndBillingItemSelected(int index, BuildContext context) async {
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, guardingRatesRoute);
    }
  }

  // TODO: Fix the Drawer Index
  _onGuardingOperationItemSelected(
      int index, BuildContext context, MenuItem item) async {
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);

    log('--item.title--${item.title}--');

    switch (item.title) {
      case Constants.escalationMatrix:
        Navigator.pushNamed(context, contactDetailsListRoute);
        break;
      case Constants.guardingMasterData:
        Navigator.pushNamed(context, guardingMasterDataRoute);
        break;
      case Constants.guardingMasterReport:
        log('--Constants.guardingMasterReportTitle--${item.title}--');
        return Navigator.pushNamed(context, guardingMasterReportRoute);
      case Constants.shiftOccurrence:
        Navigator.pushNamed(context, shiftOccurrenceRoute);
        break;
      case Constants.slaViolationPenaltyTitle:
        Navigator.pushNamed(context, slaViolationPenaltyListRoute);
        break;
      default:
        break;
    }
  }

  List<Widget> _buildDrawerChildren(BuildContext context, DrawerState state) {
    List<Widget> children = [];

    for (int i = 0; i < mainDrawerItems.length; i++) {
      MenuItem drawerItem = mainDrawerItems[i];
      children.add(
        drawerItem.numberOfChildren == 0
            ? _glassyTile(
          isSelected: (i == _lastSelectedItem),
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 6),
            leading: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(drawerItem.imageName,
                    fit: BoxFit.cover,
                    color: (i == _lastSelectedItem)
                        ? AppColors.white
                        : AppColors.white)),
            title: Text(drawerItem.title,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: Constants.customFontSemiBoldFamily,
                    fontWeight: FontWeight.w600,
                    color: (i == _lastSelectedItem)
                        ? AppColors.white
                        : AppColors.white)),
            onTap: () => _onSelectItem(
              i,
              context,
            ),
          ),
        )
            : Theme(
          data: Theme.of(context)
              .copyWith(dividerColor: Colors.transparent),
          child: _glassyTile(
            child: ExpansionTile(
                onExpansionChanged: (value) {
                  if (value == true) {
                    _lastSelectedItem = i;
                    context
                        .read<DrawerCubit>()
                        .getIndexChange(_lastSelectedItem);
                  } else {
                    _securityfunfunctionslastSelectedItem = 10;
                    context
                        .read<DrawerCubit>()
                        .getSecurityIndexChange(10);
                  }
                },
                trailing: const Icon(Icons.arrow_drop_down_rounded, color: Colors.white,),
                title: Text(
                  drawerItem.title,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: Constants.customFontSemiBoldFamily,
                      fontWeight: FontWeight.w600,
                      color: (i == _lastSelectedItem)
                          ? AppColors.white
                          : AppColors.white),
                ),
                leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: Image.asset(drawerItem.imageName,
                        fit: BoxFit.cover,
                        color: (i == _lastSelectedItem)
                            ? AppColors.white
                            : AppColors.white)),
                childrenPadding: const EdgeInsets.only(left: 18),
                //children padding
                children: drawerItem.title == Constants.securityFunctions
                    ? _buildOperationsFromSecurity(context, state)
                    : _buildTicketingSystemFromSecurity(context, state)),
          ),
        ),
      );
    }

    return children;
  }

  List<Widget> _buildOperationsFromSecurity(
      BuildContext context, DrawerState state) {
    List<Widget> children = [];

    List<MenuItem> menuItems = [];
    menuItems
        .add(const MenuItem(Constants.operations, AppIcon.operationsIcon, 1));
    // if (displayMenu?.gR ?? false) {
    //   menuItems.add(
    //       const MenuItem(Constants.costAndBilling, AppIcon.costBillingIcon, 1));
    // }
    // if (displayMenu?.sSSLA ?? false) {
    //   menuItems.add(const MenuItem(
    //       Constants.securitySystems, AppIcon.securitySystemIcon, 1));
    // }

    for (int i = 0; i < menuItems.length; i++) {
      MenuItem drawerItem = menuItems[i];
      children.add(
        drawerItem.numberOfChildren == 0
            ? _glassyTile(
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 6),
            leading: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(
                  drawerItem.imageName,
                  //fit: BoxFit.cover,
                  color: (i == _securityfunfunctionslastSelectedItem)
                      ? AppColors.white
                      : AppColors.white,
                )),
            title: Text(drawerItem.title,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: Constants.customFontSemiBoldFamily,
                    fontWeight: FontWeight.w600,
                    color: (i == _securityfunfunctionslastSelectedItem)
                        ? AppColors.white
                        : AppColors.white)),
            onTap: () => _onSecurityExpansionSelectItem(i, context),
          ),
        )
            : Theme(
          data: Theme.of(context)
              .copyWith(dividerColor: Colors.transparent),
          child: _glassyTile(
            child: ExpansionTile(
              onExpansionChanged: (value) {
                if (value == true) {
                  _securityfunfunctionslastSelectedItem = i;
                  context.read<DrawerCubit>().getSecurityIndexChange(
                      _securityfunfunctionslastSelectedItem);
                } else {
                  _securityfunfunctionslastSelectedItem = 10;
                  context.read<DrawerCubit>().getSecurityIndexChange(
                      _securityfunfunctionslastSelectedItem);
                }
              },
              trailing: const Icon(Icons.arrow_drop_down_rounded, color: Colors.white,),
              title: Text(
                drawerItem.title,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: Constants.customFontSemiBoldFamily,
                    fontWeight: FontWeight.w600,
                    color: (i == _lastSelectedItem)
                        ? AppColors.white
                        : AppColors.white),
              ),
              leading: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(
                    i == 0
                        ? AppIcon.operationsIcon
                        : i == 1
                        ? AppIcon.costBillingIcon
                        : AppIcon.securitySystemIcon,
                    fit: BoxFit.cover,
                    color: (i == _lastSelectedItem)
                        ? AppColors.white
                        : AppColors.white),
              ),
              childrenPadding: const EdgeInsets.only(left: 20),
              children: selectedChild(drawerItem, context),
            ),
          ),
        ),
      );
    }

    return children;
  }

  List<Widget> _buildTicketingSystemFromSecurity(
      BuildContext context, DrawerState state) {
    List<Widget> children = [];

    List<MenuItem> menuItems = [];
    menuItems.add(const MenuItem(Constants.tickets, AppIcon.ticketsIcon, 1));

    for (int i = 0; i < menuItems.length; i++) {
      MenuItem drawerItem = menuItems[i];
      children.add(
        _glassyTile(
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 6),
            leading: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(
                  drawerItem.imageName,
                  //fit: BoxFit.cover,
                  color: (i == _ticketingSystemlastSelectedItem)
                      ? AppColors.white
                      : AppColors.white,
                )),
            title: Text(drawerItem.title,
                //style: Styles.textStyleBlack16,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: Constants.customFontSemiBoldFamily,
                    fontWeight: FontWeight.w600,
                    color: (i == _ticketingSystemlastSelectedItem)
                        ? AppColors.white
                        : AppColors.white)),
            onTap: () => _onTicketingSystemItemSelected(i, context),
          ),
        ),
      );
    }

    return children;
  }

  List<Widget> selectedChild(MenuItem drawerItem, BuildContext context) {
    switch (drawerItem.title) {
      case operationsTitle:
        return _genericItemExpandable(
          context,
          expansionTileDrawerItems,
          operationsTitle,
        );

      case Constants.costAndBilling:
        return _genericItemExpandable(
          context,
          costAndBillingExpansionTileDrawerItems,
          Constants.costAndBilling,
        );

      case Constants.securitySystems:
        return _genericItemExpandable(
          context,
          securitySystemTicketsItems,
          Constants.securitySystems,
        );
      case ticketingSystemsTitle:
        return _genericItemExpandable(
          context,
          expansionTileDrawerItems,
          ticketingSystemsTitle,
        );
      default:
        return [];
    }
  }

  List<Widget> _genericItemExpandable(
      BuildContext context,
      List<MenuItem> items,
      String title,
      ) {
    List<Widget> children = [];

    for (int i = 0; i < items.length; i++) {
      MenuItem drawerItem = items[i];
      // log('--drawerItem-title-${drawerItem.title}--');
      children.add(
        drawerItem.numberOfChildren == 0
            ? _glassyTile(
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 6),
            leading: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(drawerItem.imageName,
                    fit: BoxFit.cover,
                    color: (i == _opearationsLastSelectedItem)
                        ? AppColors.white
                        : AppColors.white)),
            title: Text(drawerItem.title,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: Constants.customFontSemiBoldFamily,
                    fontWeight: FontWeight.w600,
                    color: (i == _opearationsLastSelectedItem)
                        ? AppColors.white
                        : AppColors.white)),
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
              if (title == Constants.costAndBilling) {
                _onCostAndBillingItemSelected(i, context);
                return;
              }

              log('--title-$title-');
              if (title == Constants.securitySystems) {
                _onSecuritySystemIncidentItemSelected(i, context);
                return;
              }

              _onExpansionSelectItem(i, context, drawerItem);
            },
          ),
        )
            : Theme(
          data: Theme.of(context)
              .copyWith(dividerColor: Colors.transparent),
          child: _glassyTile(
            child: ExpansionTile(
              onExpansionChanged: (value) {
                if (value == true) {
                  _opearationsLastSelectedItem = i;
                  context.read<DrawerCubit>().getOperationsIndexChange(
                      _opearationsLastSelectedItem);
                } else {
                  _opearationsLastSelectedItem = 10;
                  context
                      .read<DrawerCubit>()
                      .getOperationsIndexChange(10);
                }
              },
              trailing: const Icon(Icons.arrow_drop_down_rounded, color: Colors.white),
              title: Text(
                drawerItem.title,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: Constants.customFontSemiBoldFamily,
                    fontWeight: FontWeight.w600,
                    color: (i == _opearationsLastSelectedItem)
                        ? AppColors.white
                        : AppColors.white),
                // style: Styles.textStyleBlack16,
              ),
              leading: SizedBox(
                width: 18,
                height: 18,
                child: Image.asset(drawerItem.imageName,
                    fit: BoxFit.fitHeight,
                    color: (i == _opearationsLastSelectedItem)
                        ? AppColors.white
                        : AppColors.white),
              ),
              childrenPadding: const EdgeInsets.only(left: 20),
              //children padding
              children: buildDrawerChildren(context, drawerItem.title),
            ),
          ),
        ),
      );
    }

    return children;
  }

  _onExpansionSelectItem(int index, BuildContext context, MenuItem item) async {
    _opearationsLastSelectedItem = index;
    context.read<DrawerCubit>().getOperationsIndexChange(index);

    switch (item.title) {
      case Constants.annualPowerShutdownListTitle:
        Navigator.pushNamed(context, annualPowerShutdownListRoute);
        break;
      case Constants.articleFoundRegisterListTitle:
        Navigator.pushNamed(context, articleFoundNewListRoute);
        break;
      case Constants.eventProtectionList:
        Navigator.pushNamed(context, eventProtectionListRoute);
        break;
      case Constants.incidentManagementTitle:
        Navigator.pushNamed(context, incidentManagementsRoute);
        break;
      case Constants.lawEnforcementVisitsListTitle:
        Navigator.pushNamed(context, lawEnforcementNewListRoute);
        break;
      case Constants.vVipVisitorsTitle:
        Navigator.pushNamed(context, vipVisitorsListRoute);
        break;

      default:
        break;
    }
  }

  _onPassMgmtSelectItem(int index, BuildContext context) async {
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);
    switch (index) {
      case 0:
        log('day pass management index0');
        Navigator.pushNamed(context, dayPassManagementListRoute, arguments: {
          "passMngDetails": PassMngArguments(0, 'Day Pass Management', false)
        });
        break;
      case 1:
        log('day pass registry index1');
        Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
          "passMngRegisterDetails":
          PassMngArguments(0, 'Day Pass Register', true)
        });
        break;
      case 2:
        log('Sez pass Management index6');
        Navigator.pushNamed(context, sezPassManagementListRoute, arguments: {
          "passMngDetails": PassMngArguments(3, 'Sez Pass Management', false)
        });
        break;
      case 3:
        log('Sez pass registry index7');
        Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
          "passMngRegisterDetails":
          PassMngArguments(3, 'Sez Pass Register', true)
        });
        break;
      case 4:
        log('vendor pass management index4');
        Navigator.pushNamed(context, vendorPassManagementListRoute, arguments: {
          "passMngDetails": PassMngArguments(2, 'Vendor Pass Management', false)
        });
        break;
      case 5:
        log('vendor pass registry index5');
        Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
          "passMngRegisterDetails":
          PassMngArguments(2, 'Vendor Pass Register', true)
        });
        break;
      case 6:
        log('visitor pass management index2');
        Navigator.pushNamed(context, visitorPassManagementListRoute, arguments: {
          "passMngDetails":
          PassMngArguments(1, 'Visitor Pass Management', false)
        });
        break;
      case 7:
        log('visitor pass registry index3');
        Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
          "passMngRegisterDetails":
          PassMngArguments(1, 'Visitor Pass Register', true)
        });
        break;
      default:
        break;
    }
  }

  _onSecurityExpansionSelectItem(int index, BuildContext context) async {
    // _menuScaffoldKey.currentState!.closeDrawer();
    _securityfunfunctionslastSelectedItem = index;
    context.read<DrawerCubit>().getSecurityIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, sstIncidentListRoute);
    }
  }

  _onSelectItem(
      int index,
      BuildContext context,
      ) async {
    if (index != 5) {}
    _lastSelectedItem = index;

    context.read<DrawerCubit>().getIndexChange(index);
    if (index != 2) {
      _opearationsLastSelectedItem = 10;
    }
    if (index == 0) {
    } else if (index == 1) {
    } else if (index == 3) {
      Navigator.pushNamed(
        context,
        resetPwdScreenRoute,
        arguments: {'viaNavigationDrawer': true},
      );
    } else if (index == 4) {}
  }

  List<Widget> buildDrawerChildren(
      BuildContext context,
      String title,
      ) {
    // log('--title---$title--');
    switch (title) {
      case Constants.materialMovement:
        return _genericItemSelection(
            context, materialMovementDrawerItemsWithReturnable, title);
      case Constants.guardingOperations:
        List<MenuItem> menuItems = [];
        checkMenuPermissionsGuardingOperations(displayMenu, menuItems);
        return _genericItemExpandable(
          context,
          menuItems,
          Constants.guardingOperations,
        );
      case Constants.keyManagementData:
        List<MenuItem> menuItems = [];

        MenuPermissions()
            .checkMenuPermissionsKeyManagementData(displayMenu, menuItems);
        return _genericItemExpandable(
          context,
          menuItems,
          Constants.keyManagementData,
        );

      case shiftSchedulingTitle:
        List<MenuItem> menuItems = [];

        MenuPermissions()
            .checkMenuPermissionsShiftSchedule(displayMenu, menuItems);
        return _genericItemExpandable(
          context,
          menuItems,
          Constants.shiftSchedule,
        );

      case Constants.passManagement:
        return _genericItemSelection(
          context,
          passTileDrawerItems,
          title,
        );
      case Constants.sCRI:
        return _genericItemSelection(
          context,
          sCRIItems,
          title,
        );
      default:
        log('-buildDrawerChildren-----else-----title--$title--');
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
    if (displayMenu?.sVP ?? false) {
      menuItems.add(const MenuItem(Constants.slaViolationPenaltyTitle,
          AppIcon.slaViolationPenaltyIcon, 0));
    }
  }
}


