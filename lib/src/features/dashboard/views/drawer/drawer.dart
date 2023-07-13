import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/customalert.dart';
import 'package:db_atom/src/utils/divider.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class navigationDrawer extends StatelessWidget {
  navigationDrawer(this._menuscaffoldKey);
  final GlobalKey<ScaffoldState> _menuscaffoldKey;
  // final String title;
  // final String description;

  final drawerItems = [
    const DrawerItem(Constants.dashboard, AppIcon.dashboardselect),
    const DrawerItem(Constants.securityfunctions, AppIcon.secureIcon),
    const DrawerItem(Constants.operations, AppIcon.secureIcon),
    const DrawerItem(Constants.administration, AppIcon.secureIcon),
    const DrawerItem(Constants.settings, AppIcon.secureIcon),
    const DrawerItem(Constants.logout, AppIcon.secureIcon),
  ];
  int _lastSelectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          canvasColor:
              AppColors.backgroundWhitecolor, //This will change the drawer background to blue.
          //other styles
        ),
        child: Drawer(
            child: ListView(
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          if (_menuscaffoldKey.currentState!.isDrawerOpen) {
                            _menuscaffoldKey.currentState!.closeDrawer();
                            //close drawer, if drawer is open
                          } else {
                            _menuscaffoldKey.currentState!.openDrawer();
                            //open drawer, if drawer is closed
                          }
                        },
                        child:SvgPicture.asset(AppIcon.closeicon)//Icon(Icons.cancel)
                        // const Icon(
                        //   Icons.cancel,
                        // ),
                      )),
                ),
                createDrawerHeader(),

                // Theme(
                //     data: Theme.of(context)
                //         .copyWith(dividerColor: CustomColors.dividelineGreycolor),
                //     child:
                 ListTile(
                  leading: SizedBox(width:20, height :20, child: Image.asset(AppIcon.dashboardselect, fit: BoxFit.cover,color: AppColors.textgreyThemecolor,)),

                  
                  // Icon(
                  //   Icons.logout_rounded,
                  //   color: AppColors.textgreyThemecolor,
                  // ),
                  title: const Text(
                    Constants.dashboard,
                    style: Styles.textStyleBlack16,
                  ),
                ),
                Dividers.horizentalDivider(),
                 ListTile(
                  leading: SizedBox(width:20, height :20, child: Image.asset(AppIcon.securityprotection, fit: BoxFit.cover)),
                  // Icon(
                  //   Icons.logout_rounded,
                  //   color: AppColors.textgreyThemecolor,
                  // ),
                  title: const Text(
                    Constants.securityfunctions,
                    style: Styles.textStyleBlack16,
                  ),
                ),
                Dividers.horizentalDivider(),
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    trailing: const SizedBox.shrink(),
                    title: const Text(
                      Constants.operations,
                      style: Styles.textStyleBlack16,
                    ),
                    leading: SizedBox(width:20, height :20,child: Image.asset(AppIcon.operatingsystem, fit: BoxFit.cover)),
                    // const Icon(
                    //   Icons.dashboard,
                    //   color: AppColors.textgreyThemecolor,
                    // ), //add icon
                    childrenPadding: const EdgeInsets.only(left: 20), //children padding
                    children: [
                      ListTile(
                        leading: SizedBox(width:20, height :20, child: Image.asset(AppIcon.clipboardImage, fit: BoxFit.cover)),
                        // const Icon(
                        //   Icons.usb_outlined,
                        //   color: AppColors.textgreyThemecolor,
                        // ),
                        title: const Text(
                          Constants.articlefoundregister,
                          style: Styles.textStyleBlack16,
                        ),
                        onTap: () {
                          //action on press
                          Navigator.pushNamed(context, articleFoundListRoute);
                        },
                      ),
                      Dividers.horizentalDivider(),
                      ListTile(
                        leading: SizedBox(width:20, height :20, child: Image.asset(AppIcon.lawenforcement, fit: BoxFit.cover)),
                        // const Icon(
                        //   Icons.usb_outlined,
                        //   color: AppColors.textgreyThemecolor,
                        // ),
                        title: const Text(
                          Constants.lawenforcementvisitslist,
                          style: Styles.textStyleBlack16,
                        ),
                        onTap: () {
                          //action on press
                        },
                      ),
                      Dividers.horizentalDivider(),
                      ListTile(
                        leading: SizedBox(width:20, height :20, child: Image.asset(AppIcon.tasklist, fit: BoxFit.cover)),
                        // const Icon(
                        //   Icons.usb_outlined,
                        //   color: AppColors.textgreyThemecolor,
                        // ),
                        title: const Text(
                          Constants.eventprotectionlist,
                          style: Styles.textStyleBlack16,
                        ),
                        onTap: () {
                          //action on press
                        },
                      ),
                      Dividers.horizentalDivider(),
                      ListTile(
                        leading: SizedBox(width:20, height :20, child: Image.asset(AppIcon.materialmovement, fit: BoxFit.cover)),
                        // const Icon(
                        //   Icons.usb_outlined,
                        //   color: AppColors.textgreyThemecolor,
                        // ),
                        title: const Text(
                          Constants.materialmovement,
                          style: Styles.textStyleBlack16,
                        ),
                        onTap: () {
                          //action on press
                        },
                      ),
                      Dividers.horizentalDivider(),
                      ListTile(
                        leading: 
                        SizedBox(width:20, height :20, child: Image.asset(AppIcon.passmanagement, fit: BoxFit.cover)),
                        // const Icon(
                        //   Icons.usb_outlined,
                        //   color: AppColors.textgreyThemecolor,
                        // ),
                        title: const Text(
                          Constants.passmanagement,
                          style: Styles.textStyleBlack16,
                        ),
                        onTap: () {
                          //action on press
                        },
                      ),

                      //more child menu
                    ],
                    // )
                  ),
                ),
                // Theme(
                //     data: Theme.of(context)
                //         .copyWith(dividerColor: CustomColors.dividelineGreycolor),
                //child:
                // ExpansionTile(
                //   trailing: const SizedBox.shrink(),
                //   title: const Text(
                //               Constants.profile,
                //               style: Styles.textStyleBlack16,
                //             ),
                //   leading: const Icon(
                //     Icons.person,
                //     color: AppColors.textgreyThemecolor,
                //   ), //add icon
                //   childrenPadding: const EdgeInsets.only(left: 60), //children padding
                //   children: [
                //     ListTile(
                //       leading: const Icon(
                //         Icons.usb_outlined,
                //         color: AppColors.textgreyThemecolor,
                //       ),
                //   title: const Text(
                //           Constants.profile,
                //           style: Styles.textStyleBlack16,
                //         ),
                //   onTap: () {
                //     //action on press
                //   },
                // ),

                //     ListTile(
                //       leading: const Icon(
                //         Icons.logout_rounded,
                //         color: AppColors.textgreyThemecolor,
                //       ),
                //       title: const Text(
                //               Constants.profile,
                //               style: Styles.textStyleBlack16,
                //             ),
                //       onTap: () {
                //         //action on press
                //       },
                //     ),

                //     //more child menu
                //   ],
                //   //  )
                // ),
                Dividers.horizentalDivider(),
                 ListTile(
                  leading: SizedBox(width:20, height :20, child: Image.asset(AppIcon.maninsuitandtie, fit: BoxFit.cover)),
                  // Icon(
                  //   Icons.logout_rounded,
                  //   color: AppColors.textgreyThemecolor,
                  // ),
                  title:const  Text(
                    Constants.administration,
                    style: Styles.textStyleBlack16,
                  ),
                ),
                Dividers.horizentalDivider(),
                ListTile(
                  leading: SizedBox(width:20, height :20, child: Image.asset(AppIcon.settings, fit: BoxFit.cover)),
                  // SvgPicture.asset(
                  //   AppIcon.apple,
                  //   // color: AppColors.textColor,
                  //   width: 20,
                  //   height: 20,
                  //   //key: const Key(Keys.userIcon),
                  // ),
                  title: const Text(
                    Constants.settings,
                    style: Styles.textStyleBlack16,
                  ),
                ),
                Dividers.horizentalDivider(),
                ListTile(
                  leading: SizedBox(width:20, height :20, child: Image.asset(AppIcon.logout, fit: BoxFit.cover)),
                  
                      // const Icon(
                      //   Icons.logout_rounded,
                      //   color: AppColors.textgreyThemecolor,
                      // ),
                  //     SvgPicture.asset(
                  //   AppIcon.apple,
                  //   // color: AppColors.textColor,
                  //   width: 20,
                  //   height: 20,
                  //   //key: const Key(Keys.userIcon),
                  // ),
                  title: const Text(
                    Constants.logout,
                    style: Styles.textStyleBlack16,
                  ),
                  onTap: () {
                    _logout(context);
                  },
                ),
              ],
            ),
          ],
        ))); //
  }

  List<Widget> _buildDrawerChildren() {
    List<Widget> children = [];

    for (int i = 0; i < drawerItems.length; i++) {
      DrawerItem drawerItem = drawerItems[i];
      children.add(
        ListTile(
          leading: const Icon(
            Icons.logout_rounded,
            color: AppColors.textgreyThemecolor,
          ),
          title: Text(
            drawerItem.title,
            style: Styles.textStyleBlack16,
          ),
          selected: i == _lastSelectedItem,
          onTap: () => _onSelectItem(i),
        ),
      );
    }

    return children;
  }

  _onSelectItem(int index) async {
    if (index == 0) {
    } else if (index == 1) {
    } else if (index == 2) {
    } else if (index == 3) {
    } else if (index == 4) {
    } else if (index == 5) {}
  }

  _logout(BuildContext context) {
    var dialog = CustomAlertDialog(
        title: Constants.appname,
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
      //margin: EdgeInsets.zero,
      //padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        // color: Colors.red,
        color: AppColors.backgroundWhitecolor,
        // image: DecorationImage(
        //     fit: BoxFit.cover, image: AssetImage(Constants.bg))
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

class DrawerItem {
  final String title;
  final String imageName;

  const DrawerItem(this.title, this.imageName);
}

class ImageIconDimention {
  final double height;
  final double width;

  const ImageIconDimention(this.height, this.width);
}
