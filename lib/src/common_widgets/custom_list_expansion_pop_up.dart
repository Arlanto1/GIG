// // import 'dart:ui';
// //
// // import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
// // import 'package:db_atom/src/common_widgets/search_widget.dart';
// // import 'package:db_atom/src/constants/app_icon.dart';
// // import 'package:db_atom/src/constants/constants.dart';
// // import 'package:db_atom/src/constants/ui_geometry_constants.dart';
// // import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
// // import 'package:db_atom/src/models/organisation.dart';
// // import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
// // import 'package:db_atom/src/utils/helpers/keys/keys.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// //
// // class CustomExpansionListTexts extends StatefulWidget {
// //   const CustomExpansionListTexts({
// //     super.key,
// //     this.locationList,
// //     this.onTap,
// //   });
// //
// //   final Locations? locationList;
// //   final Function? onTap;
// //
// //   @override
// //   State<CustomExpansionListTexts> createState() =>
// //       CustomExpansionListTextsState();
// // }
// //
// // class CustomExpansionListTextsState extends State<CustomExpansionListTexts> {
// //   final _searchCtrl = TextEditingController();
// //   Color borderColor = AppColors.white;
// //
// //   // Search widget
// //   Widget searchWidget() {
// //     return SearchWidget(
// //       controller: _searchCtrl,
// //       hintText: Constants.searchHintText,
// //       textInputFieldKey: Keys.searchInputField,
// //       leadingIcon: AppIcon.searchIcon,
// //       border: borderColor,
// //       isEnabled: false,
// //       focusChange: (bool focus) {
// //         borderColor = focus
// //             ? AppColors.white
// //             : AppColors.white;
// //         setState(() {});
// //       },
// //       onSubmit: (String txt) {
// //         _searchCtrl.text = txt;
// //       },
// //     );
// //   }
// //
// //   // NO Expanded inside this method anymore (important)
// //   Widget expansionListWidget() {
// //     final list = widget.locationList;
// //     if (list == null) {
// //       return const Center(
// //         child: Text(
// //           "No data found",
// //           style: TextStyle(fontSize: 16, color: Colors.white),
// //         ),
// //       );
// //     }
// //     return MyExpansionTileList(
// //       locations: list,
// //       onTap: widget.onTap,
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final size = MediaQuery.of(context).size;
// //
// //     return Center(
// //       child: SizedBox(
// //         height: size.height / 1.5,
// //         width: size.width - 50,
// //         child: ClipRRect(
// //           borderRadius: circularBorderRadius10,
// //           child: BackdropFilter(
// //             filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
// //             child: Material(
// //               color: Colors.transparent,
// //               child: Container(
// //
// //                 decoration: BoxDecoration(
// //                   gradient: LinearGradient(
// //                     colors: [
// //                       Colors.white.withValues(alpha: 0.2),
// //                       Colors.transparent,
// //                       Colors.white.withValues(alpha: 0.2),
// //                       // Color(0xFF6474C6).withOpacity(0.14)
// //                     ],
// //                     stops: const [0.02, 0.35, 1],
// //                     begin: Alignment.topCenter,
// //                     end: Alignment.bottomCenter,
// //                   ),
// //                   borderRadius: BorderRadius.circular(27),
// //                   border: Border.all(
// //                     color: Colors.white
// //                         .withValues(alpha: 0.80),
// //                     width: 0.8,
// //                   ),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: const Color(0xFF6474C6)
// //                           .withValues(alpha: 0.09),
// //                       blurRadius: 12,
// //                       offset: const Offset(0, 2),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(20),
// //                   child: Column(
// //                     children: [
// //                       //  HEADER ROW: Title + Close Button
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           const Text(
// //                              "Locations",
// //                             style: TextStyle(
// //                               color: Colors.white,
// //                               fontSize: 20,
// //                               fontWeight: FontWeight.w600,
// //                             ),
// //                           ),
// //
// //                           GestureDetector(
// //                             onTap: () => Navigator.of(context).pop(),
// //                             child: SvgPicture.asset(
// //                               AppIcon.closeIcon,
// //                               colorFilter: const ColorFilter.mode(
// //                                 AppColors.white,
// //                                 BlendMode.srcIn,
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //
// //                       const SizedBox(height: 10),
// //
// //                       //  Expanded should wrap only the list
// //                       Expanded(
// //                         child: expansionListWidget(),
// //                       ),
// //                     ],
// //                   ),
// //
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // // ExpansionTile List
// //
// // class MyExpansionTileList extends StatefulWidget {
// //   const MyExpansionTileList({
// //     super.key,
// //     required this.locations,
// //     this.onTap,
// //   });
// //
// //   final Locations locations;
// //   final Function? onTap;
// //
// //   @override
// //   State<MyExpansionTileList> createState() => MyExpansionTileListState();
// // }
// //
// // class MyExpansionTileListState extends State<MyExpansionTileList> {
// //   int selectedIndex = -1;
// //   String selectedTitle = '';
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return ListView(
// //       children: getLocations(context),
// //     );
// //   }
// //
// //   List<Widget> getLocations(BuildContext context) {
// //     List<Widget> widgets = [];
// //
// //     for (Region region in widget.locations.regions ?? []) {
// //       widgets.add(
// //         _buildRegionTile(region.locations, region.name ?? '', context),
// //       );
// //     }
// //
// //     return widgets;
// //   }
// //
// //   Widget _buildRegionTile(
// //       List<Organisation>? items, String title, BuildContext context) {
// //     return Container(
// //       margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
// //       child: ClipRRect(
// //         borderRadius: BorderRadius.circular(16),
// //         child: BackdropFilter(
// //           filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
// //           child: Container(
// //             decoration: BoxDecoration(
// //               gradient: LinearGradient(
// //                 colors: [
// //                   Colors.white.withValues(alpha: 0.2),
// //                   Colors.transparent,
// //                   Colors.white.withValues(alpha: 0.2),
// //                   // Color(0xFF6474C6).withOpacity(0.14)
// //                 ],
// //                 stops: const [0.02, 0.35, 1],
// //                 begin: Alignment.topCenter,
// //                 end: Alignment.bottomCenter,
// //               ),
// //               borderRadius: BorderRadius.circular(27),
// //               border: Border.all(
// //                 color: Colors.white
// //                     .withValues(alpha: 0.80),
// //                 width: 0.8,
// //               ),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: const Color(0xFF6474C6)
// //                       .withValues(alpha: 0.09),
// //                   blurRadius: 12,
// //                   offset: const Offset(0, 2),
// //                 ),
// //               ],
// //             ),
// //             child: ExpansionTile(
// //               trailing: const SizedBox.shrink(),
// //               initiallyExpanded: selectedTitle == title,
// //               onExpansionChanged: (open) {
// //                 if (open) {
// //                   selectedTitle = title;
// //                   selectedIndex = -1;
// //                 } else {
// //                   selectedTitle = '';
// //                   selectedIndex = -1;
// //                 }
// //                 setState(() {});
// //               },
// //               title: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Text(
// //                     title,
// //                     style: const TextStyle(
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.w500,
// //                       color: Colors.white,
// //                     ),
// //                   ),
// //                   Icon(
// //                     selectedTitle == title ? Icons.keyboard_arrow_down: Icons.keyboard_arrow_right_rounded,
// //                     color: Colors.white,
// //                     size: 20,
// //                   ),
// //                 ],
// //               ),
// //               children: _buildChildLocations(context, items, title),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //
// //   List<Widget> _buildChildLocations(
// //       BuildContext context, List<Organisation>? items, String stitle) {
// //     return List.generate(items?.length ?? 0, (i) {
// //       final item = items![i];
// //       return ExpansionTile(
// //         trailing: const SizedBox.shrink(),
// //         initiallyExpanded: selectedIndex == i,
// //         onExpansionChanged: (isOpen) {
// //           selectedIndex = isOpen ? i : -1;
// //           setState(() {});
// //         },
// //         title: ListTile(
// //           title: Text(
// //             item.name ?? '',
// //             style: TextStyle(
// //               fontSize: 16,
// //               fontFamily: Constants.customFontSemiBoldFamily,
// //               fontWeight: FontWeight.w600,
// //               color: ((i == selectedIndex) && (stitle == selectedTitle))
// //                   ? AppColors.white
// //                   : AppColors.white,
// //             ),
// //           ),
// //           onTap: () {
// //             widget.onTap?.call(item);
// //             Navigator.of(context).pop();
// //           },
// //         ),
// //         childrenPadding: const EdgeInsets.only(left: 20),
// //       );
// //     });
// //   }
// // }
//
// import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
// import 'package:db_atom/src/common_widgets/search_widget.dart';
// import 'package:db_atom/src/constants/app_icon.dart';
// import 'package:db_atom/src/constants/constants.dart';
// import 'package:db_atom/src/constants/ui_geometry_constants.dart';
// import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
// import 'package:db_atom/src/models/organisation.dart';
// import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
// import 'package:db_atom/src/utils/helpers/keys/keys.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
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
//   Color borderColor = AppColors.white;
//
//   // Search widget
//   Widget searchWidget() {
//     return SearchWidget(
//       controller: _searchCtrl,
//       hintText: Constants.searchHintText,
//       textInputFieldKey: Keys.searchInputField,
//       leadingIcon: AppIcon.searchIcon,
//       border: borderColor,
//       isEnabled: false,
//       focusChange: (bool focus) {
//         borderColor = focus
//             ? AppColors.white
//             : AppColors.white;
//         setState(() {});
//       },
//       onSubmit: (String txt) {
//         _searchCtrl.text = txt;
//       },
//     );
//   }
//
//   // NO Expanded inside this method anymore (important)
//   Widget expansionListWidget() {
//     final list = widget.locationList;
//     if (list == null) {
//       return const Center(
//         child: Text(
//           "No data found",
//           style: TextStyle(fontSize: 16, color: Color(0xFF150A78)),
//         ),
//       );
//     }
//     return MyExpansionTileList(
//       locations: list,
//       onTap: widget.onTap,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Center(
//       child: SizedBox(
//         height: size.height / 1.5,
//         width: size.width - 50,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(28),
//           child: Material(
//             color: Colors.transparent,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(28),
//                 border: Border.all(
//                   color: const Color(0xFFDDD8F2),
//                   width: 1,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: const Color(0xFF150A78).withValues(alpha: 0.12),
//                     blurRadius: 30,
//                     offset: const Offset(0, 10),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   children: [
//                     //  HEADER ROW: Title + Close Button
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Locations",
//                           style: TextStyle(
//                             color: Color(0xFF150A78),
//                             fontSize: 20,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ),
//
//                         GestureDetector(
//                           onTap: () => Navigator.of(context).pop(),
//                           child: Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: const BoxDecoration(
//                               color: Color(0xFFF3F1FB),
//                               shape: BoxShape.circle,
//                             ),
//                             child: SvgPicture.asset(
//                               AppIcon.closeIcon,
//                               width: 16,
//                               height: 16,
//                               colorFilter: const ColorFilter.mode(
//                                 Color(0xFF150A78),
//                                 BlendMode.srcIn,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 14),
//
//                     //  Expanded should wrap only the list
//                     Expanded(
//                       child: expansionListWidget(),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ExpansionTile List
//
// class MyExpansionTileList extends StatefulWidget {
//   const MyExpansionTileList({
//     super.key,
//     required this.locations,
//     this.onTap,
//   });
//
//   final Locations locations;
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
//
//     for (Region region in widget.locations.regions ?? []) {
//       widgets.add(
//         _buildRegionTile(region.locations, region.name ?? '', context),
//       );
//     }
//
//     return widgets;
//   }
//
//   Widget _buildRegionTile(
//       List<Organisation>? items, String title, BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(22),
//         child: Container(
//           decoration: BoxDecoration(
//             color: const Color(0xFFF3F1FB), // lavender tile
//             borderRadius: BorderRadius.circular(22),
//           ),
//           child: ExpansionTile(
//             trailing: const SizedBox.shrink(),
//             shape: const Border(),
//             collapsedShape: const Border(),
//             backgroundColor: Colors.transparent,
//             collapsedBackgroundColor: Colors.transparent,
//             tilePadding:
//             const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
//             childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
//             initiallyExpanded: selectedTitle == title,
//             onExpansionChanged: (open) {
//               if (open) {
//                 selectedTitle = title;
//                 selectedIndex = -1;
//               } else {
//                 selectedTitle = '';
//                 selectedIndex = -1;
//               }
//               setState(() {});
//             },
//             title: Row(
//               children: [
//                 // white icon chip (like the menu icons)
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   child: const Icon(
//                     Icons.location_city_rounded,
//                     color: Color(0xFF150A78),
//                     size: 20,
//                   ),
//                 ),
//                 const SizedBox(width: 14),
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xFF150A78),
//                     ),
//                   ),
//                 ),
//                 Icon(
//                   selectedTitle == title
//                       ? Icons.keyboard_arrow_up_rounded
//                       : Icons.keyboard_arrow_down_rounded,
//                   color: const Color(0xFF6E65B5),
//                   size: 22,
//                 ),
//               ],
//             ),
//             children: _buildChildLocations(context, items, title),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   List<Widget> _buildChildLocations(
//       BuildContext context, List<Organisation>? items, String stitle) {
//     return List.generate(items?.length ?? 0, (i) {
//       final item = items![i];
//       final bool isSelected = (i == selectedIndex) && (stitle == selectedTitle);
//       return Padding(
//         padding: const EdgeInsets.only(top: 8),
//         child: ExpansionTile(
//           trailing: const SizedBox.shrink(),
//           shape: const Border(),
//           collapsedShape: const Border(),
//           backgroundColor: Colors.transparent,
//           collapsedBackgroundColor: Colors.transparent,
//           tilePadding: EdgeInsets.zero,
//           initiallyExpanded: selectedIndex == i,
//           onExpansionChanged: (isOpen) {
//             selectedIndex = isOpen ? i : -1;
//             setState(() {});
//           },
//           title: ListTile(
//             dense: true,
//             tileColor: isSelected ? const Color(0xFF150A78) : Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(18),
//               side: BorderSide(
//                 color: isSelected
//                     ? const Color(0xFF150A78)
//                     : const Color(0xFFDDD8F2),
//                 width: 1,
//               ),
//             ),
//             leading: Icon(
//               Icons.place_outlined,
//               size: 20,
//               color: isSelected ? Colors.white : const Color(0xFF150A78),
//             ),
//             title: Text(
//               item.name ?? '',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontFamily: Constants.customFontSemiBoldFamily,
//                 fontWeight: FontWeight.w600,
//                 color: isSelected ? Colors.white : const Color(0xFF150A78),
//               ),
//             ),
//             onTap: () {
//               widget.onTap?.call(item);
//               Navigator.of(context).pop();
//             },
//           ),
//           childrenPadding: const EdgeInsets.only(left: 20),
//         ),
//       );
//     });
//   }
// }

import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/search_widget.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
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
      return Center(
        child: Text(
          "No data found",
          style: TextStyle(fontSize: 16, color: AppColors.kIndigo),
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
        width: size.width - 40,
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: AppColors.kIndigo.withValues(alpha: 0.25),
                  blurRadius: 40,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Container(
                color: AppColors.kPageBg,
                child: Column(
                  children: [
                    // ───────── HEADER (gradient hero) ─────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(24, 22, 16, 22),
                      decoration:  BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.kIndigo, AppColors.kIndigoDeep],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient:  LinearGradient(
                                colors: [AppColors.kBronzeLight, AppColors.kBronze],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.kBronze.withValues(alpha: 0.45),
                                  blurRadius: 14,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.location_on_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SELECT',
                                  style: TextStyle(
                                    color: AppColors.kBronzeLight,
                                    fontSize: 11,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  "Locations",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.14),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.25),
                                ),
                              ),
                              child: SvgPicture.asset(
                                AppIcon.closeIcon,
                                width: 16,
                                height: 16,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // gradient accent line under the header
                    Container(
                      height: 4,
                      decoration:  BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.kBronze, AppColors.kBronzeLight, AppColors.kBronze],
                        ),
                      ),
                    ),

                    //  Expanded should wrap only the list
                    Expanded(
                      child: expansionListWidget(),
                    ),
                  ],
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
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
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

  Widget _buildRegionTile(
      List<Organisation>? items, String title, BuildContext context) {
    final bool isOpen = selectedTitle == title;
    final int count = items?.length ?? 0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isOpen ? AppColors.kBronze.withValues(alpha: 0.7) : AppColors.kBorder,
          width: isOpen ? 1.4 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.kIndigo.withValues(alpha: isOpen ? 0.12 : 0.06),
            blurRadius: isOpen ? 24 : 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: ExpansionTile(
          trailing: const SizedBox.shrink(),
          shape: const Border(),
          collapsedShape: const Border(),
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
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
            children: [
              // gradient country badge
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isOpen
                        ?  [AppColors.kBronzeLight, AppColors.kBronze]
                        :  [AppColors.kIndigo, AppColors.kIndigoDeep],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: (isOpen ? AppColors.kBronze : AppColors.kIndigo)
                          .withValues(alpha: 0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.public_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:  TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: AppColors.kIndigo,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.kBronze.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$count ${count == 1 ? 'location' : 'locations'}',
                        style:  TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.kBronze,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedRotation(
                turns: isOpen ? 0.5 : 0,
                duration: const Duration(milliseconds: 250),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isOpen ? AppColors.kIndigo : AppColors.kPageBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: isOpen ? Colors.white : AppColors.kMuted,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
          children: _buildChildLocations(context, items, title),
        ),
      ),
    );
  }


  List<Widget> _buildChildLocations(
      BuildContext context, List<Organisation>? items, String stitle) {
    return List.generate(items?.length ?? 0, (i) {
      final item = items![i];
      final bool isSelected = (i == selectedIndex) && (stitle == selectedTitle);
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ExpansionTile(
          trailing: const SizedBox.shrink(),
          shape: const Border(),
          collapsedShape: const Border(),
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          tilePadding: EdgeInsets.zero,
          initiallyExpanded: selectedIndex == i,
          onExpansionChanged: (isOpen) {
            selectedIndex = isOpen ? i : -1;
            setState(() {});
          },
          title: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            tileColor: isSelected ? AppColors.kIndigo : AppColors.kPageBg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(
                color: isSelected ? AppColors.kIndigo : AppColors.kBorder,
                width: 1,
              ),
            ),
            leading: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.16)
                    : AppColors.kBronze.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.place_rounded,
                size: 20,
                color: isSelected ? AppColors.kBronzeLight : AppColors.kBronze,
              ),
            ),
            title: Text(
              item.name ?? '',
              style: TextStyle(
                fontSize: 16,
                fontFamily: Constants.customFontSemiBoldFamily,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.kIndigo,
              ),
            ),
            trailing: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.kBronze : AppColors.kIndigo,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: Colors.white,
              ),
            ),
            onTap: () {
              widget.onTap?.call(item);
              Navigator.of(context).pop();
            },
          ),
          childrenPadding: const EdgeInsets.only(left: 20),
        ),
      );
    });
  }
}