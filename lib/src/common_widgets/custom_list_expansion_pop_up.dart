// import 'dart:ui';
//
// import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
// import 'package:db_atom/src/common_widgets/search_widget.dart';
// import 'package:db_atom/src/constants/app_icon.dart';
// import 'package:db_atom/src/constants/constants.dart';
// import 'package:db_atom/src/constants/ui_geometry_constants.dart';
// import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
// import 'package:db_atom/src/models/organisation.dart';
// import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
// import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
// import 'package:db_atom/src/utils/helpers/keys/keys.dart';
// import 'package:flutter/material.dart';
//
// class CustomExpansionListTexts extends StatefulWidget {
//   const CustomExpansionListTexts({
//     super.key,
//     this.locationList,
//     this.onTap,
//   });
//
//   final Locations? locationList;
//   final Function? onTap;
//
//   @override
//   State<CustomExpansionListTexts> createState() =>
//       CustomExpansionListTextsState();
// }
//
// class CustomExpansionListTextsState extends State<CustomExpansionListTexts> {
//   final _searchCtrl = TextEditingController();
//   Color borderColor = AppColors.searchBarBorder;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   // Search Widget
//   Widget searchWidget() {
//     return SearchWidget(
//       controller: _searchCtrl,
//       hintText: Constants.searchHintText,
//       textInputFieldKey: Keys.searchInputField,
//       leadingIcon: AppIcon.searchIcon,
//       border: borderColor,
//       isEnabled: false,
//       focusChange: (bool focus) {
//         if (focus) {
//           borderColor = AppColors.navigationSkyBlueColor;
//         } else {
//           borderColor = AppColors.textGreyThemeColor;
//         }
//         setState(() {});
//       },
//       onSubmit: (String txt) {
//         if (txt.trim().length >= 15) {
//         } else {
//           //Show error message for validations
//         }
//         _searchCtrl.text = txt;
//       },
//     );
//   }
//   Widget detailsGlassCard(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(22),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//         child: Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.08), // glass effect
//             borderRadius: BorderRadius.circular(22),
//             border: Border.all(
//               color: Colors.white.withOpacity(0.3), // thin white border
//               width: 1.2,
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Close Button - top right
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: GestureDetector(
//                     onTap: () => Navigator.of(context).pop(),
//                     child: SvgPicture.asset(
//                       AppIcon.closeicon,
//                       width: 24,
//                       height: 24,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 // Your existing content
//                 expansionListWidget(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   Widget expansionListWidget() {
//     if (widget.locationList != null) {
//       return Expanded(
//           child: MyExpansionTileList(widget.locationList, widget.onTap));
//     } else {
//       return const Expanded(
//         child: Center(
//           child: Text(
//             Constants.nodata,
//             style: Styles.textStyleRegularGrey16,
//           ),
//         ),
//       );
//     }
//   }
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   final size = MediaQuery.of(context).size;
//   //   final height = size.height;
//   //   final width = size.width;
//   //
//   //   return Center(
//   //     child: SizedBox(
//   //       height: height / 1.5,
//   //       width: width - 50,
//   //       child: Card(
//   //         color: Colors.transparent,
//   //         elevation: 9,
//   //         shape: RoundedRectangleBorder(
//   //           side: const BorderSide(color: AppColors.searchBarBorder, width: 1),
//   //           borderRadius: circularBorderRadius10,
//   //         ),
//   //         child: Padding(
//   //           padding: const EdgeInsets.all(20),
//   //           child: Column(
//   //             //mainAxisAlignment: MainAxisAlignment.center,
//   //             children: [
//   //               Padding(
//   //                 padding: const EdgeInsets.only(bottom: 5.0),
//   //                 child: Align(
//   //                   alignment: Alignment.topRight,
//   //                   child: GestureDetector(
//   //                       onTap: () {
//   //                         Navigator.of(context).pop();
//   //                       },
//   //                       child: SvgPicture.asset(
//   //                           AppIcon.closeicon) //Icon(Icons.cancel)
//   //                       ),
//   //                 ),
//   //               ),
//   //               expansionListWidget()
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //       // child: ClipRRect(
//   //       //   borderRadius: BorderRadius.circular(18),
//   //       //   child: BackdropFilter(
//   //       //     filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
//   //       //     // Frosted glass blur
//   //       //     child: Container(
//   //       //       padding: const EdgeInsets.all(20.0),
//   //       //       decoration: BoxDecoration(
//   //       //         gradient: LinearGradient(
//   //       //           colors: [
//   //       //             Colors.white.withValues(alpha: 0.3),
//   //       //             Colors.transparent,
//   //       //             Colors.white.withValues(alpha: 0.3),
//   //       //             // Color(0xFF6474C6).withOpacity(0.14)
//   //       //           ],
//   //       //           stops: [0.02, 0.35, 1],
//   //       //           begin: Alignment.topCenter,
//   //       //           end: Alignment.bottomCenter,
//   //       //         ),
//   //       //         borderRadius: BorderRadius.circular(27),
//   //       //         border: Border.all(
//   //       //           color: Colors.white.withValues(alpha: 0.80),
//   //       //           width: 0.8,
//   //       //         ),
//   //       //         boxShadow: [
//   //       //           BoxShadow(
//   //       //             color: const Color(0xFF6474C6).withValues(alpha: 0.1),
//   //       //             blurRadius:12,
//   //       //             offset: const Offset(8, 0),
//   //       //           ),
//   //       //         ],
//   //       //       ),
//   //       //       height: height / 1.8,
//   //       //       width: width - 18,
//   //       //       child: SingleChildScrollView(
//   //       //         child: Column(
//   //       //           //mainAxisAlignment: MainAxisAlignment.center,
//   //       //           children: [
//   //       //             Padding(
//   //       //               padding: const EdgeInsets.only(bottom: 5.0),
//   //       //               child: Align(
//   //       //                 alignment: Alignment.topRight,
//   //       //                 child: GestureDetector(
//   //       //                     onTap: () {
//   //       //                       Navigator.of(context).pop();
//   //       //                     },
//   //       //                     child: SvgPicture.asset(
//   //       //                         AppIcon.closeicon) //Icon(Icons.cancel)
//   //       //                 ),
//   //       //               ),
//   //       //             ),
//   //       //             expansionListWidget()
//   //       //           ],
//   //       //         // ),
//   //       //       ),
//   //       //       // child: SingleChildScrollView(
//   //       //       //   // child: Column(
//   //       //       //   //   children: getChildren(context, widget.labels),
//   //       //       //   // ),
//   //       //       // ),
//   //       //       )),
//   //       //   ),
//   //       // ),
//   //     ),
//   //   );
//   // }
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final height = size.height;
//     final width = size.width;
//
//     return Center(
//       child: SizedBox(
//         height: height / 1.5,
//         width: width - 50,
//         child: ClipRRect(
//           borderRadius: circularBorderRadius10,
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
//             child: Material(        // <<<<< ⭐ IMPORTANT FIX
//               color: Colors.transparent,
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: circularBorderRadius10,
//                   color: Colors.white.withOpacity(0.08),
//                   border: Border.all(
//                     color: Colors.white.withOpacity(0.25),
//                     width: 1.2,
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       // Close button
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 5),
//                         child: Align(
//                           alignment: Alignment.topRight,
//                           child: GestureDetector(
//                             onTap: () => Navigator.of(context).pop(),
//                             child: SvgPicture.asset(AppIcon.closeicon),
//                           ),
//                         ),
//                       ),
//
//                       // Your expansion list
//                       Flexible(
//                         child: expansionListWidget(),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//
//   }
//
// }
//
// class MyExpansionTileList extends StatefulWidget {
//   const MyExpansionTileList(this.locations, this.onTap, {super.key});
//
//   final Locations? locations;
//   final Function? onTap;
//
//   @override
//   State<MyExpansionTileList> createState() => MyExpansionTileListState();
// }
//
// class MyExpansionTileListState extends State<MyExpansionTileList> {
//   int selectedIndex = -1;
//   String selectedTitle = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: getLocations(context),
//     );
//   }
//
//   List<Widget> getLocations(BuildContext context) {
//     List<Widget> widgets = [];
//     for (Region region in widget.locations?.regions ?? []) {
//       widgets.add(
//         _buildPlayerModelList(region.locations, region.name ?? '', context),
//       );
//     }
//
//     return widgets;
//     // return <Widget>[
//     //   if (widget.locations!.central != null) ...[
//     //     _buildPlayerModelList(widget.locations!.central, 'Central', context),
//     //   ],
//     //   if (widget.locations!.mumbai != null) ...[
//     //     _buildPlayerModelList(widget.locations!.mumbai, 'Mumbai', context),
//     //   ],
//     //   if (widget.locations!.northEast != null) ...[
//     //     _buildPlayerModelList(
//     //         widget.locations!.northEast, 'North East', context),
//     //   ],
//     //   if (widget.locations!.south != null) ...[
//     //     _buildPlayerModelList(widget.locations!.south, 'South', context),
//     //   ],
//     //   if (widget.locations!.west != null) ...[
//     //     _buildPlayerModelList(widget.locations!.west, 'West', context),
//     //   ],
//     // ];
//   }
//
//   Widget _buildPlayerModelList(
//       List<Organisation>? items, String title, BuildContext context) {
//     return ExpansionTile(
//       trailing: const SizedBox.shrink(),
//       key: GlobalKey(),
//       initiallyExpanded: selectedTitle == title,
//       onExpansionChanged: (value) {
//         if (value == true) {
//           selectedTitle = title;
//           selectedIndex = -1;
//           setState(() {});
//         } else {
//           selectedTitle = '';
//           selectedIndex = -1;
//           setState(() {});
//         }
//       },
//       title: Text(
//         title,
//         style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
//       ),
//       children: _buildOperationsFromSecurity(context, items, title),
//     );
//   }
//
//   List<Widget> _buildOperationsFromSecurity(
//       BuildContext context, List<Organisation>? items, String stitle) {
//     List<Widget> children = [];
//
//     for (int i = 0; i < items!.length; i++) {
//       Organisation drawerItem = items[i];
//       children.add(
//         Theme(
//           data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//           child: ExpansionTile(
//             key: Key(i.toString()),
//             initiallyExpanded: selectedIndex == i,
//             onExpansionChanged: (value) {
//               if (value == true) {
//                 selectedIndex = i;
//                 setState(() {});
//               } else {
//                 selectedIndex = -1;
//                 setState(() {});
//               }
//             },
//             //col: Colors.transparent,
//             expandedAlignment: Alignment.centerLeft,
//             trailing: const SizedBox.shrink(),
//             title: ListTile(
//               title: Text(
//                 drawerItem.name ?? '',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontFamily: Constants.customFontSemiBoldFamily,
//                     fontWeight: FontWeight.w600,
//                     color: ((i == selectedIndex) && (stitle == selectedTitle))
//                         ? AppColors.navigationSkyBlueColor
//                         : AppColors.textGreyThemeColor),
//                 // style: Styles.textStyleBlack16,
//               ),
//               onTap: () => _onExpansionSelectItem(i, context, items),
//             ),
//
//             childrenPadding: const EdgeInsets.only(left: 20), //children padding
//           ),
//         ),
//       );
//     }
//
//     return children;
//   }
//
//   _onExpansionSelectItem(
//       int index, BuildContext context, List<Organisation>? items) async {
//     selectedIndex = index;
//     Organisation? drawerItem = items?[index];
//     if (index == 0) {
//     } else if (index == 1) {
//     } else if (index == 2) {
//     } else if (index == 3) {
//     } else if (index == 4) {
//     } else if (index == 5) {}
//     widget.onTap!(drawerItem);
//     Navigator.of(context).pop();
//
//     setState(() {});
//   }
// }
//
//

