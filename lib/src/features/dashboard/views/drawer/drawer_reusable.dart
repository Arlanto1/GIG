import 'dart:developer';

import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/dashboard/controllers/cubit/drawer_cubit.dart';
import 'package:db_atom/src/features/login/models/login_model.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/customalert.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../passmanagement/daypassregister/views/day_pass_info_list_page.dart';

class NavigationDrawer1 extends StatelessWidget {
  NavigationDrawer1(
    this._menuScaffoldKey,
    this.username,
    this.email, {
    Key? key,
  }) : super(key: key) {
    /// Initialize Display Menu
    initializeDrawerItems();
  }

  late List<MenuItem> expansionTileDrawerItems;

  Future<void> initializeDrawerItems() async {
    expansionTileDrawerItems = await checkDisplayMenu();
  }

  checkDisplayMenu() async {
    DisplayMenu? displayMenu = await SharedPrefs.getDisplayMenu();
    List<MenuItem> expansionTileDrawerItems = [];

    if (displayMenu == null) {
      log('Display Menu Object is null.');
      return;
    }
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
  final drawerItems = [
    const MenuItem(Constants.dashboard, AppIcon.dashboardselect, 0),
    const MenuItem(Constants.securityfunctions, AppIcon.securityprotection, 1),
    const MenuItem(Constants.administration, AppIcon.maninsuitandtie, 0),
    const MenuItem(Constants.settings, AppIcon.settings, 0),
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
        Constants.internalStaff, AppIcon.materialMovementOutwardIcon, 0),
    const MenuItem(
        Constants.externalVendor, AppIcon.materialMovementOutwardIcon, 0),
  ];

