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

class navigationDrawer1 extends StatelessWidget {
  navigationDrawer1(this._menuscaffoldKey);
  final GlobalKey<ScaffoldState> _menuscaffoldKey;
  final drawerItems = [
    const DrawerItem1(Constants.dashboard, AppIcon.dashboardselect, 0),
    const DrawerItem1(Constants.securityfunctions, AppIcon.securityprotection, 1),
    const DrawerItem1(Constants.administration, AppIcon.maninsuitandtie, 0),
    const DrawerItem1(Constants.settings, AppIcon.settings, 0),
    const DrawerItem1(Constants.logout, AppIcon.logout, 0),
  ];
  final securityItems = [
    const DrawerItem1(Constants.operations, AppIcon.operatingsystem, 1),
  ];
  final expansiontiledrawerItems = [
    const DrawerItem1(Constants.articlefoundregister, AppIcon.clipboardImage, 0),
    const DrawerItem1(Constants.lawenforcementvisitslist, AppIcon.lawenforcement, 0),
    const DrawerItem1(Constants.eventprotectionlist, AppIcon.tasklist, 0),
    const DrawerItem1(Constants.materialmovement, AppIcon.materialmovement, 0),
    const DrawerItem1(Constants.passmanagement, AppIcon.passmanagement, 0),
  ];
  late int _lastSelectedItem = 0;
  late int _opearationslastSelectedItem = 10;
  late int _securityfunfunctionslastSelectedItem = 10;
  Future<void> getIndeifydrawerIndex() async {
    _lastSelectedItem = await SharedPrefs.getIdentifymenuindex();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          canvasColor:
              AppColors.backgroundWhitecolor, //This will change the drawer background to blue.
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
                _opearationslastSelectedItem = state.index;
              }
              else if (state is SecurityFunctionsGetDrawerItemChange) {
                _securityfunfunctionslastSelectedItem = state.index;
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
                                  if (_menuscaffoldKey.currentState!.isDrawerOpen) {
                                    _menuscaffoldKey.currentState!.closeDrawer();
                                    //close drawer, if drawer is open
                                  } else {
                                    _menuscaffoldKey.currentState!.openDrawer();
                                    //open drawer, if drawer is closed
                                  }
                                },
                                child: SvgPicture.asset(AppIcon.closeicon) //Icon(Icons.cancel)
                                // const Icon(
                                //   Icons.cancel,
                                // ),
                                )),
                      ),
                      createDrawerHeader(),
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

  List<Widget> _expansionbuildDrawerChildren(BuildContext context) {
    List<Widget> children = [];

    for (int i = 0; i < expansiontiledrawerItems.length; i++) {
      DrawerItem1 drawerItem = expansiontiledrawerItems[i];
      children.add(
        Container(
          decoration: const BoxDecoration(
            //                    <-- BoxDecoration
            border: Border(bottom: BorderSide(color: AppColors.dividelineGreycolor)),
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
        ),
      );
    }

    return children;
  }

  List<Widget> _buildDrawerChildren(BuildContext context, DrawerState state) {
    List<Widget> children = [];

    for (int i = 0; i < drawerItems.length; i++) {
      DrawerItem1 drawerItem = drawerItems[i];
      children.add(
        drawerItem.numberofchilderns == 0
            ? Container(
                decoration: const BoxDecoration(
                  //                    <-- BoxDecoration
                  border: Border(bottom: BorderSide(color: AppColors.dividelineGreycolor)),
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
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: Container(
                  decoration: const BoxDecoration(
                    //                    <-- BoxDecoration
                    border: Border(bottom: BorderSide(color: AppColors.dividelineGreycolor)),
                  ),
                  child: ExpansionTile(
                      onExpansionChanged: (value) {
                        if (value == true) {
                          _lastSelectedItem = i;
                          print('selected index = $i');
                          print('2 index = $_lastSelectedItem');
                          //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
                          //state = const DrawerInitial();
                          context.read<DrawerCubit>().getindexChange(_lastSelectedItem);
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
                      childrenPadding: const EdgeInsets.only(left: 20), //children padding
                      children: _buildOperationsFromSecurity(context, state)),
                ),
              ),
      );
    }

    return children;
  }

  List<Widget> _buildOperationsFromSecurity(BuildContext context, DrawerState state) {
    List<Widget> children = [];

    for (int i = 0; i < securityItems.length; i++) {
      DrawerItem1 drawerItem = securityItems[i];
      children.add(
        drawerItem.numberofchilderns == 0
            ? Container(
                decoration: const BoxDecoration(
                  //                    <-- BoxDecoration
                  border: Border(bottom: BorderSide(color: AppColors.dividelineGreycolor)),
                ),
                child: ListTile(
                  leading: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(drawerItem.imageName,
                          fit: BoxFit.cover,
                          color: (i == _securityfunfunctionslastSelectedItem)
                              ? AppColors.navigationSkybluecolor
                              : AppColors.textgreyThemecolor)),
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
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: Container(
                  decoration: const BoxDecoration(
                    //                    <-- BoxDecoration
                    border: Border(bottom: BorderSide(color: AppColors.dividelineGreycolor)),
                  ),
                  child: ExpansionTile(
                      onExpansionChanged: (value) {
                        if (value == true) {
                          _securityfunfunctionslastSelectedItem = i;
                          print('selected index = $i');
                          print('2 index = $_securityfunfunctionslastSelectedItem');
                          //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
                          //state = const DrawerInitial();
                          context.read<DrawerCubit>().getSecurityindexChange(_securityfunfunctionslastSelectedItem);
                        } else {
                           _securityfunfunctionslastSelectedItem = 10;
                          context.read<DrawerCubit>().getSecurityindexChange(_securityfunfunctionslastSelectedItem);
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
                              color: (i == _securityfunfunctionslastSelectedItem)
                                  ? AppColors.navigationSkybluecolor
                                  : AppColors.textgreyThemecolor)),
                      childrenPadding: const EdgeInsets.only(left: 20), //children padding
                      children: _expansionbuildDrawerChildren(context)),
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
    } else if (index == 3) {
    } else if (index == 4) {
    } else if (index == 5) {}
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
      Navigator.pushNamed(context, lawEnforcementListRoute);
    } else if (index == 2) {
    } else if (index == 3) {
    } else if (index == 4) {
    } else if (index == 5) {}
  }

  _onSelectItem(int index, BuildContext context, DrawerState state) async {
    //Navigator.pop(context)
    if (index != 4)
    {
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
}

Widget createDrawerHeader() {
  return const DrawerHeader(
      decoration: BoxDecoration(
        color: AppColors.backgroundWhitecolor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
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
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: Styles.textStyleBlack16,
                ),
                Text(
                  'Sub Title',
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
