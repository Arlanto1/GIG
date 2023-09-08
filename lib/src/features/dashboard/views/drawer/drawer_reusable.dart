import 'dart:developer';

import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/dashboard/controllers/cubit/drawer_cubit.dart';
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

class navigationDrawer1 extends StatelessWidget {
  navigationDrawer1(this._menuscaffoldKey, this.username, this.email);

  String? username;
  String? email;
  final GlobalKey<ScaffoldState> _menuscaffoldKey;
  final drawerItems = [
    const DrawerItem1(Constants.dashboard, AppIcon.dashboardselect, 0),
    const DrawerItem1(
        Constants.securityfunctions, AppIcon.securityprotection, 1),
    const DrawerItem1(Constants.administration, AppIcon.maninsuitandtie, 0),
    const DrawerItem1(Constants.settings, AppIcon.settings, 0),
    const DrawerItem1(Constants.logout, AppIcon.logout, 0),
  ];
  final securityItems = [
    const DrawerItem1(Constants.operations, AppIcon.operatingsystem, 1),
  ];
  final expansiontiledrawerItems = [
    const DrawerItem1(
        Constants.articlefoundregister, AppIcon.clipboardImage, 0),
    const DrawerItem1(
        Constants.lawenforcementvisitslist, AppIcon.lawenforcement, 0),
    const DrawerItem1(Constants.eventprotectionlist, AppIcon.tasklist, 0),
    const DrawerItem1(Constants.materialMovement, AppIcon.materialMovement, 1),
    const DrawerItem1(Constants.passmanagement, AppIcon.passmanagement, 1),
    const DrawerItem1(Constants.guarding, AppIcon.guardingOperationIcon, 1),
  ];

  final materialMovementDrawerItems = [
    const DrawerItem1(Constants.materialMovementInward, AppIcon.materialMovementInwardIcon, 0),
    const DrawerItem1(Constants.materialMovementOutward, AppIcon.materialMovementOutwardIcon, 0),
  ];

  final guardingOperationDrawerItems = [
    const DrawerItem1(Constants.guardingMasterData, AppIcon.guardingMasterDataIcon, 0),
    const DrawerItem1(Constants.guardingMasterReport, AppIcon.guardingMasterReportIcon, 0),
    const DrawerItem1(Constants.guardingRate, AppIcon.guardingMasterRatesIcon, 0),
    const DrawerItem1(Constants.femaleDropPickUp, AppIcon.femalePickUpDropIcon, 0),
    const DrawerItem1(Constants.keyManagementList, AppIcon.keyManagementListIcon, 0),
    const DrawerItem1(Constants.occurrence, AppIcon.occurrence, 0),
     ];

  final passtiledrawerItems = [
    const DrawerItem1(Constants.daypassmgmt, AppIcon.daypassmgmticon, 0),
    const DrawerItem1(Constants.daypassregister, AppIcon.daypassregicon, 0),
    const DrawerItem1(
        Constants.visitorpassmgmt, AppIcon.visitorpassmgmticon, 0),
    const DrawerItem1(
        Constants.visitorpassregister, AppIcon.visitorpassregicon, 0),
    const DrawerItem1(Constants.vendorpassmgmt, AppIcon.vendorpassmgmticon, 0),
    const DrawerItem1(
        Constants.vendorpassregister, AppIcon.vendorpassregicon, 0),
    const DrawerItem1(Constants.sezpassmgmt, AppIcon.sezpassmgmticon, 0),
    const DrawerItem1(Constants.sezpassregister, AppIcon.segpassregicon, 0),
  ];

