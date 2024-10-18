import 'dart:developer';

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
    costAndBillingExpansionTileDrawerItems = await costBillingDisplayMenu();
    securitySystemTicketsItems = await securitySystemsDisplayMenu();
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

    expansionTileDrawerItems
        .add(const MenuItem(ticketingSystemsTitle, AppIcon.vvipVisitorIcon, 0));

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
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: AppColors
            .backgroundWhiteColor, //This will change the drawer background to blue.
        //other styles
      ),
      child: Drawer(
        child: BlocProvider(
          create: (context) => DrawerCubit(),
          child: BlocBuilder<DrawerCubit, DrawerState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case DrawerInitial:
                  _lastSelectedItem = (state as DrawerInitial).index;
                  break;
                case GetDrawerItemChange:
                  _lastSelectedItem = (state as GetDrawerItemChange).index;
                  break;
                case OperationsGetDrawerItemChange:
                  log('drawer operation ');
                  _opearationsLastSelectedItem =
                      (state as OperationsGetDrawerItemChange).index;
                  break;
                case SecurityFunctionsGetDrawerItemChange:
                  _securityfunfunctionslastSelectedItem =
                      (state as SecurityFunctionsGetDrawerItemChange).index;
                  break;
                case PassMgmtGetDrawerItemChange:
                  _passlastSelectedItem =
                      (state as PassMgmtGetDrawerItemChange).index;
                  break;
                case TicketingSystemGetDrawerItemChange:
                  _ticketingSystemlastSelectedItem =
                      (state as TicketingSystemGetDrawerItemChange).index;
                  break;
                default:
                  break;
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
    List<MenuItem> items,
    String title,
  ) {
    List<Widget> children = [];

    for (int i = 0; i < items.length; i++) {
      MenuItem drawerItem = items[i];
      children.add(
        Container(
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppColors.divideLineGreyColor)),
          ),
          child: ListTile(
            leading: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(drawerItem.imageName,
                    fit: BoxFit.scaleDown,
                    color: (i == _passlastSelectedItem)
                        ? AppColors.navigationSkyBlueColor
                        : AppColors.boldGreyBackground)),
            title: Text(drawerItem.title,
                //style: Styles.textStyleBlack16,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: Constants.customFontSemiBoldFamily,
                    fontWeight: FontWeight.w600,
                    color: (i == _passlastSelectedItem)
                        ? AppColors.navigationSkyBlueColor
                        : AppColors.textGreyThemeColor)),
            //selected: i == _lastSelectedItem,
            onTap: () {
              // log('-_genericItemSelection---title---$title---');
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

                // case Constants.securitySystemTickets:
                //   _onSecuritySystemIncidentItemSelected(i, context);
                //   break;

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
    }
    else if(index == 2){
      Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
          arguments: {
            "isInward": false, "returnable": false,
          });
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
    // _menuScaffoldKey.currentState!.closeDrawer();
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
    // _menuScaffoldKey.currentState!.closeDrawer();
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
    log('-_onSecuritySystemIncidentItemSelected------');

    // _menuScaffoldKey.currentState!.closeDrawer();
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
    // _menuScaffoldKey.currentState!.closeDrawer();
    // _passlastSelectedItem = index;
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
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
    // _menuScaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;

    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
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
    // if (index == 0) {
    //   Navigator.pushNamed(context, attendanceListRoute);
    // } else if (index == 1) {
    //   Navigator.pushNamed(context, dutyPostMasterListRoute);
    // } else if (index == 2) {
    //   Navigator.pushNamed(context, dutyPostNameMasterListRoute);
    // } else if (index == 3) {
    //   Navigator.pushNamed(
    //     context,
    //     shiftScheduleListRoute,
    //   );
    // } else if (index == 4) {
    //   Navigator.pushNamed(
    //     context,
    //     attendanceReportBillingListRoute,
    //   );
    // }
  }

  _onCostAndBillingItemSelected(int index, BuildContext context) async {
    // _menuScaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, guardingRatesRoute);
    }
    // else if (index == 1) {
    //   Navigator.pushNamed(context, guardingRatesRoute);
    // }
  }

  // TODO: Fix the Drawer Index
  _onGuardingOperationItemSelected(
      int index, BuildContext context, MenuItem item) async {
    // _menuScaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
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
      // break;
      case Constants.shiftOccurrence:
        Navigator.pushNamed(context, shiftOccurrenceRoute);
        break;
      case Constants.slaViolationPenaltyTitle:
        Navigator.pushNamed(context, slaViolationPenaltyListRoute);
        break;
      default:
        break;
    }

    // switch (index) {
    //   case 0:
    //     Navigator.pushNamed(context, contactDetailsListRoute,
    //         arguments: {"Contact Details": true});
    //     break;
    //   case 1:
    //     Navigator.pushNamed(context, guardingMasterDataRoute,
    //         arguments: {"Guarding Master Data": true});
    //     break;
    //   case 2:
    //     Navigator.pushNamed(context, guardingMasterReportRoute);
    //     break;
    //   case 3:
    //     Navigator.pushNamed(context, occurrenceRoute);
    //     break;
    //   case 4:
    //     Navigator.pushNamed(context, slaViolationPenaltyListRoute,
    //         arguments: {"SLA Violation Penalty": false});
    //     break;
    //   case 6:
    //     // TODO: Show Dropdown
    //     // log('--keyManagementDataItems--_genericBuildDrawerChildren--');
    //     // return _genericItemSelection(
    //     //   context,
    //     //   keyManagementDataItems,
    //     //   Constants.keyManagementMaster,
    //     // );
    //     // Navigator.pushNamed(context, keyManagementMasterListRoute,
    //     //     arguments: {"Key Management Master": false});
    //     break;
    //   default:
    //     break;
    // }

    // if (index == 0) {
    //   Navigator.pushNamed(context, contactDetailsListRoute,
    //       arguments: {"Contact Details": true});
    // } else if (index == 1) {
    //   Navigator.pushNamed(context, guardingMasterDataRoute,
    //       arguments: {"Guarding Master Data": true});
    // } else if (index == 2) {
    //   Navigator.pushNamed(context, guardingMasterReportRoute);
    // } else if (index == 3) {
    //   Navigator.pushNamed(context, occurrenceRoute);
    // } else if (index == 4) {
    //   Navigator.pushNamed(context, slaViolationPenaltyListRoute,
    //       arguments: {"SLA Violation Penalty": false});
    // } else if (index == 5) {
    // } else if (index == 6) {
    //   // TODO: Show Dropdown
    //
    //   // log('--keyManagementDataItems--_genericBuildDrawerChildren--');
    //   // return _genericItemSelection(
    //   //   context,
    //   //   keyManagementDataItems,
    //   //   Constants.keyManagementMaster,
    //   // );
    //   // Navigator.pushNamed(context, keyManagementMasterListRoute,
    //   //     arguments: {"Key Management Master": false});
    // }
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
                      bottom: BorderSide(color: AppColors.divideLineGreyColor)),
                ),
                child: ListTile(
                  leading: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(drawerItem.imageName,
                          fit: BoxFit.cover,
                          color: (i == _lastSelectedItem)
                              ? AppColors.navigationSkyBlueColor
                              : AppColors.textGreyThemeColor)),
                  title: Text(drawerItem.title,
                      //style: Styles.textStyleBlack16,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: Constants.customFontSemiBoldFamily,
                          fontWeight: FontWeight.w600,
                          color: (i == _lastSelectedItem)
                              ? AppColors.navigationSkyBlueColor
                              : AppColors.textGreyThemeColor)),
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
                            BorderSide(color: AppColors.divideLineGreyColor)),
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
                        } else{
                          _securityfunfunctionslastSelectedItem = 10;
                          context
                              .read<DrawerCubit>()
                              .getSecurityIndexChange(10);
                        }
                      },
                      trailing: const Icon(Icons.arrow_drop_down_rounded),
                      // trailing: const SizedBox.shrink(),
                      title: Text(
                        drawerItem.title,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: Constants.customFontSemiBoldFamily,
                            fontWeight: FontWeight.w600,
                            color: (i == _lastSelectedItem)
                                ? AppColors.navigationSkyBlueColor
                                : AppColors.textGreyThemeColor),
                        // style: Styles.textStyleBlack16,
                      ),
                      leading: SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(drawerItem.imageName,
                              fit: BoxFit.cover,
                              color: (i == _lastSelectedItem)
                                  ? AppColors.navigationSkyBlueColor
                                  : AppColors.textGreyThemeColor)),
                      childrenPadding: const EdgeInsets.only(left: 20),
                      //children padding
                      children: drawerItem.title == Constants.securityFunctions ? _buildOperationsFromSecurity(context, state) : _buildTicketingSystemFromSecurity(context,state)),
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
      if (displayMenu?.gR ?? false) {
        menuItems.add(
            const MenuItem(Constants.costAndBilling, AppIcon.costBillingIcon, 1));
      }
      if (displayMenu?.sSSLA ?? false) {
        menuItems.add(const MenuItem(
            Constants.securitySystems, AppIcon.securitySystemIcon, 1));
      }

      for (int i = 0; i < menuItems.length; i++) {
        MenuItem drawerItem = menuItems[i];
        children.add(
          drawerItem.numberOfChildren == 0
              ? Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: AppColors.divideLineGreyColor)),
                  ),
                  child: ListTile(
                    leading: SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          drawerItem.imageName,
                          //fit: BoxFit.cover,
                          color: (i == _securityfunfunctionslastSelectedItem)
                              ? AppColors.navigationSkyBlueColor
                              : AppColors.geryLightBackground,
                        )),
                    title: Text(drawerItem.title,
                        //style: Styles.textStyleBlack16,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: Constants.customFontSemiBoldFamily,
                            fontWeight: FontWeight.w600,
                            color: (i == _securityfunfunctionslastSelectedItem)
                                ? AppColors.navigationSkyBlueColor
                                : AppColors.textGreyThemeColor)),
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
                              BorderSide(color: AppColors.divideLineGreyColor)),
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
                            color: (i == _lastSelectedItem)
                                ? AppColors.navigationSkyBlueColor
                                : AppColors.textGreyThemeColor),
                        // style: Styles.textStyleBlack16,
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
                                ? AppColors.navigationSkyBlueColor
                                : AppColors.textGreyThemeColor),
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

  List<Widget> _buildTicketingSystemFromSecurity(
      BuildContext context, DrawerState state) {
    List<Widget> children = [];

    List<MenuItem> menuItems = [];
    menuItems
        .add(const MenuItem(Constants.tickets, AppIcon.bug, 1));

    for (int i = 0; i < menuItems.length; i++) {
      MenuItem drawerItem = menuItems[i];
      children.add(
      Container(
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppColors.divideLineGreyColor)),
          ),
          child: ListTile(
            leading: SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(
                  drawerItem.imageName,
                  //fit: BoxFit.cover,
                  color: (i == _ticketingSystemlastSelectedItem)
                      ? AppColors.navigationSkyBlueColor
                      : AppColors.textGreyThemeColor,
                )),
            title: Text(drawerItem.title,
                //style: Styles.textStyleBlack16,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: Constants.customFontSemiBoldFamily,
                    fontWeight: FontWeight.w600,
                    color: (i == _ticketingSystemlastSelectedItem)
                        ? AppColors.navigationSkyBlueColor
                        : AppColors.textGreyThemeColor)),
            //selected: i == _lastSelectedItem,
            onTap: () => _onTicketingSystemItemSelected(i, context),
          ),
        )
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
            ? Container(
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: AppColors.divideLineGreyColor)),
                ),
                child: ListTile(
                  leading: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(drawerItem.imageName,
                          fit: BoxFit.cover,
                          color: (i == _opearationsLastSelectedItem)
                              ? AppColors.navigationSkyBlueColor
                              : AppColors.textGreyThemeColor)),
                  title: Text(drawerItem.title,
                      //style: Styles.textStyleBlack16,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: Constants.customFontSemiBoldFamily,
                          fontWeight: FontWeight.w600,
                          color: (i == _opearationsLastSelectedItem)
                              ? AppColors.navigationSkyBlueColor
                              : AppColors.textGreyThemeColor)),
                  // selected: i == _lastSelectedItem,
                  onTap: () {
                    // log('-onTap-----title---$title---');
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
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: AppColors.divideLineGreyColor)),
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
                              ? AppColors.navigationSkyBlueColor
                              : AppColors.textGreyThemeColor),
                      // style: Styles.textStyleBlack16,
                    ),
                    leading: SizedBox(
                      width: 18,
                      height: 18,
                      child: Image.asset(drawerItem.imageName,
                          fit: BoxFit.fitHeight,
                          color: (i == _opearationsLastSelectedItem)
                              ? AppColors.navigationSkyBlueColor
                              : AppColors.textGreyThemeColor),
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
    log('---_onExpansionSelectItem--$index-');
    // _menuScaffoldKey.currentState!.closeDrawer();
    _opearationsLastSelectedItem = index;
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
    context.read<DrawerCubit>().getOperationsIndexChange(index);
    log('---item.title--${item.title}-');

    switch (item.title) {
      case Constants.annualPowerShutdownListTitle:
        Navigator.pushNamed(context, annualPowerShutdownListRoute);
        break;
      case Constants.articleFoundRegisterListTitle:
        Navigator.pushNamed(context, articleFoundListRoute);
        break;
      case Constants.eventProtectionList:
        Navigator.pushNamed(context, eventProtectionListRoute);
        break;
      // case Constants.annualPowerShutdownListTitle:
      //   Navigator.pushNamed(context, annualPowerShutdownListRoute);
      //   break;
      case Constants.incidentManagementTitle:
        Navigator.pushNamed(context, incidentManagementsRoute);
        break;
      case Constants.lawEnforcementVisitsListTitle:
        Navigator.pushNamed(context, lawEnforcementListRoute);
        break;
      case Constants.vVipVisitorsTitle:
        Navigator.pushNamed(context, vipVisitorsListRoute);
        break;

      default:
        break;
    }
    // if (index == 0) {
    //   Navigator.pushNamed(context, annualPowerShutdownListRoute);
    // } else if (index == 1) {
    //   Navigator.pushNamed(context, articleFoundListRoute);
    // } else if (index == 2) {
    //   Navigator.pushNamed(context, eventProtectionListRoute);
    // } else if (index == 3) {
    //   log('Index 3 -$index--- ');
    //   Navigator.pushNamed(context, annualPowerShutdownListRoute);
    // } else if (index == 4) {
    //   Navigator.pushNamed(context, incidentManagementsRoute);
    // } else if (index == 5) {
    // } else if (index == 6) {
    //   Navigator.pushNamed(context, lawEnforcementListRoute);
    // } else if (index == 10) {
    //   Navigator.pushNamed(context, vipVisitorsListRoute);
    // }
  }

  _onPassMgmtSelectItem(int index, BuildContext context) async {
    // _menuScaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
    context.read<DrawerCubit>().getPassMgmtIndexChange(index);
    switch (index) {
      case 0:
        log('day pass management index0');
        Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
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
        Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
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
        Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
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
        Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
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
    // if (index == 0) {
    //   //day pass mng = 0
    //   log('day pass mangement index0');
    //   Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
    //     "passMngDetails": PassMngArguments(0, 'Day Pass Management', false)
    //   });
    // } else if (index == 1) {
    //   log('day pass registry index1');
    //   //day pass mng = 0
    //   Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
    //     "passMngRegisterDetails": PassMngArguments(0, 'Day Pass Register', true)
    //   });
    // } else if (index == 2) {
    //   //vendor pass mng = 3
    //
    //   log('Sez pass Management index6');
    //   Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
    //     "passMngDetails": PassMngArguments(3, 'Sez Pass Management', false)
    //   });
    // } else if (index == 3) {
    //   log('Sez pass registory index7');
    //   Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
    //     "passMngRegisterDetails": PassMngArguments(3, 'Sez Pass Register', true)
    //   });
    // } else if (index == 4) {
    //   log('vendor pass management index4');
    //   Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
    //     "passMngDetails": PassMngArguments(2, 'Vendor Pass Management', false)
    //   });
    // } else if (index == 5) {
    //   //vendor pass mng = 2
    //
    //   log('vendor pass registory index5');
    //   Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
    //     "passMngRegisterDetails":
    //         PassMngArguments(2, 'Vendor Pass Register', true)
    //   });
    // } else if (index == 6) {
    //   //visitor pass mng = 1
    //
    //   log('visitor pass mangement index2');
    //   Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
    //     "passMngDetails": PassMngArguments(1, 'Visitor Pass Management', false)
    //   });
    // } else if (index == 7) {
    //   //visitor pass mng = 1
    //   log('visitor pass registory index3');
    //   Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
    //     "passMngRegisterDetails":
    //         PassMngArguments(1, 'Visitor Pass Register', true)
    //   });
    // }
  }

  _onSecurityExpansionSelectItem(int index, BuildContext context) async {
    // _menuScaffoldKey.currentState!.closeDrawer();
    _securityfunfunctionslastSelectedItem = index;
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
    context.read<DrawerCubit>().getSecurityIndexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, sstIncidentListRoute);
    }
  }

  _onSelectItem(
    int index,
    BuildContext context,
  ) async {
    //Navigator.pop(context)
    if (index != 4) {
      // _menuScaffoldKey.currentState!.closeDrawer();
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
      Navigator.pushNamed(
        context,
        resetPwdScreenRoute,
        arguments: {'viaNavigationDrawer': true},
      );
    } else if (index == 3) {
      // _logout(context);
    } else if (index == 4) {}
  }

  // _logout(BuildContext context) {
  //   var dialog = CustomAlertDialog(
  //       title: Constants.logout,
  //       message: Constants.logoutValidation,
  //       onPositivePressed: () {
  //         InactivityFunctions().logoutUser(navigatorKey);
  //       },
  //       positiveBtnText: Constants.yes,
  //       negativeBtnText: Constants.no);
  //   showDialog(context: context, builder: (BuildContext context) => dialog);
  // }

  List<Widget> buildDrawerChildren(
    BuildContext context,
    String title,
  ) {
    // log('--title---$title--');
    switch (title) {
      case Constants.materialMovement:
        return _genericItemSelection(
            context, materialMovementDrawerItemsWithReturnable, title);
      // case Constants.securitySystemTickets:
      //   return _genericItemExpandable(
      //     context,
      //     securitySystemTicketsItems,
      //     Constants.securitySystemTickets,
      //   );
      // case Constants.guardingOperations:
      //   return _genericItemExpandable(
      //     context,
      //     guardingOperationDrawerItems,
      //     Constants.guardingOperations,
      //   );
      case Constants.guardingOperations:
        List<MenuItem> menuItems = [];
        checkMenuPermissionsGuardingOperations(displayMenu, menuItems);

        // if (displayMenu?.cD ?? false) {
        //   menuItems.add(const MenuItem(
        //       Constants.escalationMatrix, AppIcon.escalationMatrixIcon, 0));
        // }
        //
        // if (displayMenu?.gM ?? false) {
        //   menuItems.add(const MenuItem(
        //       Constants.guardingMasterData, AppIcon.guardingMasterDataIcon, 0));
        // }
        //
        // if (displayMenu?.gMR ?? false) {
        //   menuItems.add(const MenuItem(Constants.guardingMasterReport,
        //       AppIcon.guardingMasterReportIcon, 0));
        // }
        //
        // if (displayMenu?.oCC ?? false) {
        //   menuItems.add(const MenuItem(
        //       Constants.shiftOccurrence, AppIcon.shiftOccurrenceIcon, 0));
        // }
        // if (displayMenu?.sVP ?? false) {
        //   menuItems.add(const MenuItem(Constants.slaViolationPenaltyTitle,
        //       AppIcon.slaViolationPenaltyIcon, 0));
        // }
        return _genericItemExpandable(
          context,
          menuItems,
          Constants.guardingOperations,
        );

      // case Constants.securityFunctions:
      //   return _genericItemSelection(
      //     context,
      //     securitySystemTicketsItems,
      //     title,
      //   );

      // case keyManagementDataTitle:
      //   return _genericItemSelection(
      //     context,
      //     keyManagementDataItems,
      //     title,
      //   );
      case Constants.keyManagementData:
        List<MenuItem> menuItems = [];

        MenuPermissions()
            .checkMenuPermissionsKeyManagementData(displayMenu, menuItems);
        return _genericItemExpandable(
          context,
          menuItems,
          Constants.keyManagementData,
        );

      // case shiftSchedulingTitle:
      //   return _genericItemSelection(
      //     context,
      //     shiftSchedulingDataItems,
      //     title,
      //   );

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
