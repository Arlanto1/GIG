// // import 'package:db_atom/index.dart';
// //
// // class CustomBottomNavigationBar extends StatelessWidget {
// //   final GlobalKey<ScaffoldState> scaffoldKey;
// //   final BuildContext context;
// //   final DisplayMenu displayMenu;
// //
// //   const CustomBottomNavigationBar({
// //     super.key,
// //     required this.displayMenu,
// //     required this.scaffoldKey,
// //     required this.context,
// //   });
// //
// //   List<BottomMenuItem> prepareMenuItems() {
// //     final List<BottomMenuItem> bottomMenuItems = [];
// //     bool guardingOperations = ((displayMenu.gM ?? false) ||
// //         (displayMenu.cD ?? false) ||
// //         (displayMenu.gR ?? false) ||
// //         (displayMenu.oCC ?? false) ||
// //         (displayMenu.sVP ?? false) ||
// //         (displayMenu.gMR ?? false));
// //
// //     if (guardingOperations) {
// //       bottomMenuItems.add(
// //         BottomMenuItem(
// //           title: Constants.guardingOperations,
// //           menuItem: FloatingNavbarItem(
// //             icon: Icons.person_pin_outlined,
// //             title: Constants.guardingOperations,
// //           ),
// //           onTap: () {
// //             final bottomMenuHandler = BottomMenuHandler(
// //               context: context,
// //               displayMenu: displayMenu,
// //               positionX: getItemPositionX(0),
// //             );
// //             bottomMenuHandler.openGuardingOperationSubMenu();
// //           },
// //         ),
// //       );
// //     }
// //
// //     if (displayMenu.mM ?? false) {
// //       bottomMenuItems.add(
// //         BottomMenuItem(
// //           title: Constants.materialMovement,
// //           menuItem: FloatingNavbarItem(
// //             icon: Icons.supervised_user_circle_sharp,
// //             title: Constants.materialMovement,
// //           ),
// //           onTap: () {
// //             final bottomMenuHandler = BottomMenuHandler(
// //               context: context,
// //               displayMenu: displayMenu,
// //               positionX: getItemPositionX(1),
// //             );
// //             bottomMenuHandler.openMaterialMovementSubMenu();
// //           },
// //         ),
// //       );
// //     }
// //     if (displayMenu.pM ?? false) {
// //       bottomMenuItems.add(
// //         BottomMenuItem(
// //           title: Constants.passManagement,
// //           menuItem: FloatingNavbarItem(
// //             icon: Icons.quick_contacts_mail_rounded,
// //             title: Constants.passManagement,
// //           ),
// //           onTap: () {
// //             final bottomMenuHandler = BottomMenuHandler(
// //               context: context,
// //               displayMenu: displayMenu,
// //               positionX: getItemPositionX(2),
// //             );
// //             bottomMenuHandler.openPassManagementSubMenu();
// //           },
// //         ),
// //       );
// //     }
// //
// //     if (displayMenu.keyMM ?? false) {
// //       bottomMenuItems.add(
// //         BottomMenuItem(
// //           title: Constants.keyManagementData,
// //           menuItem: FloatingNavbarItem(
// //             icon: Icons.key,
// //             title: Constants.keyManagementData,
// //           ),
// //           onTap: () {
// //             final bottomMenuHandler = BottomMenuHandler(
// //               context: context,
// //               displayMenu: displayMenu,
// //               positionX: getItemPositionX(3),
// //             );
// //             bottomMenuHandler.openKeyManagementDataSubMenu();
// //           },
// //         ),
// //       );
// //     }
// //
// //     if (displayMenu.sS ?? false) {
// //       bottomMenuItems.add(
// //         BottomMenuItem(
// //           title: Constants.shiftScheduling,
// //           menuItem: FloatingNavbarItem(
// //             icon: Icons.calendar_month,
// //             title: Constants.shiftScheduling,
// //           ),
// //           onTap: () {
// //             final bottomMenuHandler = BottomMenuHandler(
// //               context: context,
// //               displayMenu: displayMenu,
// //               positionX: getItemPositionX(4),
// //             );
// //             bottomMenuHandler.openShiftScheduleSubMenu();
// //           },
// //         ),
// //       );
// //     }
// //
// //     return bottomMenuItems;
// //   }
// //
// //   double getItemPositionX(int index) {
// //     final RenderBox? renderBox =
// //         scaffoldKey.currentContext?.findRenderObject() as RenderBox?;
// //     if (renderBox == null) return 0.0;
// //
// //     final Offset offset = renderBox.localToGlobal(Offset.zero);
// //     final int itemCount = prepareMenuItems().length + 2;
// //     final double itemWidth = renderBox.size.width / itemCount;
// //
// //     return offset.dx + index * itemWidth + itemWidth / 2;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final menuItems = prepareMenuItems();
// //
// //     return SizedBox(
// //       height: 140,
// //       child: FloatingNavbar(
// //         onTap: (index) {
// //           if (index < menuItems.length) {
// //             menuItems[index].onTap(); // Call the corresponding onTap action
// //           }
// //         },
// //         backgroundColor: AppColors.navigationSkyBlueColor,
// //         selectedBackgroundColor: AppColors.white,
// //         selectedItemColor: AppColors.navigationSkyBlueColor,
// //         currentIndex: 0,
// //         items: menuItems
// //             .map((item) => item.menuItem)
// //             .toList(), // Use prepared menu items
// //       ),
// //     );
// //   }
// // }
// //
// // class BottomMenuItem {
// //   final String title;
// //   final FloatingNavbarItem menuItem;
// //   final Function() onTap; // Add an onTap function
// //
// //   BottomMenuItem({
// //     required this.title,
// //     required this.menuItem,
// //     required this.onTap,
// //   });
// // }
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/features/dashboard/navigation_drawer/views/more_menu_navugation.dart';
//
// class CustomBottomNavigationBar extends StatelessWidget {
//   final GlobalKey<ScaffoldState> scaffoldKey;
//   final BuildContext context;
//   final DisplayMenu displayMenu;
//
//   const CustomBottomNavigationBar({
//     super.key,
//     required this.displayMenu,
//     required this.scaffoldKey,
//     required this.context,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final List<_BottomItem> items = [
//       if((displayMenu.gM ?? false) ||
//           (displayMenu.cD ?? false) ||
//           (displayMenu.gR ?? false) ||
//           (displayMenu.oCC ?? false) ||
//           (displayMenu.sVP ?? false) ||
//           (displayMenu.gMR ?? false))...[
//         _BottomItem(
//           isVisible: ((displayMenu.gM ?? false) ||
//               (displayMenu.cD ?? false) ||
//               (displayMenu.gR ?? false) ||
//               (displayMenu.oCC ?? false) ||
//               (displayMenu.sVP ?? false) ||
//               (displayMenu.gMR ?? false)),
//           icon: Icons.person_pin_outlined,
//           label: 'Guarding\nOperation',
//           onTap: (visibleIndex, visibleCount) {
//             BottomMenuHandler(
//               context: context,
//               displayMenu: displayMenu,
//               positionX: getItemPositionX(visibleIndex, visibleCount),
//             ).openGuardingOperationSubMenu();
//           },
//         ),
//       ],
//       if(displayMenu.mM ?? false)...[
//         _BottomItem(
//           isVisible: displayMenu.mM ?? false,
//           icon: Icons.supervised_user_circle_sharp,
//           label: 'Material\nMovement',
//           onTap: (visibleIndex, visibleCount) {
//             BottomMenuHandler(
//               context: context,
//               displayMenu: displayMenu,
//               positionX: getItemPositionX(visibleIndex, visibleCount),
//             ).openMaterialMovementSubMenu();
//           },
//         ),
//       ],
//       if(displayMenu.pM ?? false)...[
//         _BottomItem(
//           isVisible: displayMenu.pM ?? false,
//           icon: Icons.quick_contacts_mail_rounded,
//           label: 'Pass\nManagement',
//           onTap: (visibleIndex, visibleCount) {
//             BottomMenuHandler(
//               context: context,
//               displayMenu: displayMenu,
//               positionX: getItemPositionX(visibleIndex, visibleCount),
//             ).openPassManagementSubMenu();
//           },
//         ),
//       ],
//       if(displayMenu.keyMM ?? false)...[
//         _BottomItem(
//           isVisible: displayMenu.keyMM ?? false,
//           icon: Icons.key,
//           label: 'Key\nManagement',
//           onTap: (visibleIndex, visibleCount) {
//             BottomMenuHandler(
//               context: context,
//               displayMenu: displayMenu,
//               positionX: getItemPositionX(visibleIndex, visibleCount),
//             ).openKeyManagementDataSubMenu();
//           },
//         ),
//       ],
//       if(displayMenu.sS ?? false)...[
//         _BottomItem(
//           isVisible: displayMenu.sS ?? false,
//           icon: Icons.calendar_month,
//           label: 'Shift\nScheduling',
//           onTap: (visibleIndex, visibleCount) {
//             BottomMenuHandler(
//               context: context,
//               displayMenu: displayMenu,
//               positionX: getItemPositionX(visibleIndex, visibleCount),
//             ).openShiftScheduleSubMenu();
//           },
//         ),
//       ],
//
//       if((displayMenu.aF ?? false) || (displayMenu.eP ?? false) || (displayMenu.aps ?? false) || (displayMenu.iM ?? false) || (displayMenu.lEO ?? false) ||(displayMenu.vIP ?? false))...[
//         _BottomItem(
//           isVisible: true,
//           icon: Icons.more_horiz,
//           label: 'More',
//           onTap: (visibleIndex, visibleCount) {
//             showGeneralDialog(
//               context: context,
//               barrierDismissible: true,
//               barrierLabel: '',
//               transitionDuration: const Duration(milliseconds: 300),
//               pageBuilder: (context, animation1, animation2) {
//                 return Align(
//                   alignment: Alignment.centerRight,
//                   child: Material(
//                     color: Colors.transparent,
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.75,
//                       // child: const MoreMenuDrawerWidget(),
//                     ),
//                   ),
//                 );
//               },
//               transitionBuilder: (context, animation1, animation2, child) {
//                 return SlideTransition(
//                   position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation1),
//                   child: child,
//                 );
//               },
//             );
//           },
//         ),
//       ],
//     ];
//
//     // Prepare list of visible items and their indices in original list
//     final visibleItems = <_BottomItem>[];
//     final visibleIndices = <int>[];
//     for (int i = 0; i < items.length; i++) {
//       if (items[i].isVisible) {
//         visibleItems.add(items[i]);
//         visibleIndices.add(i);
//       }
//     }
//
//     return Container(
//       height: 95,
//       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF5026bc), Color(0xFF5026bc)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 8,
//             offset: Offset(0, -3),
//           )
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: List.generate(items.length, (index) {
//           final item = items[index];
//           final isEnabled = item.isVisible;
//           final isSelected = index == 0; // 👈 replace this with your selected index
//
//           return Expanded(
//             child: GestureDetector(
//               onTap: isEnabled
//                   ? () {
//                 final visibleIndex = visibleIndices.indexOf(index);
//                 item.onTap(visibleIndex, visibleItems.length);
//               }
//                   : null,
//               child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 2),
//                 padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   gradient:  const LinearGradient(
//                     colors: [Colors.transparent, Colors.transparent],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   color: isSelected ? null : Colors.white,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       item.icon,
//                       size: 24,
//                       color: isSelected ? Colors.white : Colors.white, // 👈 always visible
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       item.label,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize:8,
//                         fontWeight: FontWeight.w500,
//                         color: isSelected ? Colors.white : Colors.white, // 👈 always visible
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//             ),
//           );
//         }),
//       ),
//     );
//
//   }
//
//   double getItemPositionX(int visibleIndex, int visibleCount) {
//     final RenderBox? renderBox =
//     scaffoldKey.currentContext?.findRenderObject() as RenderBox?;
//     if (renderBox == null) return 0.0;
//
//     final Offset offset = renderBox.localToGlobal(Offset.zero);
//     final double itemWidth = renderBox.size.width / visibleCount;
//
//     return offset.dx + visibleIndex * itemWidth + itemWidth / 4.5;
//   }
// }
//
// class _BottomItem {
//   final bool isVisible;
//   final IconData icon;
//   final String label;
//   final void Function(int visibleIndex, int visibleCount) onTap;
//
//   _BottomItem({
//     required this.isVisible,
//     required this.icon,
//     required this.label,
//     required this.onTap,
//   });
// }

// import 'package:db_atom/index.dart';
//
// class CustomBottomNavigationBar extends StatefulWidget {
//   final GlobalKey<ScaffoldState> scaffoldKey;
//   final BuildContext context;
//   final DisplayMenu displayMenu;
//
//   const CustomBottomNavigationBar({
//     super.key,
//     required this.displayMenu,
//     required this.scaffoldKey,
//     required this.context,
//   });
//
//   @override
//   State<CustomBottomNavigationBar> createState() =>
//       _CustomBottomNavigationBarState();
// }
//
// class _CustomBottomNavigationBarState
//     extends State<CustomBottomNavigationBar> {
//   int selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     final displayMenu = widget.displayMenu;
//     final scaffoldKey = widget.scaffoldKey;
//
//     final List<_BottomItem> items = [
//       if ((displayMenu.gM ?? false) ||
//           (displayMenu.cD ?? false) ||
//           (displayMenu.gR ?? false) ||
//           (displayMenu.oCC ?? false) ||
//           (displayMenu.sVP ?? false) ||
//           (displayMenu.gMR ?? false))
//         _BottomItem(
//           isVisible: true,
//           icon: Icons.person_pin_outlined,
//           label: 'Guarding\nOperation',
//           onTap: (visibleIndex, visibleCount) {
//             BottomMenuHandler(
//               context: context,
//               displayMenu: displayMenu,
//               positionX: getItemPositionX(visibleIndex, visibleCount),
//             ).openGuardingOperationSubMenu();
//           },
//         ),
//       if (displayMenu.mM ?? false)
//         _BottomItem(
//           isVisible: true,
//           icon: Icons.supervised_user_circle_sharp,
//           label: 'Material\nMovement',
//           onTap: (visibleIndex, visibleCount) {
//             BottomMenuHandler(
//               context: context,
//               displayMenu: displayMenu,
//               positionX: getItemPositionX(visibleIndex, visibleCount),
//             ).openMaterialMovementSubMenu();
//           },
//         ),
//       if (displayMenu.pM ?? false)
//         _BottomItem(
//           isVisible: true,
//           icon: Icons.quick_contacts_mail_rounded,
//           label: 'Pass\nManagement',
//           onTap: (visibleIndex, visibleCount) {
//             BottomMenuHandler(
//               context: context,
//               displayMenu: displayMenu,
//               positionX: getItemPositionX(visibleIndex, visibleCount),
//             ).openPassManagementSubMenu();
//           },
//         ),
//       if (displayMenu.keyMM ?? false)
//         _BottomItem(
//           isVisible: true,
//           icon: Icons.key,
//           label: 'Key\nManagement',
//           onTap: (visibleIndex, visibleCount) {
//             BottomMenuHandler(
//               context: context,
//               displayMenu: displayMenu,
//               positionX: getItemPositionX(visibleIndex, visibleCount),
//             ).openKeyManagementDataSubMenu();
//           },
//         ),
//       if (displayMenu.sS ?? false)
//         _BottomItem(
//           isVisible: true,
//           icon: Icons.calendar_month,
//           label: 'Shift\nScheduling',
//           onTap: (visibleIndex, visibleCount) {
//             BottomMenuHandler(
//               context: context,
//               displayMenu: displayMenu,
//               positionX: getItemPositionX(visibleIndex, visibleCount),
//             ).openShiftScheduleSubMenu();
//           },
//         ),
//       if ((displayMenu.aF ?? false) ||
//           (displayMenu.eP ?? false) ||
//           (displayMenu.aps ?? false) ||
//           (displayMenu.iM ?? false) ||
//           (displayMenu.lEO ?? false) ||
//           (displayMenu.vIP ?? false))
//         _BottomItem(
//           isVisible: true,
//           icon: Icons.more_horiz,
//           label: 'More',
//           onTap: (visibleIndex, visibleCount) {
//             showGeneralDialog(
//               context: context,
//               barrierDismissible: true,
//               barrierLabel: '',
//               transitionDuration: const Duration(milliseconds: 300),
//               pageBuilder: (context, animation1, animation2) {
//                 return Align(
//                   alignment: Alignment.centerRight,
//                   child: Material(
//                     color: Colors.transparent,
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.75,
//                       // child: const MoreMenuDrawerWidget(),
//                     ),
//                   ),
//                 );
//               },
//               transitionBuilder: (context, animation1, animation2, child) {
//                 return SlideTransition(
//                   position: Tween<Offset>(
//                     begin: const Offset(1, 0),
//                     end: Offset.zero,
//                   ).animate(animation1),
//                   child: child,
//                 );
//               },
//             );
//           },
//         ),
//     ];
//
//     // Filter only visible items
//     final visibleItems = <_BottomItem>[];
//     final visibleIndices = <int>[];
//     for (int i = 0; i < items.length; i++) {
//       if (items[i].isVisible) {
//         visibleItems.add(items[i]);
//         visibleIndices.add(i);
//       }
//     }
//
//     return Container(
//       height: 95,
//       margin: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF0D1335), Color(0xFF11184A)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.6),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: List.generate(visibleItems.length, (index) {
//           final item = visibleItems[index];
//           final isSelected = index == selectedIndex;
//
//           return Expanded(
//             child: GestureDetector(
//               onTap: () {
//                 setState(() => selectedIndex = index);
//                 final visibleIndex = visibleIndices[index];
//                 item.onTap(visibleIndex, visibleItems.length);
//               },
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 curve: Curves.easeInOut,
//                 padding:
//                 const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         gradient: isSelected
//                             ? const LinearGradient(
//                           colors: [Color(0xFF1E90FF), Color(0xFF4B0082)],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         )
//                             : null,
//                         boxShadow: isSelected
//                             ? [
//                           BoxShadow(
//                             color: Colors.blueAccent.withOpacity(0.5),
//                             blurRadius: 10,
//                             spreadRadius: 2,
//                           ),
//                         ]
//                             : [],
//                       ),
//                       child: Icon(
//                         item.icon,
//                         size: 24,
//                         color: isSelected
//                             ? Colors.white
//                             : Colors.white.withOpacity(0.7),
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       item.label,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 8,
//                         fontWeight: FontWeight.w500,
//                         color: isSelected
//                             ? Colors.white
//                             : Colors.white.withOpacity(0.7),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
//
//   double getItemPositionX(int visibleIndex, int visibleCount) {
//     final RenderBox? renderBox =
//     widget.scaffoldKey.currentContext?.findRenderObject() as RenderBox?;
//     if (renderBox == null) return 0.0;
//
//     final Offset offset = renderBox.localToGlobal(Offset.zero);
//     final double itemWidth = renderBox.size.width / visibleCount;
//
//     return offset.dx + visibleIndex * itemWidth + itemWidth / 4.5;
//   }
// }
//
// class _BottomItem {
//   final bool isVisible;
//   final IconData icon;
//   final String label;
//   final void Function(int visibleIndex, int visibleCount) onTap;
//
//   _BottomItem({
//     required this.isVisible,
//     required this.icon,
//     required this.label,
//     required this.onTap,
//   });
// }



import 'package:db_atom/index.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final BuildContext context;
  final DisplayMenu displayMenu;

  const CustomBottomNavigationBar({
    super.key,
    required this.displayMenu,
    required this.scaffoldKey,
    required this.context,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState
    extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final displayMenu = widget.displayMenu;

    final List<_BottomItem> items = [
      if ((displayMenu.gM ?? false) ||
          (displayMenu.cD ?? false) ||
          (displayMenu.gR ?? false) ||
          (displayMenu.oCC ?? false) ||
          (displayMenu.sVP ?? false) ||
          (displayMenu.gMR ?? false))
        _BottomItem(
          isVisible: true,
          icon: Icons.person_pin_outlined,
          label: 'Guarding\nOperation',
          onTap: (visibleIndex, visibleCount) {
            BottomMenuHandler(
              context: context,
              displayMenu: displayMenu,
              positionX: getItemPositionX(visibleIndex, visibleCount),
            ).openGuardingOperationSubMenu();
          },
        ),
      if (displayMenu.mM ?? false)
        _BottomItem(
          isVisible: true,
          icon: Icons.supervised_user_circle_sharp,
          label: 'Material\nMovement',
          onTap: (visibleIndex, visibleCount) {
            BottomMenuHandler(
              context: context,
              displayMenu: displayMenu,
              positionX: getItemPositionX(visibleIndex, visibleCount),
            ).openMaterialMovementSubMenu();
          },
        ),
      if (displayMenu.pM ?? false)
        _BottomItem(
          isVisible: true,
          icon: Icons.quick_contacts_mail_rounded,
          label: 'Pass\nManagement',
          onTap: (visibleIndex, visibleCount) {
            BottomMenuHandler(
              context: context,
              displayMenu: displayMenu,
              positionX: getItemPositionX(visibleIndex, visibleCount),
            ).openPassManagementSubMenu();
          },
        ),
      if (displayMenu.keyMM ?? false)
        _BottomItem(
          isVisible: true,
          icon: Icons.key,
          label: 'Key\nManagement',
          onTap: (visibleIndex, visibleCount) {
            BottomMenuHandler(
              context: context,
              displayMenu: displayMenu,
              positionX: getItemPositionX(visibleIndex, visibleCount),
            ).openKeyManagementDataSubMenu();
          },
        ),
      if (displayMenu.sS ?? false)
        _BottomItem(
          isVisible: true,
          icon: Icons.calendar_month,
          label: 'Shift\nScheduling',
          onTap: (visibleIndex, visibleCount) {
            BottomMenuHandler(
              context: context,
              displayMenu: displayMenu,
              positionX: getItemPositionX(visibleIndex, visibleCount),
            ).openShiftScheduleSubMenu();
          },
        ),
      if ((displayMenu.aF ?? false) ||
          (displayMenu.eP ?? false) ||
          (displayMenu.aps ?? false) ||
          (displayMenu.iM ?? false) ||
          (displayMenu.lEO ?? false) ||
          (displayMenu.vIP ?? false))
        _BottomItem(
          isVisible: true,
          icon: Icons.more_horiz,
          label: 'More',
          onTap: (visibleIndex, visibleCount) {
            showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: '',
              transitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (context, animation1, animation2) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Material(
                    color: Colors.transparent,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      // child: const MoreMenuDrawerWidget(),
                    ),
                  ),
                );
              },
              transitionBuilder: (context, animation1, animation2, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation1),
                  child: child,
                );
              },
            );
          },
        ),
    ];

    // Filter only visible items
    final visibleItems = <_BottomItem>[];
    final visibleIndices = <int>[];
    for (int i = 0; i < items.length; i++) {
      if (items[i].isVisible) {
        visibleItems.add(items[i]);
        visibleIndices.add(i);
      }
    }

    return SizedBox(
      height: 95,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background with curved pop-out
          CustomPaint(
            size: const Size(double.infinity, 95),
            painter: _NavBarPainter(
              selectedIndex: selectedIndex,
              itemCount: visibleItems.length,
              backgroundColor: const Color(0xFF5026bc),
            ),
          ),
          // Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(visibleItems.length, (index) {
              final item = visibleItems[index];
              final isSelected = index == selectedIndex;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => selectedIndex = index);
                    final visibleIndex = visibleIndices[index];
                    item.onTap(visibleIndex, visibleItems.length);
                  },
                  child: OverflowBox(
                    maxHeight: double.infinity,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    transform: isSelected
                        ? Matrix4.translationValues(0, -15, 0)
                        : Matrix4.identity(),
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: EdgeInsets.all(isSelected ? 14 : 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: isSelected
                                ? const LinearGradient(
                              colors: [Colors.white70, Color(0xFF0C4C99)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                                : null,
                            boxShadow: isSelected
                                ? [
                              BoxShadow(
                                color: Colors.blueAccent.withOpacity(0.5),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ]
                                : [],
                          ),
                          child: Icon(
                            item.icon,
                            size: isSelected ? 28 : 24,
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.label,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  double getItemPositionX(int visibleIndex, int visibleCount) {
    final RenderBox? renderBox =
    widget.scaffoldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return 0.0;

    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final double itemWidth = renderBox.size.width / visibleCount;

    return offset.dx + visibleIndex * itemWidth + itemWidth / 4.5;
  }
}

class _NavBarPainter extends CustomPainter {
  final int selectedIndex;
  final int itemCount;
  final Color backgroundColor;

  _NavBarPainter({
    required this.selectedIndex,
    required this.itemCount,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = backgroundColor;

    final path = Path();
    double itemWidth = size.width / itemCount;
    double centerX = itemWidth * selectedIndex + itemWidth / 2;
    double curveHeight = 25;

    path.moveTo(0, 0);
    path.lineTo(centerX - 30, 0);
    path.quadraticBezierTo(centerX, -curveHeight, centerX + 30, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _BottomItem {
  final bool isVisible;
  final IconData icon;
  final String label;
  final void Function(int visibleIndex, int visibleCount) onTap;

  _BottomItem({
    required this.isVisible,
    required this.icon,
    required this.label,
    required this.onTap,
  });
}
//
// import 'package:db_atom/index.dart';
// class CustomBottomNavigationBar extends StatefulWidget {
//   final GlobalKey<ScaffoldState> scaffoldKey;
//   final BuildContext context;
//   final DisplayMenu displayMenu;
//
//   const CustomBottomNavigationBar({
//     super.key,
//     required this.displayMenu,
//     required this.scaffoldKey,
//     required this.context,
//   });
//
//   @override
//   State<CustomBottomNavigationBar> createState() =>
//       _CustomBottomNavigationBarState();
// }
//
// class _CustomBottomNavigationBarState
//     extends State<CustomBottomNavigationBar> {
//   int selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     final displayMenu = widget.displayMenu;
//     final scaffoldKey = widget.scaffoldKey;
//
//     final List<_BottomItem> items = [
//       if ((displayMenu.gM ?? false) ||
//           (displayMenu.cD ?? false) ||
//           (displayMenu.gR ?? false) ||
//           (displayMenu.oCC ?? false) ||
//           (displayMenu.sVP ?? false) ||
//           (displayMenu.gMR ?? false))
//         _BottomItem(
//           isVisible: true,
//           icon: Icons.person_pin_outlined,
//           label: 'Guarding\nOperation',
//           onTap: (visibleIndex, visibleCount) {
//             BottomMenuHandler(
//               context: context,
//               displayMenu: displayMenu,
//               positionX: getItemPositionX(visibleIndex, visibleCount),
//             ).openGuardingOperationSubMenu();
//           },
//         ),
//       if (displayMenu.mM ?? false)
//         _BottomItem(
//           isVisible: true,
//           icon: Icons.supervised_user_circle_sharp,
//           label: 'Material\nMovement',
//           onTap: (visibleIndex, visibleCount) {
//             BottomMenuHandler(
//               context: context,
//               displayMenu: displayMenu,
//               positionX: getItemPositionX(visibleIndex, visibleCount),
//             ).openMaterialMovementSubMenu();
//           },
//         ),
//       if (displayMenu.pM ?? false)
//         _BottomItem(
//           isVisible: true,
//           icon: Icons.quick_contacts_mail_rounded,
//           label: 'Pass\nManagement',
//           onTap: (visibleIndex, visibleCount) {
//             BottomMenuHandler(
//               context: context,
//               displayMenu: displayMenu,
//               positionX: getItemPositionX(visibleIndex, visibleCount),
//             ).openPassManagementSubMenu();
//           },
//         ),
//       if (displayMenu.keyMM ?? false)
//         _BottomItem(
//           isVisible: true,
//           icon: Icons.key,
//           label: 'Key\nManagement',
//           onTap: (visibleIndex, visibleCount) {
//             BottomMenuHandler(
//               context: context,
//               displayMenu: displayMenu,
//               positionX: getItemPositionX(visibleIndex, visibleCount),
//             ).openKeyManagementDataSubMenu();
//           },
//         ),
//       if (displayMenu.sS ?? false)
//         _BottomItem(
//           isVisible: true,
//           icon: Icons.calendar_month,
//           label: 'Shift\nScheduling',
//           onTap: (visibleIndex, visibleCount) {
//             BottomMenuHandler(
//               context: context,
//               displayMenu: displayMenu,
//               positionX: getItemPositionX(visibleIndex, visibleCount),
//             ).openShiftScheduleSubMenu();
//           },
//         ),
//       if ((displayMenu.aF ?? false) ||
//           (displayMenu.eP ?? false) ||
//           (displayMenu.aps ?? false) ||
//           (displayMenu.iM ?? false) ||
//           (displayMenu.lEO ?? false) ||
//           (displayMenu.vIP ?? false))
//         _BottomItem(
//           isVisible: true,
//           icon: Icons.more_horiz,
//           label: 'More',
//           onTap: (visibleIndex, visibleCount) {
//             showGeneralDialog(
//               context: context,
//               barrierDismissible: true,
//               barrierLabel: '',
//               transitionDuration: const Duration(milliseconds: 300),
//               pageBuilder: (context, animation1, animation2) {
//                 return Align(
//                   alignment: Alignment.centerRight,
//                   child: Material(
//                     color: Colors.transparent,
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.75,
//                       // child: const MoreMenuDrawerWidget(),
//                     ),
//                   ),
//                 );
//               },
//               transitionBuilder: (context, animation1, animation2, child) {
//                 return SlideTransition(
//                   position: Tween<Offset>(
//                     begin: const Offset(1, 0),
//                     end: Offset.zero,
//                   ).animate(animation1),
//                   child: child,
//                 );
//               },
//             );
//           },
//         ),
//     ];
//
//     // Filter only visible items
//     final visibleItems = <_BottomItem>[];
//     final visibleIndices = <int>[];
//     for (int i = 0; i < items.length; i++) {
//       if (items[i].isVisible) {
//         visibleItems.add(items[i]);
//         visibleIndices.add(i);
//       }
//     }
//
//     return Container(
//       height: 95,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [const Color(0xFF5026bc), const Color(0xFF5026bc)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(0),
//           topRight: Radius.circular(0),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.6),
//             blurRadius: 12,
//             offset: const Offset(0, -3),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: List.generate(visibleItems.length, (index) {
//           final item = visibleItems[index];
//           final isSelected = index == selectedIndex;
//
//           return Expanded(
//             child: GestureDetector(
//               onTap: () {
//                 setState(() => selectedIndex = index);
//                 final visibleIndex = visibleIndices[index];
//                 item.onTap(visibleIndex, visibleItems.length);
//               },
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 curve: Curves.easeInOut,
//                 padding:
//                 const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
//                 decoration: const BoxDecoration(
//                   color: Colors.transparent,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         gradient: isSelected
//                             ? const LinearGradient(
//                           colors: [Colors.white70, Colors.blueAccent,Color(0xFF0C4C99)],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         )
//                             : null,
//                         boxShadow: isSelected
//                             ? [
//                           BoxShadow(
//                             color: Colors.blueAccent.withOpacity(0.5),
//                             blurRadius: 10,
//                             spreadRadius: 2,
//                           ),
//                         ]
//                             : [],
//                       ),
//                       child: Icon(
//                         item.icon,
//                         size: 24,
//                         color: isSelected
//                             ? Colors.white
//                             : Colors.white.withOpacity(0.7),
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       item.label,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 8,
//                         fontWeight: FontWeight.w500,
//                         color: isSelected
//                             ? Colors.white
//                             : Colors.white.withOpacity(0.7),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
//
//   double getItemPositionX(int visibleIndex, int visibleCount) {
//     final RenderBox? renderBox =
//     widget.scaffoldKey.currentContext?.findRenderObject() as RenderBox?;
//     if (renderBox == null) return 0.0;
//
//     final Offset offset = renderBox.localToGlobal(Offset.zero);
//     final double itemWidth = renderBox.size.width / visibleCount;
//
//     return offset.dx + visibleIndex * itemWidth + itemWidth / 4.5;
//   }
// }
//
// class _BottomItem {
//   final bool isVisible;
//   final IconData icon;
//   final String label;
//   final void Function(int visibleIndex, int visibleCount) onTap;
//
//   _BottomItem({
//     required this.isVisible,
//     required this.icon,
//     required this.label,
//     required this.onTap,
//   });
// }