import 'dart:ui';

import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/search_widget.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomExpansionListTexts extends StatefulWidget {
  const CustomExpansionListTexts({
    super.key,
    this.locationList,
    this.onTap,
  });

  final Locations? locationList;
  final Function? onTap;

  @override
  State<CustomExpansionListTexts> createState() =>
      CustomExpansionListTextsState();
}

class CustomExpansionListTextsState extends State<CustomExpansionListTexts> {
  final _searchCtrl = TextEditingController();
  Color borderColor = AppColors.white;

  // Search widget
  Widget searchWidget() {
    return SearchWidget(
      controller: _searchCtrl,
      hintText: Constants.searchHintText,
      textInputFieldKey: Keys.searchInputField,
      leadingIcon: AppIcon.searchIcon,
      border: borderColor,
      isEnabled: false,
      focusChange: (bool focus) {
        borderColor = focus
            ? AppColors.white
            : AppColors.white;
        setState(() {});
      },
      onSubmit: (String txt) {
        _searchCtrl.text = txt;
      },
    );
  }

  // NO Expanded inside this method anymore (important)
  Widget expansionListWidget() {
    final list = widget.locationList;
    if (list == null) {
      return const Center(
        child: Text(
          "No data found",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      );
    }
    return MyExpansionTileList(
      locations: list,
      onTap: widget.onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: SizedBox(
        height: size.height / 1.5,
        width: size.width - 50,
        child: ClipRRect(
          borderRadius: circularBorderRadius10,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Material(
              color: Colors.transparent,
              child: Container(
                // decoration: BoxDecoration(
                //   borderRadius: circularBorderRadius10,
                //   color: Colors.white.withValues(alpha: 0.01),
                //   border: Border.all(
                //     color: Colors.white.withValues(alpha: 0.65),
                //     width: 1.2,
                //   ),
                // ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.2),
                      Colors.transparent,
                      Colors.white.withValues(alpha: 0.2),
                      // Color(0xFF6474C6).withOpacity(0.14)
                    ],
                    stops: [0.02, 0.35, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(27),
                  border: Border.all(
                    color: Colors.white
                        .withValues(alpha: 0.80),
                    width: 0.8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6474C6)
                          .withValues(alpha: 0.09),
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      //  HEADER ROW: Title + Close Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                             "Locations",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: SvgPicture.asset(
                              AppIcon.closeicon,
                              colorFilter: const ColorFilter.mode(
                                AppColors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      //  Expanded should wrap only the list
                      Expanded(
                        child: expansionListWidget(),
                      ),
                    ],
                  ),

                  // child: Column(
                  //   children: [
                  //     // Close Button
                  //     Align(
                  //       alignment: Alignment.topRight,
                  //       child: GestureDetector(
                  //         onTap: () => Navigator.of(context).pop(),
                  //         child: SvgPicture.asset(AppIcon.closeicon, colorFilter: const ColorFilter.mode(
                  //           AppColors.white,
                  //           BlendMode.srcIn,
                  //         ),),
                  //       ),
                  //     ),
                  //
                  //     const SizedBox(height: 10),
                  //
                  //
                  //     Expanded(
                  //       child: expansionListWidget(),
                  //     ),
                  //   ],
                  // ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ExpansionTile List

class MyExpansionTileList extends StatefulWidget {
  const MyExpansionTileList({
    super.key,
    required this.locations,
    this.onTap,
  });

  final Locations locations;
  final Function? onTap;

  @override
  State<MyExpansionTileList> createState() => MyExpansionTileListState();
}

class MyExpansionTileListState extends State<MyExpansionTileList> {
  int selectedIndex = -1;
  String selectedTitle = '';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getLocations(context),
    );
  }

  List<Widget> getLocations(BuildContext context) {
    List<Widget> widgets = [];

    for (Region region in widget.locations.regions ?? []) {
      widgets.add(
        _buildRegionTile(region.locations, region.name ?? '', context),
      );
    }

    return widgets;
  }

  // Widget _buildRegionTile(
  //     List<Organisation>? items, String title, BuildContext context) {
  //   return ExpansionTile(
  //     trailing: const SizedBox.shrink(),
  //     initiallyExpanded: selectedTitle == title,
  //     onExpansionChanged: (isOpen) {
  //       selectedTitle = isOpen ? title : '';
  //       selectedIndex = -1;
  //       setState(() {});
  //     },
  //     title: Text(
  //       title,
  //       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
  //     ),
  //     children: _buildChildLocations(context, items, title),
  //   );
  // }
  Widget _buildRegionTile(
      List<Organisation>? items, String title, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.2),
                  Colors.transparent,
                  Colors.white.withValues(alpha: 0.2),
                  // Color(0xFF6474C6).withOpacity(0.14)
                ],
                stops: [0.02, 0.35, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(27),
              border: Border.all(
                color: Colors.white
                    .withValues(alpha: 0.80),
                width: 0.8,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6474C6)
                      .withValues(alpha: 0.09),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ExpansionTile(
              trailing: const SizedBox.shrink(),
              initiallyExpanded: selectedTitle == title,
              onExpansionChanged: (open) {
                if (open) {
                  selectedTitle = title;
                  selectedIndex = -1;
                } else {
                  selectedTitle = '';
                  selectedIndex = -1;
                }
                setState(() {});
              },
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    selectedTitle == title ? Icons.keyboard_arrow_down: Icons.keyboard_arrow_right_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
              children: _buildChildLocations(context, items, title),
            ),
          ),
        ),
      ),
    );
  }


  List<Widget> _buildChildLocations(
      BuildContext context, List<Organisation>? items, String stitle) {
    return List.generate(items?.length ?? 0, (i) {
      final item = items![i];
      return ExpansionTile(
        trailing: const SizedBox.shrink(),
        initiallyExpanded: selectedIndex == i,
        onExpansionChanged: (isOpen) {
          selectedIndex = isOpen ? i : -1;
          setState(() {});
        },
        title: ListTile(
          title: Text(
            item.name ?? '',
            style: TextStyle(
              fontSize: 16,
              fontFamily: Constants.customFontSemiBoldFamily,
              fontWeight: FontWeight.w600,
              color: ((i == selectedIndex) && (stitle == selectedTitle))
                  ? AppColors.white
                  : AppColors.white,
            ),
          ),
          onTap: () {
            widget.onTap?.call(item);
            Navigator.of(context).pop();
          },
        ),
        childrenPadding: const EdgeInsets.only(left: 20),
      );
    });
  }
}