  final guardingOperationDrawerItems = [
    const MenuItem(
        Constants.guardingMasterData, AppIcon.guardingMasterDataIcon, 0),
    const MenuItem(
        Constants.guardingMasterReport, AppIcon.guardingMasterReportIcon, 0),
    const MenuItem(Constants.guardingRate, AppIcon.guardingMasterRatesIcon, 0),
    const MenuItem(Constants.femaleDropPickUp, AppIcon.femalePickUpDropIcon, 0),
    const MenuItem(
        Constants.keyManagementList, AppIcon.keyManagementListIcon, 0),
    const MenuItem(Constants.occurrence, AppIcon.occurence, 0),
    const MenuItem(Constants.slaViolationPenalty, AppIcon.occurence, 0),
    const MenuItem(
        Constants.contactDetails, AppIcon.guardingMasterRatesIcon, 0),
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
              } else if (state is PassmgmtGetDrawerItemChange) {
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

  List<Widget> _materialMovementBuildDrawerChildren(
      BuildContext context, DrawerState state) {
    List<Widget> children = [];

    for (int i = 0; i < materialMovementDrawerItems.length; i++) {
      MenuItem drawerItem = materialMovementDrawerItems[i];
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
            onTap: () => _onMaterialMovementItemSelected(i, context),
          ),
        ),
      );
    }

    return children;
  }

  _onMaterialMovementItemSelected(int index, BuildContext context) async {
    _menuScaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    context.read<DrawerCubit>().getPassmgmtindexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
          arguments: {"isInward": true});
    } else if (index == 1) {
      Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
          arguments: {"isInward": false});
    }
  }

  List<Widget> _buildDrawerChildrenIncident(
      BuildContext context, DrawerState state, List items) {
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
                  onTap: () => _onSelectItem(i, context, state),
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
                            .getindexChange(_lastSelectedItem);
                      } else {
                        _securityfunfunctionslastSelectedItem = 10;
                        context.read<DrawerCubit>().getSecurityindexChange(10);
                      }
                    },
                    trailing: const SizedBox.shrink(),
                    title: Text(
                      Constants.securityfunctions,
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
                      state,
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
      BuildContext context, DrawerState state, List items) {
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
                  onTap: () => _onSelectItem(i, context, state),
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
                            .getindexChange(_lastSelectedItem);
                      } else {
                        _securityfunfunctionslastSelectedItem = 10;
                        context.read<DrawerCubit>().getSecurityindexChange(10);
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
                    children: _genericBuildDrawerChildren(
                      context,
                      state,
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

  List<Widget> _genericBuildDrawerChildren(
      BuildContext context, DrawerState state, List items, String title) {
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
            onTap: () => title == Constants.guarding
                ? _onGuardingOperationItemSelected(i, context)
                : _onSecuritySystemIncidentItemSelected(i, context),
          ),
        ),
      );
    }

    return children;
  }

  _onSecuritySystemIncidentItemSelected(int index, BuildContext context) async {
    _menuScaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
    context.read<DrawerCubit>().getPassmgmtindexChange(index);
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
    context.read<DrawerCubit>().getPassmgmtindexChange(index);
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
      Navigator.pushNamed(context, femaleDropPickUpRoute,
          arguments: {"Female Drop PickUp": false});
    } else if (index == 4) {
      Navigator.pushNamed(context, guardingRateDetailsRoute,
          arguments: {"Key Management List": true});
    } else if (index == 5) {
      Navigator.pushNamed(context, occurrenceRoute);
    } else if (index == 6) {
      // Navigator.pushNamed(context, sstIncidentRoute,
      //     arguments: {"SLA Violation Penalty": false});
    } else if (index == 7) {
      Navigator.pushNamed(context, contactDetailsListRoute,
          arguments: {"SLA Violation Penalty": false});
    }
  }

  List<Widget> _passmgmtbuildDrawerChildren(
      BuildContext context, DrawerState state) {
    List<Widget> children = [];

    for (int i = 0; i < passTileDrawerItems.length; i++) {
      MenuItem drawerItem = passTileDrawerItems[i];
      children.add(
        Container(
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppColors.dividelineGreycolor)),
          ),
          child: ListTile(
            leading: SizedBox(
                width: 18,
                height: 18,
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
            // selected: i == _lastSelectedItem,
            onTap: () => _onPassMgmtSelectItem(i, context),
          ),
        ),
      );
    }

    return children;
  }

  List<Widget> _buildDrawerChildren(BuildContext context, DrawerState state) {
    List<Widget> children = [];

    for (int i = 0; i < drawerItems.length; i++) {
      MenuItem drawerItem = drawerItems[i];
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
                  onTap: () => _onSelectItem(i, context, state),
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
                              .getindexChange(_lastSelectedItem);
                        } else {
                          _securityfunfunctionslastSelectedItem = 10;
                          context
                              .read<DrawerCubit>()
                              .getSecurityindexChange(10);
                        }
                      },
                      trailing: const SizedBox.shrink(),
                      title: Text(
                        Constants.securityfunctions,
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
                        context.read<DrawerCubit>().getSecurityindexChange(
                            _securityfunfunctionslastSelectedItem);
                      } else {
                        _securityfunfunctionslastSelectedItem = 10;
                        context.read<DrawerCubit>().getSecurityindexChange(
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
                        ? _expansionBuildDrawerChildren(context, state)
                        : _securitySystemExpansionBuildDrawerChildren(
                            context, state),
                  ),
                ),
              ),
      );
    }

    return children;
  }

  List<Widget> _securitySystemExpansionBuildDrawerChildren(
      BuildContext context, DrawerState state) {
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
                        context.read<DrawerCubit>().getOperationsindexChange(
                            _opearationsLastSelectedItem);
                      } else {
                        _opearationsLastSelectedItem = 10;
                        context
                            .read<DrawerCubit>()
                            .getOperationsindexChange(10);
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
                    children:
                        buildDrawerChildren(context, state, drawerItem.title),
                  ),
                ),
              ),
      );
    }

    return children;
  }

  List<Widget> _expansionBuildDrawerChildren(
      BuildContext context, DrawerState state) {
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
                        context.read<DrawerCubit>().getOperationsindexChange(
                            _opearationsLastSelectedItem);
                      } else {
                        _opearationsLastSelectedItem = 10;
                        context
                            .read<DrawerCubit>()
                            .getOperationsindexChange(10);
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
                    children:
                        buildDrawerChildren(context, state, drawerItem.title),
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
    context.read<DrawerCubit>().getOperationsindexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, articleFoundListRoute);
    } else if (index == 1) {
      Navigator.pushNamed(context, lawEnforcementListRoute);
    } else if (index == 2) {
      Navigator.pushNamed(context, eventProtectionListRoute);
    } else if (index == 3) {
      Navigator.pushNamed(context, incidentManagementsRoute);
    } else if (index == 4) {
      //
    } else if (index == 5) {}
  }

  _onPassMgmtSelectItem(int index, BuildContext context) async {
    _menuScaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
    context.read<DrawerCubit>().getPassmgmtindexChange(index);
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
    context.read<DrawerCubit>().getSecurityindexChange(index);
    if (index == 0) {
      Navigator.pushNamed(context, articleFoundListRoute);
    } else if (index == 1) {
    } else if (index == 2) {
    } else if (index == 3) {
    } else if (index == 4) {
    } else if (index == 5) {}
  }

  _onSelectItem(int index, BuildContext context, DrawerState state) async {
    //Navigator.pop(context)
    if (index != 4) {
      _menuScaffoldKey.currentState!.closeDrawer();
    }
    _lastSelectedItem = index;
    var lastindex = await SharedPrefs.setIdentifymenuindex(index);

    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();

    context.read<DrawerCubit>().getindexChange(index);
    if (index != 2) {
      _opearationsLastSelectedItem = 10;
    }
    //SetState(){}
    if (index == 0) {
    } else if (index == 1) {
    } else if (index == 2) {
    } else if (index == 3) {
    } else if (index == 4) {
      _logout(context);
    }
  }

  _logout(BuildContext context) {
    var dialog = CustomAlertDialog(
        title: Constants.logout,
        message: Constants.logoutvalidation,
        onPostivePressed: () {
          Validator.logoutAction(context);
        },
        positiveBtnText: Constants.yes,
        negativeBtnText: Constants.no);
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  List<Widget> buildDrawerChildren(
      BuildContext context, DrawerState state, String title) {
    if (title == Constants.materialMovement) {
      return _materialMovementBuildDrawerChildren(context, state);
    } else if (title == Constants.securitySystemsTickets) {
      return _buildDrawerChildrenIncident(
        context,
        state,
        securitySystemExpansionTileDrawerItems,
      );
    } else if (title == Constants.guarding) {
      return _genericBuildDrawerChildren(
        context,
        state,
        guardingOperationDrawerItems,
        title,
      );
    } else {
      return _passmgmtbuildDrawerChildren(context, state);
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
      onTap: () {
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
