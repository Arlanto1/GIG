import 'dart:developer';

import 'package:db_atom/index.dart';

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

  Future<void> initializeDrawerItems() async {
    expansionTileDrawerItems = await checkDisplayMenu();
  }

  Future<List<MenuItem>> checkDisplayMenu() async {
    DisplayMenu? displayMenu = await SharedPrefs.getDisplayMenu();
    if (displayMenu == null) {
      return [];
    }
    List<MenuItem> expansionTileDrawerItems = [];
    if (displayMenu.aF ?? false) {
      expansionTileDrawerItems.add(const MenuItem(
          Constants.articlefoundregister, AppIcon.clipboardImage, 0));
    }
    if (displayMenu.lEO ?? false) {
      expansionTileDrawerItems.add(const MenuItem(
          Constants.lawenforcementvisitslist, AppIcon.lawenforcement, 0));
    }
    if (displayMenu.eP ?? false) {
      expansionTileDrawerItems.add(
          const MenuItem(Constants.eventprotectionlist, AppIcon.tasklist, 0));
    }
    if (displayMenu.aps ?? false) {
      expansionTileDrawerItems.add(const MenuItem(
          Constants.annualPowerShutdownList, AppIcon.tasklist, 0));
    }
    if (displayMenu.iM ?? false) {
      expansionTileDrawerItems.add(const MenuItem(
          Constants.incidentManagement, AppIcon.materialMovement, 0));
    }
    if (displayMenu.mM ?? false) {
      expansionTileDrawerItems.add(const MenuItem(
          Constants.materialMovement, AppIcon.materialMovement, 1));
    }
    if (displayMenu.pM ?? false) {
      expansionTileDrawerItems.add(
          const MenuItem(Constants.passmanagement, AppIcon.passmanagement, 1));
    }
    if (displayMenu.gM ?? false) {
      expansionTileDrawerItems.add(
          const MenuItem(Constants.guarding, AppIcon.guardingOperationIcon, 1));
    }
    return expansionTileDrawerItems;
  }

  final String? username;
  final String? email;
  final GlobalKey<ScaffoldState> _menuScaffoldKey;
  final mainDrawerItems = [
    const MenuItem(Constants.dashboard, AppIcon.dashboardselect, 0),
    const MenuItem(Constants.securityFunctions, AppIcon.securityprotection, 1),
    //  const MenuItem(Constants.administration, AppIcon.maninsuitandtie, 0),
    //const MenuItem(Constants.settings, AppIcon.settings, 0),
    const MenuItem(Constants.logout, AppIcon.logout, 0),
  ];
  final securityItems = [
    const MenuItem(Constants.operations, AppIcon.operatingsystem, 1),
    const MenuItem(Constants.securitySystems, AppIcon.operatingsystem, 1),
  ];

  final securitySystemExpansionTileDrawerItems = [
    const MenuItem(Constants.securitySystemsTickets, AppIcon.clipboardImage, 1),
  ];

  final materialMovementDrawerItems = [
    const MenuItem(Constants.materialMovementInward,
        AppIcon.materialMovementInwardIcon, 0),
    const MenuItem(Constants.materialMovementOutward,
        AppIcon.materialMovementOutwardIcon, 0),
  ];

  final securitySystemTicketsItems = [
    const MenuItem(Constants.incident, AppIcon.materialMovementOutwardIcon, 1),
  ];
  final securitySystemTicketsIncidentItems = [
    const MenuItem(
        Constants.ticketLifeCycle, AppIcon.materialMovementOutwardIcon, 0),
    const MenuItem(
        Constants.externalVendor, AppIcon.materialMovementOutwardIcon, 0),
  ];

  final guardingOperationDrawerItems = [
    const MenuItem(
        Constants.guardingMasterData, AppIcon.guardingMasterDataIcon, 0),
    const MenuItem(
        Constants.guardingMasterReport, AppIcon.guardingMasterReportIcon, 0),
    const MenuItem(Constants.guardingRate, AppIcon.guardingMasterRatesIcon, 0),
    //const MenuItem(Constants.femaleDropPickUp, AppIcon.femalePickUpDropIcon, 0),
    const MenuItem(
        Constants.keyManagementMaster, AppIcon.keyManagementListIcon, 1),
    const MenuItem(Constants.occurrence, AppIcon.occurence, 0),
    const MenuItem(Constants.slaViolationPenalty, AppIcon.occurence, 0),
    const MenuItem(
        Constants.contactDetails, AppIcon.guardingMasterRatesIcon, 0),
    const MenuItem(
        Constants.keyReconciliationList, AppIcon.keyManagementListIcon, 0),
    const MenuItem(
        Constants.keyLossDestructionList, AppIcon.keyManagementListIcon, 0),
    const MenuItem(
        Constants.keyManagementIssuance, AppIcon.keyManagementListIcon, 0),
    const MenuItem(Constants.dutyPostMaster, AppIcon.keyManagementListIcon, 0),
    const MenuItem(
        Constants.dutyPostNameMaster, AppIcon.keyManagementListIcon, 0),
    const MenuItem(Constants.attendance, AppIcon.keyManagementListIcon, 0),
    const MenuItem(Constants.shiftSchedule, AppIcon.keyManagementListIcon, 0)
  ];

  final keyManagementDataItems = [
    const MenuItem(
        Constants.keyManagementMaster, AppIcon.guardingMasterDataIcon, 0),
    const MenuItem(
        Constants.keyManagementIssuance, AppIcon.guardingMasterReportIcon, 0),
    const MenuItem(
        Constants.keyReconciliationList, AppIcon.guardingMasterRatesIcon, 0),
    const MenuItem(
        Constants.keyLossDestructionList, AppIcon.femalePickUpDropIcon, 0),
  ];

  final passTileDrawerItems = [
    const MenuItem(Constants.daypassmgmt, AppIcon.daypassmgmticon, 0),
    const MenuItem(Constants.daypassregister, AppIcon.daypassregicon, 0),
    const MenuItem(Constants.visitorpassmgmt, AppIcon.visitorpassmgmticon, 0),
    const MenuItem(
        Constants.visitorpassregister, AppIcon.visitorpassregicon, 0),
    const MenuItem(Constants.vendorpassmgmt, AppIcon.vendorpassmgmticon, 0),
    const MenuItem(Constants.vendorpassregister, AppIcon.vendorpassregicon, 0),
    const MenuItem(Constants.sezpassmgmt, AppIcon.sezpassmgmticon, 0),
    const MenuItem(Constants.sezpassregister, AppIcon.segpassregicon, 0),
  ];

  late int _lastSelectedItem = 0;
  late int _opearationsLastSelectedItem = 10;
  late int _passlastSelectedItem = 10;
  late int _securityfunfunctionslastSelectedItem = 10;

  Future<void> getIndeifydrawerIndex() async {
    _lastSelectedItem = await SharedPrefs.getIdentifymenuindex();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: AppColors
            .backgroundWhitecolor, //This will change the drawer background to blue.
        //other styles
      ),
      child: Drawer(
        child: BlocProvider(
          create: (context) => DrawerCubit(),
          child: BlocBuilder<DrawerCubit, DrawerState>(
            builder: (context, state) {
              if (state is DrawerInitial) {
                // getIndeifydrawerIndex();
                _lastSelectedItem = state.index;
              } else if (state is GetDrawerItemChange) {
                _lastSelectedItem = state.index;
              } else if (state is OperationsGetDrawerItemChange) {
                log('drawer operation ');
                _opearationsLastSelectedItem = state.index;
              } else if (state is SecurityFunctionsGetDrawerItemChange) {
                _securityfunfunctionslastSelectedItem = state.index;
              } else if (state is PassMgmtGetDrawerItemChange) {
                _passlastSelectedItem = state.index;
              }

              return ListView(
                children: <Widget>[
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                                onTap: () async {
                                  if (_menuScaffoldKey
                                      .currentState!.isDrawerOpen) {
                                    _menuScaffoldKey.currentState!
                                        .closeDrawer();
                                    //close drawer, if drawer is open
                                  } else {
                                    _menuScaffoldKey.currentState!.openDrawer();
                                    //open drawer, if drawer is closed
                                  }
                                },
                                child: SvgPicture.asset(
                                    AppIcon.closeicon) //Icon(Icons.cancel)
                                // const Icon(
                                //   Icons.cancel,
                                // ),
                                )),
                      ),
                      createDrawerHeader(username, email, context),
                      Column(
                        children: _buildDrawerChildren(context, state),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    ); //
  }

  List<Widget> _genericExpandableDrawer(
    BuildContext context,
    List items,
    String title,
  ) {
    List<Widget> children = [];

    for (int i = 0; i < items.length; i++) {
      MenuItem drawerItem = items[i];
      children.add(
        Container(
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppColors.dividelineGreycolor)),
          ),
          child: ListTile(
            leading: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(drawerItem.imageName,
                    fit: BoxFit.scaleDown,
                    color: (i == _passlastSelectedItem)
                        ? AppColors.navigationSkybluecolor
                        : AppColors.boldgreyBackground)),
            title: Text(drawerItem.title,
                //style: Styles.textStyleBlack16,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: Constants.customFontSemiBoldFamily,
                    fontWeight: FontWeight.w600,
                    color: (i == _passlastSelectedItem)
                        ? AppColors.navigationSkybluecolor
                        : AppColors.textgreyThemecolor)),
            //selected: i == _lastSelectedItem,
            onTap: () {
              switch (title) {
                /// 2nd Level Menu
                case Constants.materialMovement:
                  _onMaterialMovementItemSelected(i, context);
                  break;
                case Constants.passmanagement:
                  _onPassMgmtSelectItem(i, context);
                  break;

                /// 3nd Level Menu
                case Constants.guarding:
                  _onGuardingOperationItemSelected(
                    i,
                    context,
                  );
                  break;
                case Constants.securitySystemsTickets:
                  _onSecuritySystemIncidentItemSelected(i, context);
                  break;

                case Constants.securitySystemsTickets:
                  _buildDrawerChildrenIncidentChild(
                    context,
                    securitySystemTicketsItems,
                  );
                  break;
                // Add more cases for other titles as needed
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
    _menuScaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
          arguments: {"isInward": true});
    } else if (index == 1) {
      Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
          arguments: {"isInward": false});
    }
  }

  List<Widget> _keyManagementDataBuildDrawerChildren(
      BuildContext context, DrawerState state) {
    List<Widget> children = [];

    for (int i = 0; i < keyManagementDataItems.length; i++) {
      MenuItem drawerItem = keyManagementDataItems[i];
      children.add(
        Container(
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppColors.dividelineGreycolor)),
          ),
          child: ListTile(
            leading: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(drawerItem.imageName,
                    fit: BoxFit.scaleDown,
                    color: (i == _passlastSelectedItem)
                        ? AppColors.navigationSkybluecolor
                        : AppColors.boldgreyBackground)),
            title: Text(drawerItem.title,
                //style: Styles.textStyleBlack16,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: Constants.customFontSemiBoldFamily,
                    fontWeight: FontWeight.w600,
                    color: (i == _passlastSelectedItem)
                        ? AppColors.navigationSkybluecolor
                        : AppColors.textgreyThemecolor)),
            //selected: i == _lastSelectedItem,
            onTap: () => _onKeyManagementDataItemSelected(i, context),
          ),
        ),
      );
    }
    return children;
  }

  List<Widget> _buildDrawerChildrenIncident(
    BuildContext context,
    List items,
  ) {
    List<Widget> children = [];
    for (int i = 0; i < items.length; i++) {
      MenuItem drawerItem = items[i];
      children.add(
        drawerItem.numberOfChildren == 0
            ? Container(
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: AppColors.dividelineGreycolor)),
                ),
                child: ListTile(
                  leading: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(drawerItem.imageName,
                          fit: BoxFit.cover,
                          color: (i == _lastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor)),
                  title: Text(drawerItem.title,
                      //style: Styles.textStyleBlack16,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: Constants.customFontSemiBoldFamily,
                          fontWeight: FontWeight.w600,
                          color: (i == _lastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor)),
                  //selected: i == _lastSelectedItem,
                  onTap: () => _onSelectItem(
                    i,
                    context,
                  ),
                ),
              )
            : Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: AppColors.dividelineGreycolor)),
                  ),
                  child: ExpansionTile(
                    onExpansionChanged: (value) {
                      if (value == true) {
                        _lastSelectedItem = i;
                        context
                            .read<DrawerCubit>()
                            .getIndexChange(_lastSelectedItem);
                      } else {
                        _securityfunfunctionslastSelectedItem = 10;
                        context.read<DrawerCubit>().getSecurityIndexChange(10);
                      }
                    },
                    trailing: const SizedBox.shrink(),
                    title: Text(
                      Constants.securityFunctions,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: Constants.customFontSemiBoldFamily,
                          fontWeight: FontWeight.w600,
                          color: (i == _lastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor),
                      // style: Styles.textStyleBlack16,
                    ),
                    leading: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(AppIcon.securityprotection,
                            fit: BoxFit.cover,
                            color: (i == _lastSelectedItem)
                                ? AppColors.navigationSkybluecolor
                                : AppColors.textgreyThemecolor)),
                    childrenPadding: const EdgeInsets.only(left: 20),
                    //children padding
                    children: _buildDrawerChildrenIncidentChild(
                      context,
                      securitySystemTicketsItems,
                    ),
                  ),
                ),
              ),
      );
    }

    return children;
  }

  List<Widget> _buildDrawerChildrenIncidentChild(
      BuildContext context, List items) {
    List<Widget> children = [];

    for (int i = 0; i < items.length; i++) {
      MenuItem drawerItem = items[i];
      log('-_buildDrawerChildren-----drawerItem.title- ${drawerItem.title}--');

      children.add(
        drawerItem.numberOfChildren == 0
            ? Container(
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: AppColors.dividelineGreycolor)),
                ),
                child: ListTile(
                  leading: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(drawerItem.imageName,
                          fit: BoxFit.cover,
                          color: (i == _lastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor)),
                  title: Text(drawerItem.title,
                      //style: Styles.textStyleBlack16,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: Constants.customFontSemiBoldFamily,
                          fontWeight: FontWeight.w600,
                          color: (i == _lastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor)),
                  //selected: i == _lastSelectedItem,
                  onTap: () => _onSelectItem(
                    i,
                    context,
                  ),
                ),
              )
            : Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: AppColors.dividelineGreycolor)),
                  ),
                  child: ExpansionTile(
                    onExpansionChanged: (value) {
                      if (value == true) {
                        _lastSelectedItem = i;
                        context
                            .read<DrawerCubit>()
                            .getIndexChange(_lastSelectedItem);
                      } else {
                        _securityfunfunctionslastSelectedItem = 10;
                        context.read<DrawerCubit>().getSecurityIndexChange(10);
                      }
                    },
                    trailing: const SizedBox.shrink(),
                    title: Text(
                      drawerItem.title,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: Constants.customFontSemiBoldFamily,
                          fontWeight: FontWeight.w600,
                          color: (i == _lastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor),
                      // style: Styles.textStyleBlack16,
                    ),
                    leading: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(AppIcon.securityprotection,
                            fit: BoxFit.cover,
                            color: (i == _lastSelectedItem)
                                ? AppColors.navigationSkybluecolor
                                : AppColors.textgreyThemecolor)),
                    childrenPadding: const EdgeInsets.only(left: 20),
                    //children padding
                    children: _genericExpandableDrawer(
                      context,
                      securitySystemTicketsIncidentItems,
                      Constants.incident,
                    ),
                  ),
                ),
              ),
      );
    }

    return children;
  }

  // List<Widget> _genericBuildDrawerChildren(
  //   BuildContext context,
  //   List items,
  //   String title,
  // ) {
  //   List<Widget> children = [];
  //
  //   for (int i = 0; i < items.length; i++) {
  //     MenuItem drawerItem = items[i];
  //
  //     children.add(
  //       Container(
  //         decoration: const BoxDecoration(
  //           border: Border(
  //               bottom: BorderSide(color: AppColors.dividelineGreycolor)),
  //         ),
  //         child: ListTile(
  //           leading: SizedBox(
  //               width: 20,
  //               height: 20,
  //               child: Image.asset(drawerItem.imageName,
  //                   fit: BoxFit.scaleDown,
  //                   color: (i == _passlastSelectedItem)
  //                       ? AppColors.navigationSkybluecolor
  //                       : AppColors.boldgreyBackground)),
  //           title: Text(drawerItem.title,
  //               //style: Styles.textStyleBlack16,
  //               style: TextStyle(
  //                   fontSize: 16,
  //                   fontFamily: Constants.customFontSemiBoldFamily,
  //                   fontWeight: FontWeight.w600,
  //                   color: (i == _passlastSelectedItem)
  //                       ? AppColors.navigationSkybluecolor
  //                       : AppColors.textgreyThemecolor)),
  //           onTap: () {
  //             switch (title) {
  //               case Constants.guarding:
  //                 _onGuardingOperationItemSelected(
  //                   i,
  //                   context,
  //                 );
  //                 break;
  //               case Constants.securitySystemsTickets:
  //                 _onSecuritySystemIncidentItemSelected(i, context);
  //                 break;
  //               // Add more cases for other conditions as needed
  //               default:
  //                 _onSecuritySystemIncidentItemSelected(i, context);
  //             }
  //           },
  //         ),
  //       ),
  //     );
  //   }
  //   return children;
  // }

  _onSecuritySystemIncidentItemSelected(int index, BuildContext context) async {
    _menuScaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, sstIncidentListRoute,
          arguments: {"isInternal": true});
    } else if (index == 1) {
      Navigator.pushNamed(context, sstIncidentListRoute,
          arguments: {"isInternal": false});
    }
  }

  _onGuardingOperationItemSelected(int index, BuildContext context) async {
    _menuScaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, guardingMasterDataRoute,
          arguments: {"Guarding Master Data": true});
    } else if (index == 1) {
      Navigator.pushNamed(context, guardingMasterReportRoute,
          arguments: {"Guarding Master Report": false});
    } else if (index == 2) {
      Navigator.pushNamed(context, guardingRatesRoute,
          arguments: {"Guarding Rates": true});
    } else if (index == 3) {
      // TODO: Show Dropdown

      log('--keyManagementDataItems--_genericBuildDrawerChildren--');
      return _genericExpandableDrawer(
        context,
        keyManagementDataItems,
        'title',
      );
      // Navigator.pushNamed(context, keyManagementMasterListRoute,
      //     arguments: {"Key Management Master": false});
    } else if (index == 7) {
      Navigator.pushNamed(context, keyReconciliationListRoute,
          arguments: {"Key Reconciliation List": false});
    } else if (index == 8) {
      Navigator.pushNamed(context, keyLossDestructionListRoute,
          arguments: {"Key Loss Destruction List": false});
    } else if (index == 9) {
      Navigator.pushNamed(context, keyManagementIssuanceListRoute,
          arguments: {"Key Management Issuance List": false});
    } else if (index == 10) {
      Navigator.pushNamed(context, dutyPostMasterListRoute,
          arguments: {"Duty Post Master list": false});
    } else if (index == 11) {
      Navigator.pushNamed(context, dutyPostNameMasterListRoute,
          arguments: {"Duty Post Name Master list": false});
    } else if (index == 12) {
      Navigator.pushNamed(context, attendanceListRoute,
          arguments: {"Attendance list": false});
    } else if (index == 13) {
      Navigator.pushNamed(context, shiftScheduleListRoute,
          arguments: {"Shift Schedule": false});
    } else if (index == 4) {
      Navigator.pushNamed(context, occurrenceRoute);
    } else if (index == 5) {
      Navigator.pushNamed(context, slaViolationPenaltyListRoute,
          arguments: {"SLA Violation Penalty": false});
    } else if (index == 6) {
      Navigator.pushNamed(context, contactDetailsListRoute,
          arguments: {"Contact Details": true});
    }
  }

  _onKeyManagementDataItemSelected(int index, BuildContext context) async {
    _menuScaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, keyManagementMasterListRoute,
          arguments: {"Key Management Master": true});
    } else if (index == 1) {
      Navigator.pushNamed(context, guardingMasterReportRoute,
          arguments: {"Key Management Issuance": false});
    } else if (index == 2) {
      Navigator.pushNamed(context, guardingRatesRoute,
          arguments: {"Key Reconciliation List": true});
    } else if (index == 3) {
      Navigator.pushNamed(context, keyLossDestructionListRoute,
          arguments: {"Key Loss Destruction List": true});
    }
  }

  // List<Widget> _passmgmtbuildDrawerChildren(
  //   BuildContext context,
  //   List items,
  //   String title,
  // ) {
  //   List<Widget> children = [];
  //
  //   for (int i = 0; i < items.length; i++) {
  //     MenuItem drawerItem = items[i];
  //     children.add(
  //       Container(
  //         decoration: const BoxDecoration(
  //           border: Border(
  //               bottom: BorderSide(color: AppColors.dividelineGreycolor)),
  //         ),
  //         child: ListTile(
  //           leading: SizedBox(
  //               width: 18,
  //               height: 18,
  //               child: Image.asset(drawerItem.imageName,
  //                   fit: BoxFit.scaleDown,
  //                   color: (i == _passlastSelectedItem)
  //                       ? AppColors.navigationSkybluecolor
  //                       : AppColors.boldgreyBackground)),
  //           title: Text(drawerItem.title,
  //               //style: Styles.textStyleBlack16,
  //               style: TextStyle(
  //                   fontSize: 16,
  //                   fontFamily: Constants.customFontSemiBoldFamily,
  //                   fontWeight: FontWeight.w600,
  //                   color: (i == _passlastSelectedItem)
  //                       ? AppColors.navigationSkybluecolor
  //                       : AppColors.textgreyThemecolor)),
  //           // selected: i == _lastSelectedItem,
  //           onTap: () => _onPassMgmtSelectItem(i, context),
  //         ),
  //       ),
  //     );
  //   }
  //
  //   return children;
  // }

  List<Widget> _buildDrawerChildren(BuildContext context, DrawerState state) {
    List<Widget> children = [];

    for (int i = 0; i < mainDrawerItems.length; i++) {
      MenuItem drawerItem = mainDrawerItems[i];
      log('-_buildDrawerChildren-----drawerItem.title- ${drawerItem.title}--');

      children.add(
        drawerItem.numberOfChildren == 0
            ? Container(
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: AppColors.dividelineGreycolor)),
                ),
                child: ListTile(
                  leading: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(drawerItem.imageName,
                          fit: BoxFit.cover,
                          color: (i == _lastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor)),
                  title: Text(drawerItem.title,
                      //style: Styles.textStyleBlack16,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: Constants.customFontSemiBoldFamily,
                          fontWeight: FontWeight.w600,
                          color: (i == _lastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor)),
                  //selected: i == _lastSelectedItem,
                  onTap: () => _onSelectItem(
                    i,
                    context,
                  ),
                ),
              )
            : Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: AppColors.dividelineGreycolor)),
                  ),
                  child: ExpansionTile(
                      onExpansionChanged: (value) {
                        if (value == true) {
                          _lastSelectedItem = i;
                          //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
                          //state = const DrawerInitial();
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
                      trailing: const SizedBox.shrink(),
                      title: Text(
                        'SSSS',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: Constants.customFontSemiBoldFamily,
                            fontWeight: FontWeight.w600,
                            color: (i == _lastSelectedItem)
                                ? AppColors.navigationSkybluecolor
                                : AppColors.textgreyThemecolor),
                        // style: Styles.textStyleBlack16,
                      ),
                      leading: SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(AppIcon.securityprotection,
                              fit: BoxFit.cover,
                              color: (i == _lastSelectedItem)
                                  ? AppColors.navigationSkybluecolor
                                  : AppColors.textgreyThemecolor)),
                      childrenPadding: const EdgeInsets.only(left: 20),
                      //children padding
                      children: _buildOperationsFromSecurity(context, state)),
                ),
              ),
      );
    }

    return children;
  }

  List<Widget> _buildOperationsFromSecurity(
      BuildContext context, DrawerState state) {
    List<Widget> children = [];

    for (int i = 0; i < securityItems.length; i++) {
      MenuItem drawerItem = securityItems[i];
      log('---drawerItem.title- ${drawerItem.title}--');
      children.add(
        drawerItem.numberOfChildren == 0
            ? Container(
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: AppColors.dividelineGreycolor)),
                ),
                child: ListTile(
                  leading: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        drawerItem.imageName,
                        //fit: BoxFit.cover,
                        color: (i == _securityfunfunctionslastSelectedItem)
                            ? AppColors.navigationSkybluecolor
                            : AppColors.gerylightBackground,
                      )),
                  title: Text(drawerItem.title,
                      //style: Styles.textStyleBlack16,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: Constants.customFontSemiBoldFamily,
                          fontWeight: FontWeight.w600,
                          color: (i == _securityfunfunctionslastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor)),
                  //selected: i == _lastSelectedItem,
                  onTap: () => _onSecurityExpansionSelectItem(i, context),
                ),
              )
            : Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: AppColors.dividelineGreycolor)),
                  ),
                  child: ExpansionTile(
                    onExpansionChanged: (value) {
                      if (value == true) {
                        _securityfunfunctionslastSelectedItem = i;
                        //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
                        //state = const DrawerInitial();
                        context.read<DrawerCubit>().getSecurityIndexChange(
                            _securityfunfunctionslastSelectedItem);
                      } else {
                        _securityfunfunctionslastSelectedItem = 10;
                        context.read<DrawerCubit>().getSecurityIndexChange(
                            _securityfunfunctionslastSelectedItem);
                      }
                    },
                    trailing: const SizedBox.shrink(),
                    title: Text(
                      drawerItem.title,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: Constants.customFontSemiBoldFamily,
                          fontWeight: FontWeight.w600,
                          color: (i == _securityfunfunctionslastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor),
                      // style: Styles.textStyleBlack16,
                    ),
                    leading: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(AppIcon.operatingsystem,
                          fit: BoxFit.cover,
                          color: (i == _securityfunfunctionslastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor),
                    ),
                    childrenPadding: const EdgeInsets.only(left: 20),
                    //children padding
                    children: drawerItem.title == Constants.operations
                        ? _expansionBuildDrawerChildren(context)
                        : _securitySystemExpansionBuildDrawerChildren(context),
                  ),
                ),
              ),
      );
    }

    return children;
  }

  List<Widget> _securitySystemExpansionBuildDrawerChildren(
    BuildContext context,
  ) {
    List<Widget> children = [];

    for (int i = 0; i < securitySystemExpansionTileDrawerItems.length; i++) {
      MenuItem drawerItem = securitySystemExpansionTileDrawerItems[i];
      children.add(
        drawerItem.numberOfChildren == 0
            ? Container(
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: AppColors.dividelineGreycolor)),
                ),
                child: ListTile(
                  leading: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(drawerItem.imageName,
                          fit: BoxFit.cover,
                          color: (i == _opearationsLastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor)),
                  title: Text(drawerItem.title,
                      //style: Styles.textStyleBlack16,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: Constants.customFontSemiBoldFamily,
                          fontWeight: FontWeight.w600,
                          color: (i == _opearationsLastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor)),
                  // selected: i == _lastSelectedItem,
                  onTap: () => _onExpansionSelectItem(i, context),
                ),
              )
            : Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: AppColors.dividelineGreycolor)),
                  ),
                  child: ExpansionTile(
                    onExpansionChanged: (value) {
                      if (value == true) {
                        _opearationsLastSelectedItem = i;
                        //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
                        //state = const DrawerInitial();
                        context.read<DrawerCubit>().getOperationsIndexChange(
                            _opearationsLastSelectedItem);
                      } else {
                        _opearationsLastSelectedItem = 10;
                        context
                            .read<DrawerCubit>()
                            .getOperationsIndexChange(10);
                      }
                    },
                    trailing: const SizedBox.shrink(),
                    title: Text(
                      drawerItem.title,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: Constants.customFontSemiBoldFamily,
                          fontWeight: FontWeight.w600,
                          color: (i == _opearationsLastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor),
                      // style: Styles.textStyleBlack16,
                    ),
                    leading: SizedBox(
                      width: 18,
                      height: 18,
                      child: Image.asset(drawerItem.imageName,
                          fit: BoxFit.fitHeight,
                          color: (i == _opearationsLastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor),
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

  List<Widget> _expansionBuildDrawerChildren(BuildContext context) {
    List<Widget> children = [];

    for (int i = 0; i < expansionTileDrawerItems.length; i++) {
      MenuItem drawerItem = expansionTileDrawerItems[i];
      children.add(
        drawerItem.numberOfChildren == 0
            ? Container(
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: AppColors.dividelineGreycolor)),
                ),
                child: ListTile(
                  leading: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(drawerItem.imageName,
                          fit: BoxFit.cover,
                          color: (i == _opearationsLastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor)),
                  title: Text(drawerItem.title,
                      //style: Styles.textStyleBlack16,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: Constants.customFontSemiBoldFamily,
                          fontWeight: FontWeight.w600,
                          color: (i == _opearationsLastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor)),
                  // selected: i == _lastSelectedItem,
                  onTap: () => _onExpansionSelectItem(i, context),
                ),
              )
            : Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: AppColors.dividelineGreycolor)),
                  ),
                  child: ExpansionTile(
                    onExpansionChanged: (value) {
                      if (value == true) {
                        _opearationsLastSelectedItem = i;
                        //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
                        //state = const DrawerInitial();
                        context.read<DrawerCubit>().getOperationsIndexChange(
                            _opearationsLastSelectedItem);
                      } else {
                        _opearationsLastSelectedItem = 10;
                        context
                            .read<DrawerCubit>()
                            .getOperationsIndexChange(10);
                      }
                    },
                    trailing: const SizedBox.shrink(),
                    title: Text(
                      drawerItem.title,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: Constants.customFontSemiBoldFamily,
                          fontWeight: FontWeight.w600,
                          color: (i == _opearationsLastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor),
                      // style: Styles.textStyleBlack16,
                    ),
                    leading: SizedBox(
                      width: 18,
                      height: 18,
                      child: Image.asset(drawerItem.imageName,
                          fit: BoxFit.fitHeight,
                          color: (i == _opearationsLastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor),
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

  _onExpansionSelectItem(int index, BuildContext context) async {
    _menuScaffoldKey.currentState!.closeDrawer();
    _opearationsLastSelectedItem = index;
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
    context.read<DrawerCubit>().getOperationsIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, articleFoundListRoute);
    } else if (index == 1) {
      Navigator.pushNamed(context, lawEnforcementListRoute);
    } else if (index == 2) {
      Navigator.pushNamed(context, eventProtectionListRoute);
    } else if (index == 3) {
      log('Index 3 -$index--- ');
      Navigator.pushNamed(context, annualPowerShutdownListRoute);
    } else if (index == 4) {
      Navigator.pushNamed(context, incidentManagementsRoute);
    } else if (index == 5) {
      //
    } else if (index == 6) {}
  }

  _onPassMgmtSelectItem(int index, BuildContext context) async {
    _menuScaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);
    if (index == 0) {
      //day pass mng = 0
      log('day pass mangement index0');
      Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
        "passMngDetails": PassMngArguments('0', 'Day Pass Management', false)
      });
    } else if (index == 1) {
      log('day pass registry index1');
      //day pass mng = 0
      Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
        "passMngRegisterDetails":
            PassMngArguments('0', 'Day Pass Register', true)
      });
    } else if (index == 2) {
      //visitor pass mng = 1

      log('visitor pass mangement index2');
      Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
        "passMngDetails":
            PassMngArguments('1', 'Visitor Pass Management', false)
      });
    } else if (index == 3) {
      //visitor pass mng = 1
      log('visitor pass registory index3');
      Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
        "passMngRegisterDetails":
            PassMngArguments('1', 'Visitor Pass Register', true)
      });
    } else if (index == 4) {
      log('vendor pass management index4');
      Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
        "passMngDetails": PassMngArguments('2', 'Vendor Pass Management', false)
      });
    } else if (index == 5) {
      //vendor pass mng = 2

      log('vendor pass registory index5');
      Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
        "passMngRegisterDetails":
            PassMngArguments('2', 'Vendor Pass Register', true)
      });
    } else if (index == 6) {
      //vendor pass mng = 3

      log('Sez pass Management index6');
      Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
        "passMngDetails": PassMngArguments('3', 'Sez Pass Management', false)
      });
    } else if (index == 7) {
      log('Sez pass registory index7');
      Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
        "passMngRegisterDetails":
            PassMngArguments('3', 'Sez Pass Register', true)
      });
    }
  }

  _onSecurityExpansionSelectItem(int index, BuildContext context) async {
    _menuScaffoldKey.currentState!.closeDrawer();
    _securityfunfunctionslastSelectedItem = index;
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
    context.read<DrawerCubit>().getSecurityIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, articleFoundListRoute);
    } else if (index == 1) {
    } else if (index == 2) {
    } else if (index == 3) {
    } else if (index == 4) {
    } else if (index == 5) {}
  }

  _onSelectItem(
    int index,
    BuildContext context,
  ) async {
    //Navigator.pop(context)
    if (index != 4) {
      _menuScaffoldKey.currentState!.closeDrawer();
    }
    _lastSelectedItem = index;
    // var lastindex = await SharedPrefs.setIdentifymenuindex(index);

    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();

    context.read<DrawerCubit>().getIndexChange(index);
    if (index != 2) {
      _opearationsLastSelectedItem = 10;
    }
    //SetState(){}
    if (index == 0) {
    } else if (index == 1) {
      // _logout(context);
    } else if (index == 2) {
      _logout(context);
    } else if (index == 3) {
    } else if (index == 4) {}
  }

  _logout(BuildContext context) {
    var dialog = CustomAlertDialog(
        title: Constants.logout,
        message: Constants.logoutvalidation,
        onPositivePressed: () {
          Validator.logoutAction(context);
        },
        positiveBtnText: Constants.yes,
        negativeBtnText: Constants.no);
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  List<Widget> buildDrawerChildren(
    BuildContext context,
    String title,
  ) {
    log('--title--$title--');
    if (title == Constants.materialMovement) {
      return _genericExpandableDrawer(
          context, materialMovementDrawerItems, title);
    } else if (title == Constants.securitySystemsTickets) {
      return _buildDrawerChildrenIncident(
        context,
        securitySystemExpansionTileDrawerItems,
      );
    } else if (title == Constants.guarding) {
      return _genericExpandableDrawer(
        context,
        guardingOperationDrawerItems,
        title,
      );
    } else {
      return _genericExpandableDrawer(context, passTileDrawerItems, title);
    }
  }
}

