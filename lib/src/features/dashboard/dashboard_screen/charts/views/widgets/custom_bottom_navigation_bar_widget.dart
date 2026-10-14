// //
// // import 'dart:ui';
// // import '../../../../../../../index.dart';
// //
// // class CustomBottomNavigationBar extends StatefulWidget {
// //   final GlobalKey<ScaffoldState> scaffoldKey;
// //   final BuildContext context;
// //   final DisplayMenu? displayMenu;
// //   final VoidCallback? onAddPressed;
// //   final bool hasAddPermission;
// //   final bool list;
// //
// //   const CustomBottomNavigationBar({
// //     super.key,
// //     required this.scaffoldKey,
// //     required this.context,
// //     this.displayMenu,
// //     this.list = false,
// //     this.onAddPressed,
// //     required this.hasAddPermission,
// //   });
// //
// //   @override
// //   State<CustomBottomNavigationBar> createState() =>
// //       _CustomBottomNavigationBarState();
// // }
// //
// // class _CustomBottomNavigationBarState
// //     extends State<CustomBottomNavigationBar> {
// //   int selectedIndex = 1;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     /// ================================
// //     /// LIST MODE (Home + Add + Chat)
// //     /// ================================
// //     if (widget.list) {
// //       return SizedBox(
// //         // height: 120,
// //         height: kBottomNavigationBarHeight + 60,
// //         // height: MediaQuery.of(context).size.height * 0.14,
// //         width: double.infinity,
// //         child: ClipRect(
// //           child: BackdropFilter(
// //             filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
// //             child: Container(
// //               decoration: const BoxDecoration(
// //                 color: Colors.transparent,
// //                 border: Border(
// //                   top: BorderSide(
// //                     color: Colors.white30,
// //                     width: 0.6,
// //                   ),
// //                 ),
// //               ),
// //               // decoration: BoxDecoration(
// //               //   color: Colors.white.withOpacity(0.08),
// //               //   border: const Border(
// //               //     top: BorderSide(
// //               //       color: Colors.white30,
// //               //       width: 0.6,
// //               //     ),
// //               //   ),
// //               // ),
// //               child: SafeArea(
// //                 top: false,
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                   children: List.generate(3, (index) {
// //                     final items = [
// //                       {'icon': Icons.home_rounded, 'label': 'Home'},
// //                       {
// //                         'icon': widget.hasAddPermission
// //                             ? Icons.add
// //                             : Icons.cancel,
// //                         'label': widget.hasAddPermission
// //                             ? 'Add'
// //                             : 'Blocked'
// //                       },
// //                       {'icon': Icons.chat, 'label': 'Chat'},
// //                     ];
// //
// //                     final item = items[index];
// //                     final isSelected = selectedIndex == index;
// //
// //                     return Expanded(
// //                       child: GestureDetector(
// //                         onTap: () {
// //                           setState(() => selectedIndex = index);
// //
// //                           if (index == 0) {
// //                             Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                 builder: (_) => const DashboardView(),
// //                               ),
// //                             );
// //                           } else if (index == 1) {
// //                             widget.onAddPressed?.call();
// //                           } else {
// //                             Navigator.pushNamed(
// //                               context,
// //                               aiChatDetailsRoute,
// //                               arguments: {"title": 'AI Chat Details'},
// //                             );
// //                           }
// //                         },
// //                         child: Column(
// //                           mainAxisSize: MainAxisSize.min,
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             AnimatedContainer(
// //                               duration:
// //                               const Duration(milliseconds: 200),
// //                               padding:
// //                               EdgeInsets.all(isSelected ? 12 : 6),
// //                               decoration: BoxDecoration(
// //                                 shape: BoxShape.circle,
// //                                 color: AppColors.newColor.withValues(alpha:
// //                                   isSelected ? 0.8 : 0,
// //                                 ),
// //                                 border: Border.all(
// //                                   color: Colors.white30,
// //                                 ),
// //                               ),
// //                               child: Icon(
// //                                 item['icon'] as IconData,
// //                                 color: Colors.white,
// //                                 size: isSelected ? 28 : 22,
// //                               ),
// //                             ),
// //                             const SizedBox(height: 2),
// //                             FittedBox(
// //                               child: Text(
// //                                 item['label'] as String,
// //                                 textAlign: TextAlign.center,
// //                                 maxLines: 2,
// //                                 style: TextStyle(
// //                                   fontSize: MediaQuery.of(context).size.width * 0.028,
// //                                   color: Colors.white,
// //                                 ),
// //                               ),
// //                             ),
// //                             // Text(
// //                             //   item['label'] as String,
// //                             //   style: const TextStyle(
// //                             //     fontSize: 10,
// //                             //     color: Colors.white,
// //                             //   ),
// //                             // ),
// //                           ],
// //                         ),
// //                       ),
// //                     );
// //                   }),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       );
// //     }
// //
// //     /// ================================
// //     /// NORMAL MODE (FULL MENU)
// //     /// ================================
// //     final displayMenu = widget.displayMenu;
// //
// //     final List<_BottomItem> items = [
// //       if ((displayMenu!.gM ?? false) ||
// //           (displayMenu.cD ?? false) ||
// //           (displayMenu.gR ?? false) ||
// //           (displayMenu.oCC ?? false) ||
// //           (displayMenu.sVP ?? false) ||
// //           (displayMenu.gMR ?? false))
// //         _BottomItem(
// //           isVisible: true,
// //           icon: Icons.person_pin_outlined,
// //           label: 'Guarding\nOperation',
// //           onTap: (visibleIndex, visibleCount) {
// //             BottomMenuHandler(
// //               context: context,
// //               displayMenu: displayMenu,
// //               positionX: getItemPositionX(
// //                 visibleIndex,
// //                 visibleCount,
// //               ),
// //             ).openGuardingOperationSubMenu();
// //           },
// //         ),
// //       if (displayMenu.mM ?? false)
// //         _BottomItem(
// //           isVisible: true,
// //           icon: Icons.supervised_user_circle_sharp,
// //           label: 'Material\nMovement',
// //           onTap: (visibleIndex, visibleCount) {
// //             BottomMenuHandler(
// //               context: context,
// //               displayMenu: displayMenu,
// //               positionX: getItemPositionX(
// //                 visibleIndex,
// //                 visibleCount,
// //               ),
// //             ).openMaterialMovementSubMenu();
// //           },
// //         ),
// //       if (displayMenu.pM ?? false)
// //         _BottomItem(
// //           isVisible: true,
// //           icon: Icons.quick_contacts_mail_rounded,
// //           label: 'Pass\nManagement',
// //           onTap: (visibleIndex, visibleCount) {
// //             BottomMenuHandler(
// //               context: context,
// //               displayMenu: displayMenu,
// //               positionX: getItemPositionX(
// //                 visibleIndex,
// //                 visibleCount,
// //               ),
// //             ).openPassManagementSubMenu();
// //           },
// //         ),
// //       if (displayMenu.keyMM ?? false)
// //         _BottomItem(
// //           isVisible: true,
// //           icon: Icons.key,
// //           label: 'Key\nManagement',
// //           onTap: (visibleIndex, visibleCount) {
// //             BottomMenuHandler(
// //               context: context,
// //               displayMenu: displayMenu,
// //               positionX: getItemPositionX(
// //                 visibleIndex,
// //                 visibleCount,
// //               ),
// //             ).openKeyManagementDataSubMenu();
// //           },
// //         ),
// //       if (displayMenu.sS ?? false)
// //         _BottomItem(
// //           isVisible: true,
// //           icon: Icons.calendar_month,
// //           label: 'Shift\nScheduling',
// //           onTap: (visibleIndex, visibleCount) {
// //             BottomMenuHandler(
// //               context: context,
// //               displayMenu: displayMenu,
// //               positionX: getItemPositionX(
// //                 visibleIndex,
// //                 visibleCount,
// //               ),
// //             ).openShiftScheduleSubMenu();
// //           },
// //         ),
// //     ];
// //
// //     final visibleItems =
// //     items.where((item) => item.isVisible).toList();
// //
// //     final visibleIndices = [
// //       for (int i = 0; i < items.length; i++)
// //         if (items[i].isVisible) i,
// //     ];
// //
// //     return SizedBox(
// //       height: 125,
// //       width: double.infinity,
// //       child: ClipRect(
// //         child: BackdropFilter(
// //           filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
// //           child: Container(
// //             decoration:  BoxDecoration(
// //               color: AppColors.navy,
// //               border: const Border(
// //                 top: BorderSide(
// //                   color: Colors.white,
// //                   width: 0.4,
// //                 ),
// //               ),
// //             ),
// //             child: SafeArea(
// //               top: false,
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                 children: List.generate(visibleItems.length, (index) {
// //                   final item = visibleItems[index];
// //                   final isSelected = selectedIndex == index;
// //
// //                   return Expanded(
// //                     child: GestureDetector(
// //                       onTap: () {
// //                         setState(() => selectedIndex = index);
// //                         item.onTap(
// //                           visibleIndices[index],
// //                           visibleItems.length,
// //                         );
// //                       },
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           AnimatedContainer(
// //                             duration:
// //                             const Duration(milliseconds: 200),
// //                             padding:
// //                             EdgeInsets.all(isSelected ? 12 : 8),
// //                             decoration: BoxDecoration(
// //                               shape: BoxShape.circle,
// //                               color: AppColors.newColor.withValues(alpha:
// //                                 isSelected ? 0.8 : 0,
// //                               ),
// //                               border: Border.all(
// //                                 color: Colors.white30,
// //                               ),
// //                             ),
// //                             child: Icon(
// //                               item.icon,
// //                               size: isSelected ? 28 : 24,
// //                               color: Colors.white,
// //                             ),
// //                           ),
// //                           const SizedBox(height: 4),
// //                           Text(
// //                             item.label,
// //                             textAlign: TextAlign.center,
// //                             style: const TextStyle(
// //                               fontSize: 10,
// //                               color: Colors.white,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   );
// //                 }),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //
// // double getItemPositionX(
// //     int visibleIndex, int visibleCount) {
// //   final RenderBox? renderBox =
// //   widget.scaffoldKey.currentContext
// //       ?.findRenderObject() as RenderBox?;
// //   if (renderBox == null) return 0;
// //   final Offset offset =
// //   renderBox.localToGlobal(Offset.zero);
// //   final double itemWidth =
// //       renderBox.size.width / visibleCount;
// //   return offset.dx +
// //       visibleIndex * itemWidth +
// //       itemWidth / 4.5;
// // }
// // }
// //
// // class _BottomItem {
// //   final bool isVisible;
// //   final IconData icon;
// //   final String label;
// //   final void Function(int, int) onTap;
// //
// //   _BottomItem({
// //     required this.isVisible,
// //     required this.icon,
// //     required this.label,
// //     required this.onTap,
// //   });
// // }
//
// import 'dart:ui';
// import '../../../../../../../index.dart';
//
// class _NavTheme {
//   static const Color navy = Color(0xFF14086B);
//   static const Color navyDark = Color(0xFF0B0450);
//   static const Color navyMid = Color(0xFF1E0F8A);
//   static const Color gold = Color(0xFFB8895A);
//   static const Color goldLight = Color(0xFFE6CFB0);
//   static const Color goldBorder = Color(0xFFC9A98A);
//   static const Color cardBorder = Color(0xFFE8DFD0);
//   static const Color labelGrey = Color(0xFF8A8499);
// }
//
// class CustomBottomNavigationBar extends StatefulWidget {
//   final GlobalKey<ScaffoldState> scaffoldKey;
//   final BuildContext context;
//   final DisplayMenu? displayMenu;
//   final VoidCallback? onAddPressed;
//   final bool hasAddPermission;
//   final bool list;
//
//   const CustomBottomNavigationBar({
//     super.key,
//     required this.scaffoldKey,
//     required this.context,
//     this.displayMenu,
//     this.list = false,
//     this.onAddPressed,
//     required this.hasAddPermission,
//   });
//
//   @override
//   State<CustomBottomNavigationBar> createState() =>
//       _CustomBottomNavigationBarState();
// }
//
// class _CustomBottomNavigationBarState
//     extends State<CustomBottomNavigationBar> {
//   int selectedIndex = 1;
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.list) return _buildListBar(context);
//     return _buildMenuBar(context);
//   }
//
//   // ===========================================================================
//   // LIST MODE (Home + Add + Chat): floating cream pill bar
//   // ===========================================================================
//   Widget _buildListBar(BuildContext context) {
//     final items = [
//       {'icon': Icons.home_rounded, 'label': 'Home'},
//       {
//         'icon': widget.hasAddPermission ? Icons.add_rounded : Icons.block_rounded,
//         'label': widget.hasAddPermission ? 'Add' : 'Blocked',
//       },
//       {'icon': Icons.chat_bubble_rounded, 'label': 'Chat'},
//     ];
//
//     return SafeArea(
//       top: false,
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(32),
//             boxShadow: [
//               BoxShadow(
//                 color: _NavTheme.navy.withValues(alpha: 0.18),
//                 blurRadius: 26,
//                 offset: const Offset(0, 10),
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(32),
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//               child: Container(
//                 height: 76,
//                 decoration: BoxDecoration(
//                   color: Colors.white.withValues(alpha: 0.94),
//                   borderRadius: BorderRadius.circular(32),
//                   border: Border.all(
//                     color: _NavTheme.goldBorder.withValues(alpha: 0.7),
//                     width: 1.2,
//                   ),
//                 ),
//                 child: Row(
//                   children: List.generate(3, (index) {
//                     final item = items[index];
//                     final isSelected = selectedIndex == index;
//                     final isAdd = index == 1;
//
//                     return Expanded(
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(24),
//                         onTap: () {
//                           HapticFeedback.selectionClick();
//                           setState(() => selectedIndex = index);
//
//                           if (index == 0) {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => const DashboardView(),
//                               ),
//                             );
//                           } else if (index == 1) {
//                             widget.onAddPressed?.call();
//                           } else {
//                             Navigator.pushNamed(
//                               context,
//                               aiChatDetailsRoute,
//                               arguments: {"title": 'AI Chat Details'},
//                             );
//                           }
//                         },
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             isAdd
//                                 ? _addButton(item['icon'] as IconData)
//                                 : _listBubble(
//                                 item['icon'] as IconData, isSelected),
//                             if (!isAdd) ...[
//                               const SizedBox(height: 3),
//                               Text(
//                                 item['label'] as String,
//                                 style: TextStyle(
//                                   fontSize: 11,
//                                   fontWeight: isSelected
//                                       ? FontWeight.w800
//                                       : FontWeight.w600,
//                                   color: isSelected
//                                       ? _NavTheme.navy
//                                       : _NavTheme.labelGrey,
//                                 ),
//                               ),
//                             ],
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _listBubble(IconData icon, bool selected) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 220),
//       curve: Curves.easeOut,
//       height: selected ? 42 : 36,
//       width: selected ? 42 : 36,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         gradient: selected
//             ? const LinearGradient(
//           colors: [_NavTheme.goldLight, _NavTheme.gold],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         )
//             : null,
//         boxShadow: selected
//             ? [
//           BoxShadow(
//             color: _NavTheme.gold.withValues(alpha: 0.45),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ]
//             : null,
//       ),
//       child: Icon(
//         icon,
//         size: selected ? 23 : 22,
//         color: selected ? Colors.white : _NavTheme.navyMid,
//       ),
//     );
//   }
//
//   Widget _addButton(IconData icon) {
//     final enabled = widget.hasAddPermission;
//     return Container(
//       height: 52,
//       width: 52,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         gradient: LinearGradient(
//           colors: enabled
//               ? const [_NavTheme.navyMid, _NavTheme.navyDark]
//               : [Colors.grey.shade500, Colors.grey.shade700],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         border: Border.all(
//           color: enabled ? _NavTheme.goldBorder : Colors.grey.shade300,
//           width: 2,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: (enabled ? _NavTheme.navy : Colors.grey)
//                 .withValues(alpha: 0.35),
//             blurRadius: 14,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Icon(icon, color: Colors.white, size: 28),
//     );
//   }
//
//   // ===========================================================================
//   // NORMAL MODE (full menu): navy bar with a gold edge
//   // ===========================================================================
//   Widget _buildMenuBar(BuildContext context) {
//     final displayMenu = widget.displayMenu;
//
//     final List<_BottomItem> items = [
//       if ((displayMenu!.gM ?? false) ||
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
//     ];
//
//     final visibleItems = items.where((item) => item.isVisible).toList();
//
//     final visibleIndices = [
//       for (int i = 0; i < items.length; i++)
//         if (items[i].isVisible) i,
//     ];
//
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
//         gradient: const LinearGradient(
//           colors: [_NavTheme.navyMid, _NavTheme.navyDark],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: _NavTheme.navy.withValues(alpha: 0.35),
//             blurRadius: 24,
//             offset: const Offset(0, -6),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Gold edge
//             Container(
//               height: 3,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     _NavTheme.gold,
//                     _NavTheme.goldLight,
//                     _NavTheme.gold,
//                   ],
//                 ),
//               ),
//             ),
//             SafeArea(
//               top: false,
//               child: SizedBox(
//                 height: 112,
//                 child: Row(
//                   children: List.generate(visibleItems.length, (index) {
//                     final item = visibleItems[index];
//                     final isSelected = selectedIndex == index;
//
//                     return Expanded(
//                       child: InkWell(
//                         onTap: () {
//                           HapticFeedback.selectionClick();
//                           setState(() => selectedIndex = index);
//                           item.onTap(
//                             visibleIndices[index],
//                             visibleItems.length,
//                           );
//                         },
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             AnimatedContainer(
//                               duration: const Duration(milliseconds: 220),
//                               curve: Curves.easeOut,
//                               height: isSelected ? 52 : 44,
//                               width: isSelected ? 52 : 44,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 gradient: isSelected
//                                     ? const LinearGradient(
//                                   colors: [
//                                     _NavTheme.goldLight,
//                                     _NavTheme.gold,
//                                   ],
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                 )
//                                     : null,
//                                 color: isSelected
//                                     ? null
//                                     : Colors.white.withValues(alpha: 0.08),
//                                 border: Border.all(
//                                   color: isSelected
//                                       ? Colors.white.withValues(alpha: 0.8)
//                                       : Colors.white.withValues(alpha: 0.2),
//                                   width: 1.2,
//                                 ),
//                                 boxShadow: isSelected
//                                     ? [
//                                   BoxShadow(
//                                     color: _NavTheme.gold
//                                         .withValues(alpha: 0.5),
//                                     blurRadius: 14,
//                                     offset: const Offset(0, 4),
//                                   ),
//                                 ]
//                                     : null,
//                               ),
//                               child: Icon(
//                                 item.icon,
//                                 size: isSelected ? 27 : 23,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             const SizedBox(height: 6),
//                             Text(
//                               item.label,
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: 10.5,
//                                 height: 1.2,
//                                 fontWeight: isSelected
//                                     ? FontWeight.w800
//                                     : FontWeight.w600,
//                                 color: isSelected
//                                     ? _NavTheme.goldLight
//                                     : Colors.white70,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   double getItemPositionX(int visibleIndex, int visibleCount) {
//     final RenderBox? renderBox =
//     widget.scaffoldKey.currentContext?.findRenderObject() as RenderBox?;
//     if (renderBox == null) return 0;
//     final Offset offset = renderBox.localToGlobal(Offset.zero);
//     final double itemWidth = renderBox.size.width / visibleCount;
//     return offset.dx + visibleIndex * itemWidth + itemWidth / 4.5;
//   }
// }
//
// class _BottomItem {
//   final bool isVisible;
//   final IconData icon;
//   final String label;
//   final void Function(int, int) onTap;
//
//   _BottomItem({
//     required this.isVisible,
//     required this.icon,
//     required this.label,
//     required this.onTap,
//   });
// }

import 'dart:ui';
import '../../../../../../../index.dart';

class _NavTheme {
  static const Color navy = Color(0xFF14086B);
  static const Color navyDark = Color(0xFF0B0450);
  static const Color navyMid = Color(0xFF1E0F8A);
  static const Color gold = Color(0xFFB8895A);
  static const Color goldLight = Color(0xFFE6CFB0);
  static const Color goldBorder = Color(0xFFC9A98A);
  static const Color cardBorder = Color(0xFFE8DFD0);
  static const Color labelGrey = Color(0xFF8A8499);
}

class CustomBottomNavigationBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final BuildContext context;
  final DisplayMenu? displayMenu;
  final VoidCallback? onAddPressed;
  final bool hasAddPermission;
  final bool list;

  const CustomBottomNavigationBar({
    super.key,
    required this.scaffoldKey,
    required this.context,
    this.displayMenu,
    this.list = false,
    this.onAddPressed,
    required this.hasAddPermission,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState
    extends State<CustomBottomNavigationBar> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    if (widget.list) return _buildListBar(context);
    return _buildMenuBar(context);
  }

  // ===========================================================================
  // LIST MODE (Home + Add + Chat): solid navy floating bar, raised gold Add
  // ===========================================================================
  void _onListTap(BuildContext context, int index) {
    HapticFeedback.selectionClick();
    setState(() => selectedIndex = index);

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const DashboardView()),
      );
    } else if (index == 1) {
      widget.onAddPressed?.call();
    } else {
      Navigator.pushNamed(
        context,
        aiChatDetailsRoute,
        arguments: {"title": 'AI Chat Details'},
      );
    }
  }

  Widget _buildListBar(BuildContext context) {
    const double barHeight = 72;
    const double addSize = 64;
    const double lift = 26; // how far the Add button rises above the bar

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
        child: SizedBox(
          height: barHeight + lift,
          child: Stack(
            children: [
              // Navy bar
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: barHeight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [_NavTheme.navyMid, _NavTheme.navyDark],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: _NavTheme.goldBorder.withValues(alpha: 0.8),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _NavTheme.navy.withValues(alpha: 0.45),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _listItem(
                          context,
                          index: 0,
                          icon: Icons.home_rounded,
                          label: 'Home',
                        ),
                      ),
                      // Middle slot: just the "Add" label (button floats above)
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 9),
                            child: Text(
                              widget.hasAddPermission ? 'Add' : 'Blocked',
                              style: const TextStyle(
                                color: _NavTheme.goldLight,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: _listItem(
                          context,
                          index: 2,
                          icon: Icons.chat_bubble_rounded,
                          label: 'Chat',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Raised Add button
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(child: _raisedAdd(context, addSize)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listItem(
      BuildContext context, {
        required int index,
        required IconData icon,
        required String label,
      }) {
    final selected = selectedIndex == index;
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () => _onListTap(context, index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            height: 38,
            width: selected ? 52 : 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: selected
                  ? const LinearGradient(
                colors: [_NavTheme.goldLight, _NavTheme.gold],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
                  : null,
              boxShadow: selected
                  ? [
                BoxShadow(
                  color: _NavTheme.gold.withValues(alpha: 0.5),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
                  : null,
            ),
            child: Icon(
              icon,
              size: 22,
              color: selected ? Colors.white : Colors.white70,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
              color: selected ? _NavTheme.goldLight : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _raisedAdd(BuildContext context, double size) {
    final enabled = widget.hasAddPermission;
    return GestureDetector(
      onTap: () => _onListTap(context, 1),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: enabled
                ? const [_NavTheme.goldLight, _NavTheme.gold]
                : [Colors.grey.shade400, Colors.grey.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            BoxShadow(
              color: (enabled ? _NavTheme.gold : Colors.grey)
                  .withValues(alpha: 0.55),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Icon(
          enabled ? Icons.add_rounded : Icons.block_rounded,
          color: Colors.white,
          size: 34,
        ),
      ),
    );
  }

  // ===========================================================================
  // NORMAL MODE (full menu): navy bar with a gold edge
  // ===========================================================================
  Widget _buildMenuBar(BuildContext context) {
    final displayMenu = widget.displayMenu;

    final List<_BottomItem> items = [
      if ((displayMenu!.gM ?? false) ||
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
    ];

    final visibleItems = items.where((item) => item.isVisible).toList();

    final visibleIndices = [
      for (int i = 0; i < items.length; i++)
        if (items[i].isVisible) i,
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
        gradient: const LinearGradient(
          colors: [_NavTheme.navyMid, _NavTheme.navyDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: _NavTheme.navy.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Gold edge
            Container(
              height: 3,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _NavTheme.gold,
                    _NavTheme.goldLight,
                    _NavTheme.gold,
                  ],
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: SizedBox(
                height: 112,
                child: Row(
                  children: List.generate(visibleItems.length, (index) {
                    final item = visibleItems[index];
                    final isSelected = selectedIndex == index;

                    return Expanded(
                      child: InkWell(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          setState(() => selectedIndex = index);
                          item.onTap(
                            visibleIndices[index],
                            visibleItems.length,
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              curve: Curves.easeOut,
                              height: isSelected ? 52 : 44,
                              width: isSelected ? 52 : 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: isSelected
                                    ? const LinearGradient(
                                  colors: [
                                    _NavTheme.goldLight,
                                    _NavTheme.gold,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                                    : null,
                                color: isSelected
                                    ? null
                                    : Colors.white.withValues(alpha: 0.08),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.white.withValues(alpha: 0.8)
                                      : Colors.white.withValues(alpha: 0.2),
                                  width: 1.2,
                                ),
                                boxShadow: isSelected
                                    ? [
                                  BoxShadow(
                                    color: _NavTheme.gold
                                        .withValues(alpha: 0.5),
                                    blurRadius: 14,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                                    : null,
                              ),
                              child: Icon(
                                item.icon,
                                size: isSelected ? 27 : 23,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item.label,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10.5,
                                height: 1.2,
                                fontWeight: isSelected
                                    ? FontWeight.w800
                                    : FontWeight.w600,
                                color: isSelected
                                    ? _NavTheme.goldLight
                                    : Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getItemPositionX(int visibleIndex, int visibleCount) {
    final RenderBox? renderBox =
    widget.scaffoldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return 0;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final double itemWidth = renderBox.size.width / visibleCount;
    return offset.dx + visibleIndex * itemWidth + itemWidth / 4.5;
  }
}

class _BottomItem {
  final bool isVisible;
  final IconData icon;
  final String label;
  final void Function(int, int) onTap;

  _BottomItem({
    required this.isVisible,
    required this.icon,
    required this.label,
    required this.onTap,
  });
}