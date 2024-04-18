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
    if (displayMenu.aps ?? false) {
      expansionTileDrawerItems.add(const MenuItem(
          Constants.annualPowerShutdownList, AppIcon.annualPowerShutdownIcon, 0));
    }
    if (displayMenu.aF ?? false) {
      expansionTileDrawerItems.add(const MenuItem(
          Constants.articleFoundRegister, AppIcon.articleFoundRegisterIcon, 0));
    }
    if (displayMenu.eP ?? false) {
      expansionTileDrawerItems.add(
          const MenuItem(Constants.eventProtectionList, AppIcon.eventProtectionIcon, 0));
    }

    if (displayMenu.gM ?? false) {
      expansionTileDrawerItems.add(const MenuItem(
          Constants.guardingOperations, AppIcon.guardingOperationIcon, 1));
    }

    if (displayMenu.iM ?? false) {
      expansionTileDrawerItems.add(const MenuItem(
          Constants.incidentManagement, AppIcon.incidentManagementIcon, 0));
    }
    // if (displayMenu.gM ?? false) {
    expansionTileDrawerItems.add(const MenuItem(
        keyManagementDataTitle, AppIcon.keyManagementDataIcon, 1));
    // }
    if (displayMenu.lEO ?? false) {
      expansionTileDrawerItems.add(const MenuItem(
          Constants.lawEnforcementVisitsList, AppIcon.lawenforcement, 0));
    }

    if (displayMenu.mM ?? false) {
      expansionTileDrawerItems.add(const MenuItem(
          Constants.materialMovement, AppIcon.materialMovementIcon, 1));
    }
    if (displayMenu.pM ?? false) {
      expansionTileDrawerItems.add(
          const MenuItem(Constants.passManagement, AppIcon.passmanagement, 1));
    }

    // if (displayMenu.gM ?? false) {
    expansionTileDrawerItems.add(
        const MenuItem(shiftSchedulingTitle, AppIcon.eventProtectionIcon, 1));
    // }

    // if (displayMenu.gM ?? false) {
    expansionTileDrawerItems.add(
        const MenuItem(vVipVisitorsTitle, AppIcon.vvipVisitorIcon, 0));
    // }

    // if (displayMenu. ?? false) {
    // expansionTileDrawerItems
    //     .add(const MenuItem(Constants.sCRI, AppIcon.guardingOperationIcon, 1));
    //}
    return expansionTileDrawerItems;
  }

  final String? username;
  final String? email;
  final GlobalKey<ScaffoldState> _menuScaffoldKey;

  late int _lastSelectedItem = 0;
  late int _opearationsLastSelectedItem = 10;
  late int _passlastSelectedItem = 10;
  late int _securityfunfunctionslastSelectedItem = 10;

  Future<void> getIndeifydrawerIndex() async {
    _lastSelectedItem = await SharedPrefs.getIdentifymenuindex();
  }

  // TODO: Need to define all the Titles here
  static const String operationsTitle = Constants.operations;
  static const String costAndBillingTitle = Constants.costAndBilling;
  static const String shiftSchedulingTitle = Constants.shiftScheduling;
  static const String keyManagementDataTitle = Constants.keyManagementData;
  static const String vVipVisitorsTitle = Constants.vVipVisitors;

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
                      DrawerHeaderWidget(
                        username: username ?? '',
                        email: email ?? '',
                      ),
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

  List<Widget> _genericItemSelection(
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
              log('-_genericItemSelection---title---$title---');
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

                /// 3nd Level Menu
                case Constants.guardingOperations:
                  _onGuardingOperationItemSelected(i, context);
                  break;

                // case Constants.securitySystemTickets:
                //   _onSecuritySystemIncidentItemSelected(i, context);
                //   break;

                case operationsTitle:
                  buildDrawerChildren(context, drawerItem.title);
                  break;

                case Constants.securitySystems:
                  buildDrawerChildren(context, drawerItem.title);
                  break;

                case keyManagementDataTitle:
                  _onKeyManagementItemSelected(i, context);
                  break;

                case shiftSchedulingTitle:
                  _onShiftScheduleItemSelected(i, context);
                  break;

                // case 'Guarding Operations':
                //   log('----_genericExpandableDrawer--case keyManagementMaster--title----$title--');
                //   _genericExpandableDrawer(
                //     context,
                //     keyManagementDataItems,
                //     Constants.keyManagementMaster,
                //   );
                //   break;
                // Add more cases for other titles as needed
                default:
                  log('---default-------');
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

  _onSCRIItemSelected(int index, BuildContext context) async {
    _menuScaffoldKey.currentState!.closeDrawer();
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
    _menuScaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(
        context,
        sstIncidentListRoute,
      );
    }
  }

  _onSecuritySystemIncidentItemSelected(int index, BuildContext context) async {
    _menuScaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, sstIncidentListRoute,
          arguments: {"isInternal": true});
    }
    // else if (index == 1) {
    //   Navigator.pushNamed(context, sstIncidentListRoute,
    //       arguments: {"isInternal": false});
    // }
  }

  _onKeyManagementItemSelected(int index, BuildContext context) async {
    _menuScaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, keyManagementMasterListRoute,
          arguments: {"Key Management Master": false});
    } else if (index == 1) {
      Navigator.pushNamed(context, keyManagementIssuanceListRoute,
          arguments: {"Key Management Issuance List": false});
    } else if (index == 2) {
      Navigator.pushNamed(context, keyLossDestructionListRoute,
          arguments: {"Key Loss Destruction List": false});
    }
    // else if (index == 3) {
    //   Navigator.pushNamed(context, keyReconciliationListRoute,
    //       arguments: {"Key Reconciliation List": false});
    // }
  }

  _onShiftScheduleItemSelected(int index, BuildContext context) async {
    _menuScaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;

    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, attendanceListRoute);
    } else if (index == 1) {
      Navigator.pushNamed(context, dutyPostMasterListRoute);
    } else if (index == 2) {
      Navigator.pushNamed(context, dutyPostNameMasterListRoute);
    } else if (index == 3) {
      Navigator.pushNamed(
        context,
        shiftScheduleListRoute,
      );
    } else if (index == 4) {
      Navigator.pushNamed(
        context,
        attendanceReportBillingListRoute,
      );
    }
  }

  _onCostAndBillingItemSelected(int index, BuildContext context) async {
    _menuScaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, attendanceReportBillingListRoute);
    } else if (index == 1) {
      Navigator.pushNamed(context, guardingRatesRoute);
    }
  }

  // TODO: Fix the Drawer Index
  _onGuardingOperationItemSelected(int index, BuildContext context) async {
    _menuScaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, contactDetailsListRoute,
          arguments: {"Contact Details": true});
    } else if (index == 1) {
      Navigator.pushNamed(context, guardingMasterDataRoute,
          arguments: {"Guarding Master Data": true});
    } else if (index == 2) {
      Navigator.pushNamed(context, guardingMasterReportRoute);
    } else if (index == 3) {
      Navigator.pushNamed(context, occurrenceRoute);
    } else if (index == 4) {
      Navigator.pushNamed(context, slaViolationPenaltyListRoute,
          arguments: {"SLA Violation Penalty": false});
    } else if (index == 5) {
    } else if (index == 6) {
      // TODO: Show Dropdown

      // log('--keyManagementDataItems--_genericBuildDrawerChildren--');
      // return _genericItemSelection(
      //   context,
      //   keyManagementDataItems,
      //   Constants.keyManagementMaster,
      // );
      // Navigator.pushNamed(context, keyManagementMasterListRoute,
      //     arguments: {"Key Management Master": false});
    }
  }

  List<Widget> _buildDrawerChildren(BuildContext context, DrawerState state) {
    List<Widget> children = [];

    for (int i = 0; i < mainDrawerItems.length; i++) {
      MenuItem drawerItem = mainDrawerItems[i];
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
                      trailing: const Icon(Icons.arrow_drop_down_rounded),
                      // trailing: const SizedBox.shrink(),
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
                          child: Image.asset(AppIcon.securityFunctions,
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
                    trailing: const Icon(Icons.arrow_drop_down_rounded),
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
                    children: selectedChild(drawerItem, context),
                  ),
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

      case costAndBillingTitle:
        return _genericItemExpandable(
          context,
          costAndBillingExpansionTileDrawerItems,
          costAndBillingTitle,
        );

      case Constants.securitySystems:
        return _genericItemExpandable(
          context,
          securitySystemExpansionTileDrawerItems,
          Constants.securitySystems,
        );
      default:
        return [];
    }
  }

  List<Widget> _genericItemExpandable(
    BuildContext context,
    List items,
    String title,
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
                  onTap: () {
                    log('-onTap-----title---$title---');
                    if (title == Constants.guardingOperations) {
                      _onGuardingOperationItemSelected(i, context);
                      return;
                    }

                    if (title == costAndBillingTitle) {
                      _onCostAndBillingItemSelected(i, context);
                      return;
                    }

                    if (title == Constants.securitySystemTickets) {
                      _onSecuritySystemIncidentItemSelected(i, context);
                      return;
                    }

                    _onExpansionSelectItem(i, context);
                  },
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
                    trailing: const Icon(Icons.arrow_drop_down_rounded),
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
    log('---_onExpansionSelectItem--$index-');
    _menuScaffoldKey.currentState!.closeDrawer();
    _opearationsLastSelectedItem = index;
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
    context.read<DrawerCubit>().getOperationsIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, annualPowerShutdownListRoute);
    } else if (index == 1) {
      Navigator.pushNamed(context, articleFoundListRoute);
    } else if (index == 2) {
      Navigator.pushNamed(context, eventProtectionListRoute);
    } else if (index == 3) {
      log('Index 3 -$index--- ');
      Navigator.pushNamed(context, annualPowerShutdownListRoute);
    } else if (index == 4) {
      Navigator.pushNamed(context, incidentManagementsRoute);
    } else if (index == 5) {
    } else if (index == 6) {
      Navigator.pushNamed(context, lawEnforcementListRoute);
    } else if (index == 10) {
      Navigator.pushNamed(context, vipVisitorsListRoute);
    }
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
        "passMngDetails": PassMngArguments(0, 'Day Pass Management', false)
      });
    } else if (index == 1) {
      log('day pass registry index1');
      //day pass mng = 0
      Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
        "passMngRegisterDetails": PassMngArguments(0, 'Day Pass Register', true)
      });
    } else if (index == 2) {
      //vendor pass mng = 3

      log('Sez pass Management index6');
      Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
        "passMngDetails": PassMngArguments(3, 'Sez Pass Management', false)
      });
    } else if (index == 3) {
      log('Sez pass registory index7');
      Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
        "passMngRegisterDetails": PassMngArguments(3, 'Sez Pass Register', true)
      });
    } else if (index == 4) {
      log('vendor pass management index4');
      Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
        "passMngDetails": PassMngArguments(2, 'Vendor Pass Management', false)
      });
    } else if (index == 5) {
      //vendor pass mng = 2

      log('vendor pass registory index5');
      Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
        "passMngRegisterDetails":
            PassMngArguments(2, 'Vendor Pass Register', true)
      });
    } else if (index == 6) {
      //visitor pass mng = 1

      log('visitor pass mangement index2');
      Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
        "passMngDetails": PassMngArguments(1, 'Visitor Pass Management', false)
      });
    } else if (index == 7) {
      //visitor pass mng = 1
      log('visitor pass registory index3');
      Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
        "passMngRegisterDetails":
            PassMngArguments(1, 'Visitor Pass Register', true)
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
      Navigator.pushNamed(context, sstIncidentListRoute);
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
        message: Constants.logoutValidation,
        onPositivePressed: () {
          InactivityFunctions().logoutUser(navigatorKey);
        },
        positiveBtnText: Constants.yes,
        negativeBtnText: Constants.no);
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  List<Widget> buildDrawerChildren(
    BuildContext context,
    String title,
  ) {
    if (title == Constants.materialMovement) {
      return _genericItemSelection(context, materialMovementDrawerItems, title);
    } else if (title == Constants.securitySystemTickets) {
      return _genericItemExpandable(
        context,
        securitySystemTicketsItems,
        Constants.securitySystemTickets,
      );
    } else if (title == Constants.guardingOperations) {
      return _genericItemExpandable(
        context,
        guardingOperationDrawerItems,
        Constants.guardingOperations,
      );
    } else if (title == Constants.securityFunctions) {
      return _genericItemSelection(
        context,
        securitySystemTicketsItems,
        title,
      );
    } else if (title == keyManagementDataTitle) {
      return _genericItemSelection(
        context,
        keyManagementDataItems,
        title,
      );
    } else if (title == shiftSchedulingTitle) {
      return _genericItemSelection(
        context,
        shiftSchedulingDataItems,
        title,
      );
    } else if (title == Constants.passManagement) {
      return _genericItemSelection(
        context,
        passTileDrawerItems,
        title,
      );
    } else if (title == Constants.sCRI) {
      return _genericItemSelection(
        context,
        sCRIItems,
        title,
      );
    } else {
      log('-buildDrawerChildren-----else-----title--$title--');

      return _genericItemSelection(
          context, guardingOperationDrawerItems, title);
    }
  }
}