Widget createDrawerHeader(
    String? username, String? email, BuildContext context) {
  return DrawerHeader(
    decoration: const BoxDecoration(
      color: AppColors.backgroundWhitecolor,
    ),
    child: InkWell(
      onTap: () async {
        // await SharedPrefs.setToken('');
        Navigator.pushNamed(
          context,
          resetPwdScreenRoute,
          arguments: {'viaNavigationDrawer': true},
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 45.0,
            backgroundColor: AppColors.navigationSkybluecolor,
            child: CircleAvatar(
                backgroundColor: AppColors.backgroundWhitecolor,
                radius: 43.0,
                child: CircleAvatar(
                    backgroundColor: AppColors.dividelineGreycolor,
                    radius: 40,
                    backgroundImage: AssetImage(Constants.bg))),

            // NetworkImage("Your Photo Url"), // for Network image
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username ?? '',
                  style: Styles.textStyleBlack16,
                ),
                Text(
                  email ?? '',
                  style: Styles.textStyleRegularNormalGrey14,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class MenuItem {
  final String title;
  final String imageName;
  final int numberOfChildren;

  const MenuItem(this.title, this.imageName, this.numberOfChildren);
}

class ImageIconDimension {
  final double height;
  final double width;

  const ImageIconDimension(this.height, this.width);
}
