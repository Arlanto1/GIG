// // import 'dart:ui';
// //
// // import 'package:db_atom/index.dart';
// //
// // class FloatingSubMenuWidget extends StatelessWidget {
// //   final List<MenuItem> menuItems;
// //   final void Function(BuildContext context, int index) onOptionSelected;
// //   final double positionX;
// //
// //   const FloatingSubMenuWidget({
// //     super.key,
// //     required this.menuItems,
// //     required this.onOptionSelected,
// //     required this.positionX,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //
// //     return Positioned(
// //       bottom: 110.0,
// //       left: (MediaQuery.of(context).size.width -
// //           (MediaQuery.of(context).size.width - 160)) /
// //           2, // Perfect center
// //       child: Material(
// //         color: Colors.white,
// //         child: ClipRRect(
// //           borderRadius: BorderRadius.circular(28),
// //           child: BackdropFilter(
// //             filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
// //             child: Container(
// //               width: MediaQuery.of(context).size.width - 160,
// //               padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
// //               decoration: BoxDecoration(
// //                 // gradient: LinearGradient(
// //                 //   colors: [
// //                 //     .peachGlowColor.withValues(alpha: 0.04),
// //                 //     AppColors.peachGlowColor.withValues(alpha: 0.04),
// //                 //   ],
// //                 //   begin: Alignment.topLeft,
// //                 //   end: Alignment.bottomRight,
// //                 // ),
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(28),
// //                 border: Border.all(
// //                   color: Colors.white.withValues(alpha: 0.35),
// //                   width: 1.2,
// //                 ),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: AppColors.peachGlowColor.withValues(alpha: 0.15),
// //                     blurRadius: 18,
// //                     spreadRadius: -4,
// //                     offset: const Offset(0, 12),
// //                   ),
// //                 ],
// //               ),
// //               child: Column(
// //                 children: menuItems.asMap().entries.map((entry) {
// //                   int index = entry.key;
// //                   MenuItem item = entry.value;
// //
// //                   return Container(
// //                     margin: const EdgeInsets.symmetric(vertical: 6), // spacing
// //                     child: InkWell(
// //                       onTap: () {
// //                         Navigator.of(context).pop();
// //                         onOptionSelected(context, index);
// //                       },
// //                       borderRadius: BorderRadius.circular(25),
// //                       child: Container(
// //                         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
// //                         decoration: BoxDecoration(
// //                           // gradient: LinearGradient(
// //                           //   colors: [
// //                           //     Colors.white.withValues(alpha: 0.2),
// //                           //     Colors.transparent,
// //                           //     Colors.white.withValues(alpha: 0.2),
// //                           //     // Color(0xFF6474C6).withOpacity(0.14)
// //                           //   ],
// //                           //   stops: const [0.02, 0.35, 1],
// //                           //   begin: Alignment.topCenter,
// //                           //   end: Alignment.bottomCenter
// //                           // ),
// //                           color: AppColors.navy.withValues(alpha: 0.8),
// //                           borderRadius: BorderRadius.circular(40),
// //                           border: Border.all(
// //                             color: Colors.white.withValues(alpha: 0.80),
// //                             width: 0.8,
// //                           ),
// //                           boxShadow: [
// //                             BoxShadow(
// //                               color: AppColors.peachGlowColor.withValues(alpha: 0.1),
// //                               blurRadius: 12,
// //                               offset: const Offset(0, 2),
// //                             ),
// //                           ],
// //                         ),
// //                         child: Row(
// //                           children: [
// //                             Image.asset(
// //                               item.imageName,
// //                               height: 22,
// //                               width: 22,
// //                               color: Colors.white,
// //                             ),
// //                             const SizedBox(width: 14),
// //                             Expanded(
// //                               child: Text(
// //                                 item.title,
// //                                 style: const TextStyle(
// //                                   color: Colors.white,
// //                                   fontSize: 15,
// //                                   fontWeight: FontWeight.w600,
// //                                   letterSpacing: 0.4,
// //                                 ),
// //                               ),
// //                             ),
// //                             const Icon(
// //                               Icons.arrow_right,
// //                               color: Colors.white70,
// //                               size: 20,
// //                             )
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   );
// //                 }).toList(),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //
// //   }
// // }
//
//
// import 'dart:math' as math;
//
// import 'package:db_atom/index.dart';
//
// class FloatingSubMenuWidget extends StatelessWidget {
//   final List<MenuItem> menuItems;
//   final void Function(BuildContext context, int index) onOptionSelected;
//   final double positionX;
//
//   /// Heading of the tapped bottom-nav tab, e.g. "Material Movement".
//   final String title;
//
//   /// Index of the item shown in the filled (selected) state.
//   /// Pass -1 for no highlighted item.
//   final int selectedIndex;
//
//   const FloatingSubMenuWidget({
//     super.key,
//     required this.menuItems,
//     required this.onOptionSelected,
//     required this.positionX,
//     required this.title,
//     this.selectedIndex = -1,
//   });
//
//   static const double _sideMargin = 24;
//   static const double _notchSize = 20;
//   static const Color _accent = Color(0xFFC8742A);
//
//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double cardWidth = screenWidth - (_sideMargin * 2);
//
//     // Keeps the pointer under the tapped tab and inside the card's corners.
//     final double notchLeft = (positionX - _sideMargin - (_notchSize / 2))
//         .clamp(28.0, cardWidth - _notchSize - 28.0);
//
//     return Positioned(
//       bottom: 110,
//       left: _sideMargin,
//       right: _sideMargin,
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           // Pointer toward the tapped bottom-nav tab (drawn behind the card).
//           Positioned(
//             bottom: -8,
//             left: notchLeft,
//             child: Transform.rotate(
//               angle: math.pi / 4,
//               child: Container(
//                 width: _notchSize,
//                 height: _notchSize,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               ),
//             ),
//           ),
//           Material(
//             color: Colors.white,
//             elevation: 16,
//             shadowColor: AppColors.navy.withValues(alpha: 0.35),
//             borderRadius: BorderRadius.circular(28),
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(14, 18, 14, 14),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildHeader(),
//                   const SizedBox(height: 10),
//                   ...menuItems.asMap().entries.map((entry) {
//                     final int index = entry.key;
//                     return _SubMenuTile(
//                       item: entry.value,
//                       isSelected: index == selectedIndex,
//                       onTap: () {
//                         Navigator.of(context).pop();
//                         onOptionSelected(context, index);
//                       },
//                     );
//                   }),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               color: AppColors.navy,
//               fontSize: 18,
//               fontWeight: FontWeight.w800,
//             ),
//           ),
//           const SizedBox(height: 6),
//           Container(
//             width: 90,
//             height: 3,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(colors: [AppColors.navy, _accent]),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _SubMenuTile extends StatelessWidget {
//   final MenuItem item;
//   final bool isSelected;
//   final VoidCallback onTap;
//
//   const _SubMenuTile({
//     required this.item,
//     required this.isSelected,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final Color contentColor = isSelected ? Colors.white : AppColors.navy;
//
//     return Padding(
//       padding: const EdgeInsets.only(top: 4),
//       child: Material(
//         color: isSelected ? AppColors.navy : Colors.transparent,
//         borderRadius: BorderRadius.circular(18),
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(18),
//           child: Container(
//             height: 60,
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Row(
//               children: [
//                 Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: isSelected
//                         ? Colors.white.withValues(alpha: 0.18)
//                         : AppColors.navy.withValues(alpha: 0.08),
//                   ),
//                   child: Center(
//                     child: Image.asset(
//                       item.imageName,
//                       height: 20,
//                       width: 20,
//                       color: contentColor,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 14),
//                 Expanded(
//                   child: Text(
//                     item.title,
//                     style: TextStyle(
//                       color: contentColor,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//                 Icon(Icons.chevron_right, color: contentColor, size: 22),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:math' as math;

import 'package:db_atom/index.dart';

class FloatingSubMenuWidget extends StatelessWidget {
  final List<MenuItem> menuItems;
  final void Function(BuildContext context, int index) onOptionSelected;
  final double positionX;

  /// Heading of the tapped bottom-nav tab, e.g. "Material Movement".
  final String title;

  /// Index of the item shown in the filled (selected) state.
  /// Pass -1 for no highlighted item.
  final int selectedIndex;

  const FloatingSubMenuWidget({
    super.key,
    required this.menuItems,
    required this.onOptionSelected,
    required this.positionX,
    required this.title,
    this.selectedIndex = -1,
  });

  static const double _sideMargin = 24;
  static const double _notchSize = 20;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth - (_sideMargin * 2);

    // Keeps the pointer under the tapped tab and inside the card's corners.
    final double notchLeft = (positionX - _sideMargin - (_notchSize / 2))
        .clamp(28.0, cardWidth - _notchSize - 28.0);

    return Positioned(
      bottom: 110,
      left: _sideMargin,
      right: _sideMargin,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Pointer toward the tapped bottom-nav tab (drawn behind the card).
          Positioned(
            bottom: -8,
            left: notchLeft,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                width: _notchSize,
                height: _notchSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          Material(
            color: Colors.white,
            elevation: 16,
            shadowColor: AppColors.navy.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(28),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 6),
                  ...menuItems.asMap().entries.map((entry) {
                    final int index = entry.key;
                    return _SubMenuTile(
                      item: entry.value,
                      isSelected: index == selectedIndex,
                      onTap: () {
                        Navigator.of(context).pop();
                        onOptionSelected(context, index);
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _SubMenuTile extends StatelessWidget {
  final MenuItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _SubMenuTile({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color contentColor = isSelected ? Colors.white : AppColors.navy;

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Material(
        color: isSelected ? AppColors.navy : Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.18)
                        : AppColors.navy.withValues(alpha: 0.08),
                  ),
                  child: Center(
                    child: Image.asset(
                      item.imageName,
                      height: 20,
                      width: 20,
                      color: contentColor,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      color: contentColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Icon(Icons.chevron_right, color: contentColor, size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}