  late int _lastSelectedItem = 0;
  late int _opearationslastSelectedItem = 10;
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
                _opearationslastSelectedItem = state.index;
              } else if (state is SecurityFunctionsGetDrawerItemChange) {
                _securityfunfunctionslastSelectedItem = state.index;
              } else if (state is PassmgmtGetDrawerItemChange) {
                _passlastSelectedItem = state.index;
              }

              print('initial index = ${state.index}');
              print('initial index = $_lastSelectedItem');
              print(_lastSelectedItem);
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
                                  if (_menuscaffoldKey
                                      .currentState!.isDrawerOpen) {
                                    _menuscaffoldKey.currentState!
                                        .closeDrawer();
                                    //close drawer, if drawer is open
                                  } else {
                                    _menuscaffoldKey.currentState!.openDrawer();
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
                      createDrawerHeader(username, email),
                      Column(
                        children: _buildDrawerChildren(context, state),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ))); //
  }

  List<Widget> _expansionbuildDrawerChildren(
      BuildContext context, DrawerState state) {
    List<Widget> children = [];

    for (int i = 0; i < expansiontiledrawerItems.length; i++) {
      DrawerItem1 drawerItem = expansiontiledrawerItems[i];
      children.add(
        drawerItem.numberofchilderns == 0
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
                          color: (i == _opearationslastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor)),
                  title: Text(drawerItem.title,
                      //style: Styles.textStyleBlack16,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: Constants.customFontSemiBoldFamily,
                          fontWeight: FontWeight.w600,
                          color: (i == _opearationslastSelectedItem)
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
                          _opearationslastSelectedItem = i;
                          print('selected index = $i');
                          print('2 index = $_opearationslastSelectedItem');
                          //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
                          //state = const DrawerInitial();
                          context.read<DrawerCubit>().getOperationsindexChange(
                              _opearationslastSelectedItem);
                        } else {
                          _opearationslastSelectedItem = 10;
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
                            color: (i == _opearationslastSelectedItem)
                                ? AppColors.navigationSkybluecolor
                                : AppColors.textgreyThemecolor),
                        // style: Styles.textStyleBlack16,
                      ),
                      leading: SizedBox(
                          width: 18,
                          height: 18,
                          child: Image.asset(drawerItem.imageName,
                              fit: BoxFit.fitHeight,
                              color: (i == _opearationslastSelectedItem)
                                  ? AppColors.navigationSkybluecolor
                                  : AppColors.textgreyThemecolor)),
                      childrenPadding: const EdgeInsets.only(left: 20),
                      //children padding
                    children: buildDrawerChildren(context, state, drawerItem.title),

                  )
                  ),
                )
                    );
    }

    return children;
  }


  List<Widget> _materialMovementBuildDrawerChildren(
      BuildContext context, DrawerState state) {
    List<Widget> children = [];

    for (int i = 0; i < materialMovementDrawerItems.length; i++) {
      DrawerItem1 drawerItem = materialMovementDrawerItems[i];
      children.add(Container(
        decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: AppColors.dividelineGreycolor)),
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
      ));
    }

    return children;
  }

  _onMaterialMovementItemSelected(int index, BuildContext context) async {
    _menuscaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    print('_passlastSelectedItem index = $index');
    print('2 index = $_passlastSelectedItem');
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
    context.read<DrawerCubit>().getPassmgmtindexChange(index);
    if (index == 0) {
      print('pass mangement index1');
      Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
          arguments: {"isInward": true});
    } else if (index == 1) {
      Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
          arguments: {"isInward": false});
    }
  }

  List<Widget> _guardingOperationBuildDrawerChildren(
      BuildContext context, DrawerState state) {
    List<Widget> children = [];

    for (int i = 0; i < guardingOperationDrawerItems.length; i++) {
      DrawerItem1 drawerItem = guardingOperationDrawerItems[i];
      children.add(Container(
        decoration: const BoxDecoration(
          border:
          Border(bottom: BorderSide(color: AppColors.dividelineGreycolor)),
        ),
        child: ListTile(
          leading: SizedBox(
              width: 10,
              height: 10,
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
          onTap: () => _onGuardingOperationItemSelected(i, context),
        ),
      ));
    }

    return children;
  }


  _onGuardingOperationItemSelected(int index, BuildContext context) async {
    _menuscaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    print('_passlastSelectedItem index = $index');
    print('2 index = $_passlastSelectedItem');
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
    } else if (index ==3) {
      Navigator.pushNamed(context, femaleDropPickUpRoute,
          arguments: {"Female Drop PickUp": false});
    } else if (index == 4) {
      Navigator.pushNamed(context, guardingRateDetailsRoute,
          arguments: {"Key Management List": true});
    } else if (index ==5) {
      Navigator.pushNamed(context, guardingRateDetailsRoute,
          arguments: {"Occurrence": false});
    }
  }

  List<Widget> _passmgmtbuildDrawerChildren(
      BuildContext context, DrawerState state) {
    List<Widget> children = [];

    for (int i = 0; i < passtiledrawerItems.length; i++) {
      DrawerItem1 drawerItem = passtiledrawerItems[i];
      children.add(Container(
        decoration: const BoxDecoration(
          //                    <-- BoxDecoration
          border:
              Border(bottom: BorderSide(color: AppColors.dividelineGreycolor)),
        ),
        child: ListTile(
          leading: SizedBox(
              width: 20,
              height: 20,
              child: Image.asset(drawerItem.imageName,
                  fit: BoxFit.cover,
                  color: (i == _passlastSelectedItem)
                      ? AppColors.navigationSkybluecolor
                      : AppColors.textgreyThemecolor)),
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
          onTap: () => _onPassmgmtselectItem(i, context),
        ),
      ));
    }

    return children;
  }

  List<Widget> _buildDrawerChildren(BuildContext context, DrawerState state) {
    List<Widget> children = [];

    log('build drawer children');
    for (int i = 0; i < drawerItems.length; i++) {
      DrawerItem1 drawerItem = drawerItems[i];
      children.add(
        drawerItem.numberofchilderns == 0
            ? Container(
                decoration: const BoxDecoration(
                  //                    <-- BoxDecoration
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
                    //                    <-- BoxDecoration
                    border: Border(
                        bottom:
                            BorderSide(color: AppColors.dividelineGreycolor)),
                  ),
                  child: ExpansionTile(
                      onExpansionChanged: (value) {
                        if (value == true) {
                          _lastSelectedItem = i;
                          print('selected index = $i');
                          print('2 index = $_lastSelectedItem');
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
      DrawerItem1 drawerItem = securityItems[i];
      children.add(
        drawerItem.numberofchilderns == 0
            ? Container(
                decoration: const BoxDecoration(
                  //                    <-- BoxDecoration
                  border: Border(
                      bottom: BorderSide(color: AppColors.dividelineGreycolor)),
                ),
                child: ListTile(
                  leading: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(drawerItem.imageName,
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
                    //                    <-- BoxDecoration
                    border: Border(
                        bottom:
                            BorderSide(color: AppColors.dividelineGreycolor)),
                  ),
                  child: ExpansionTile(
                      onExpansionChanged: (value) {
                        if (value == true) {
                          _securityfunfunctionslastSelectedItem = i;
                          print('selected index = $i');
                          print(
                              '2 index = $_securityfunfunctionslastSelectedItem');
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
                        Constants.operations,
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
                              color:
                                  (i == _securityfunfunctionslastSelectedItem)
                                      ? AppColors.navigationSkybluecolor
                                      : AppColors.textgreyThemecolor)),
                      childrenPadding: const EdgeInsets.only(left: 20),
                      //children padding
                      children: _expansionbuildDrawerChildren(context, state)),
                ),
              ),
      );
    }

    return children;
  }

  _onExpansionSelectItem(int index, BuildContext context) async {
    _menuscaffoldKey.currentState!.closeDrawer();
    _opearationslastSelectedItem = index;
    print('_opearationslastSelectedItem index = $index');
    print('2 index = $_opearationslastSelectedItem');
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
    } else if (index == 4) {
      //
    } else if (index == 5) {}
  }

  _onPassmgmtselectItem(int index, BuildContext context) async {
    _menuscaffoldKey.currentState!.closeDrawer();
    _passlastSelectedItem = index;
    print('_passlastSelectedItem index = $index');
    print('2 index = $_passlastSelectedItem');
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
    context.read<DrawerCubit>().getPassmgmtindexChange(index);
    if (index == 0) {
      //day pass mng = 0
      print('day pass mangement index0');
      Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
        "passMngDetails": PassMngArguments('0', 'Day Pass Management', false)
      });
    } else if (index == 1) {
      print('day pass registry index1');
      //day pass mng = 0
      Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
        "passMngRegisterDetails":
            PassMngArguments('0', 'Day Pass Register', true)
      });
    } else if (index == 2) {
      //visitor pass mng = 1

      print('visitor pass mangement index2');
      Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
        "passMngDetails":
            PassMngArguments('1', 'Visitor Pass Management', false)
      });
    } else if (index == 3) {
      //visitor pass mng = 1
      print('visitor pass registory index3');
      Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
        "passMngRegisterDetails":
            PassMngArguments('1', 'Visitor Pass Register', true)
      });
    } else if (index == 4) {
      print('vendor pass management index4');
      Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
        "passMngDetails": PassMngArguments('2', 'Vendor Pass Management', false)
      });
    } else if (index == 5) {
      //vendor pass mng = 2

      print('vendor pass registory index5');
      Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
        "passMngRegisterDetails":
            PassMngArguments('2', 'Vendor Pass Register', true)
      });
    } else if (index == 6) {
      //vendor pass mng = 3

      print('Sez pass Management index6');
      Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
        "passMngDetails": PassMngArguments('3', 'Sez Pass Management', false)
      });
    } else if (index == 7) {
      print('Sez pass registory index7');
      Navigator.pushNamed(context, daypassregistertListRoute, arguments: {
        "passMngRegisterDetails":
            PassMngArguments('3', 'Sez Pass Register', true)
      });
    }
  }

  _onSecurityExpansionSelectItem(int index, BuildContext context) async {
    _menuscaffoldKey.currentState!.closeDrawer();
    _securityfunfunctionslastSelectedItem = index;
    print('_securityfunfunctionslastSelectedItem index = $index');
    print('2 index = $_securityfunfunctionslastSelectedItem');
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
      _menuscaffoldKey.currentState!.closeDrawer();
    }
    _lastSelectedItem = index;
    var lastindex = await SharedPrefs.setIdentifymenuindex(index);

    print('selected index = $index');
    print('2 index = $_lastSelectedItem');
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();

    context.read<DrawerCubit>().getindexChange(index);
    if (index != 2) {
      _opearationslastSelectedItem = 10;
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
  List<Widget> buildDrawerChildren(BuildContext context, DrawerState state, String title) {
    if (title == Constants.materialMovement) {
      return _materialMovementBuildDrawerChildren(context, state);
    } else if (title == Constants.guarding) {
      return _guardingOperationBuildDrawerChildren(context, state);
    } else {
      return _passmgmtbuildDrawerChildren(context, state);
    }
  }

}

_list(){

}
Widget createDrawerHeader(String? username, String? email) {
  return  DrawerHeader(
      decoration: const BoxDecoration(
        color: AppColors.backgroundWhitecolor,
      ),
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
      ));
}

class DrawerItem1 {
  final String title;
  final String imageName;
  final int numberofchilderns;

  const DrawerItem1(this.title, this.imageName, this.numberofchilderns);
}

class ImageIconDimention1 {
  final double height;
  final double width;

  const ImageIconDimention1(this.height, this.width);
}


