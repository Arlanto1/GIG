// import 'dart:ui';
//
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/utils/device_infomation.dart';
//
// class FloatingSubMenuWidget extends StatelessWidget {
//   final List<MenuItem> menuItems;
//   final void Function(BuildContext context, int index) onOptionSelected;
//   final double positionX;
//
//   const FloatingSubMenuWidget({
//     super.key,
//     required this.menuItems,
//     required this.onOptionSelected,
//     required this.positionX,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // Use a more descriptive name for the constant
//     const double menuOffset = 30.0;
//
//     // return Positioned(
//     //   bottom: 70.0,
//     //   left: positionX - menuOffset,
//     //   child: Material(
//     //     color: Colors.transparent,
//     //     child: Container(
//     //       width:
//     //           DeviceInformation().detectDeviceType(context) == DeviceType.tablet
//     //               ? 270
//     //               : 180,
//     //       padding: const EdgeInsets.all(10),
//     //       decoration: BoxDecoration(
//     //         gradient: LinearGradient(
//     //           colors: [
//     //             // Colors.white.withValues(alpha: 0.6),
//     //             AppColors.lavender.withValues(alpha: 0.9),
//     //             AppColors.lavender.withValues(alpha: 0.96),
//     //             AppColors.lavender.withValues(alpha: 0.96),
//     //
//     //             // Colors.transparent,
//     //             // Colors.white.withValues(alpha: 0.6),
//     //             // Color(0xFF6474C6).withOpacity(0.14)
//     //           ],
//     //           // stops: [0.02, 0.35, 1],
//     //           begin: Alignment.topCenter,
//     //           end: Alignment.bottomCenter,
//     //         ),
//     //         borderRadius: BorderRadius.circular(27),
//     //         border: Border.all(
//     //           color: Colors.white.withValues(alpha: 0.80),
//     //           width: 0.8,
//     //         ),
//     //         boxShadow: [
//     //           BoxShadow(
//     //             color: const Color(0xFF6474C6).withValues(alpha: 0.09),
//     //             blurRadius: 12,
//     //             offset: const Offset(0, 2),
//     //           ),
//     //         ],
//     //       ),
//     //       child: Column(
//     //         mainAxisSize: MainAxisSize.min,
//     //         children: menuItems.asMap().entries.map((entry) {
//     //           int index = entry.key;
//     //           MenuItem item = entry.value;
//     //           return InkWell(
//     //             onTap: () {
//     //               Navigator.of(context).pop(); // to close sub menu
//     //               onOptionSelected(context, index);
//     //             },
//     //             child: Padding(
//     //               padding: const EdgeInsets.symmetric(vertical: 10),
//     //               child: Row(
//     //                 children: [
//     //                   Image.asset(
//     //                     item.imageName,
//     //                     height: 20,
//     //                     width: 20,
//     //                     color: Colors.white,
//     //                   ),
//     //                   const SizedBox(width: 10),
//     //                   Expanded(
//     //                     child: Text(
//     //                       item.title,
//     //                       style: const TextStyle(color: Colors.white),
//     //                     ),
//     //                   ),
//     //                 ],
//     //               ),
//     //             ),
//     //           );
//     //         }).toList(),
//     //       ),
//     //     ),
//     //   ),
//     // );
//     // return Positioned(
//     //   bottom: 110.0,
//     //     double calculateMenuPosition(int index, double positionX, double menuOffset, int totalItems) {
//     //   if (index == 0) {
//     //     // First Item → shift to right side
//     //     return positionX + 20;
//     //   } else if (index == totalItems - 1) {
//     //     // Last Item → shift to left side
//     //     return positionX - menuOffset - 60;
//     //   } else {
//     //     // Middle items → normal position
//     //     return positionX - menuOffset;
//     //   }
//     // }
//     //
//     // // left: positionX - menuOffset,
//     //   // right: menuOffset - positionX,
//     //   child: Material(
//     //     color: Colors.transparent,
//     //     child: ClipRRect(
//     //       borderRadius: BorderRadius.circular(27),
//     //       child: BackdropFilter(
//     //         filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//     //         child: Container(
//     //           width: DeviceInformation().detectDeviceType(context) == DeviceType.tablet
//     //               ? 270
//     //               : 180,
//     //           padding: const EdgeInsets.all(14),
//     //           decoration: BoxDecoration(
//     //             gradient: LinearGradient(
//     //               colors: [
//     //                 Colors.white.withValues(alpha: 0.35),
//     //                 AppColors.lavender.withValues(alpha: 0.15),
//     //               ],
//     //               begin: Alignment.topLeft,
//     //               end: Alignment.bottomRight,
//     //             ),
//     //             borderRadius: BorderRadius.circular(27),
//     //             border: Border.all(
//     //               color: Colors.white.withValues(alpha: 0.65),
//     //               width: 1.0,
//     //             ),
//     //             boxShadow: [
//     //               BoxShadow(
//     //                 color: Colors.black.withValues(alpha: 0.3),
//     //                 blurRadius: 0,
//     //                 offset: const Offset(0, 6),
//     //               ),
//     //             ],
//     //           ),
//     //           child: Column(
//     //             mainAxisSize: MainAxisSize.min,
//     //             children: menuItems.asMap().entries.map((entry) {
//     //               int index = entry.key;
//     //               MenuItem item = entry.value;
//     //
//     //               return InkWell(
//     //                 onTap: () {
//     //                   Navigator.of(context).pop();
//     //                   onOptionSelected(context, index);
//     //                 },
//     //                 borderRadius: BorderRadius.circular(20),
//     //                 child: Padding(
//     //                   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
//     //                   child: Row(
//     //                     children: [
//     //                       Image.asset(
//     //                         item.imageName,
//     //                         height: 22,
//     //                         width: 22,
//     //                         color: Colors.white,
//     //                       ),
//     //                       const SizedBox(width: 12),
//     //                       Expanded(
//     //                         child: Text(
//     //                           item.title,
//     //                           style: const TextStyle(
//     //                             color: Colors.white,
//     //                             fontSize: 14,
//     //                             fontWeight: FontWeight.w500,
//     //                           ),
//     //                         ),
//     //                       ),
//     //                     ],
//     //                   ),
//     //                 ),
//     //               );
//     //             }).toList(),
//     //           ),
//     //         ),
//     //       ),
//     //     ),
//     //   ),
//     // );
//     // return Positioned(
//     //   bottom: 110.0,
//     //   left: (MediaQuery.of(context).size.width) - 650/2,
//     //       // (DeviceInformation().detectDeviceType(context) == DeviceType.tablet ? 270 : 180)) / 2,
//     //
//     //   child: Material(
//     //     color: Colors.transparent,
//     //     child: ClipRRect(
//     //       borderRadius: BorderRadius.circular(27),
//     //       child: BackdropFilter(
//     //         filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//     //         child: Container(
//     //           width: MediaQuery.of(context).size.width - 200,
//     //           // width: 800,
//     //           // width: DeviceInformation().detectDeviceType(context) == DeviceType.tablet
//     //           //     ? 270
//     //           //     : 200,
//     //           // padding: const EdgeInsets.only(right: 10, left: 0),
//     //           decoration: BoxDecoration(
//     //             gradient: LinearGradient(
//     //               colors: [
//     //                 // Colors.white.withValues(alpha: 0.15),
//     //                 AppColors.lavender.withValues(alpha: 0.35),
//     //                 AppColors.lavender.withValues(alpha: 0.35),
//     //               ],
//     //               begin: Alignment.topLeft,
//     //               end: Alignment.bottomRight,
//     //             ),
//     //             borderRadius: BorderRadius.circular(27),
//     //             border: Border.all(
//     //               color: Colors.white.withValues(alpha: 0.65),
//     //               width: 1.0,
//     //             ),
//     //             boxShadow: [
//     //               BoxShadow(
//     //                 color: Colors.black.withValues(alpha: 0.3),
//     //                 blurRadius: 0,
//     //                 offset: const Offset(0, 6),
//     //               ),
//     //             ],
//     //           ),
//     //           child: Column(
//     //             mainAxisSize: MainAxisSize.max,
//     //             children: menuItems.asMap().entries.map((entry) {
//     //               int index = entry.key;
//     //               MenuItem item = entry.value;
//     //
//     //               // return InkWell(
//     //               //   onTap: () {
//     //               //     Navigator.of(context).pop();
//     //               //     onOptionSelected(context, index);
//     //               //   },
//     //               //   borderRadius: BorderRadius.circular(20),
//     //               //   child: Padding(
//     //               //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
//     //               //     child: Row(
//     //               //       children: [
//     //               //         Image.asset(
//     //               //           item.imageName,
//     //               //           height: 22,
//     //               //           width: 22,
//     //               //           color: Colors.white,
//     //               //         ),
//     //               //         const SizedBox(width: 12),
//     //               //         Expanded(
//     //               //           child: Text(
//     //               //             item.title,
//     //               //             style: const TextStyle(
//     //               //               color: Colors.white,
//     //               //               fontSize: 14,
//     //               //               fontWeight: FontWeight.w500,
//     //               //             ),
//     //               //           ),
//     //               //         ),
//     //               //       ],
//     //               //     ),
//     //               //   ),
//     //               // );
//     //               return InkWell(
//     //                 onTap: () {
//     //                   Navigator.of(context).pop();
//     //                   onOptionSelected(context, index);
//     //                 },
//     //                 borderRadius: BorderRadius.circular(20),
//     //                 child: Container(
//     //                   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
//     //                   decoration: BoxDecoration(
//     //                     color: Colors.white.withOpacity(0.15),
//     //                     borderRadius: BorderRadius.circular(16),
//     //                     border: Border.all(color: Colors.white54, width: 1),
//     //                   ),
//     //                   child: Row(
//     //                     children: [
//     //                       Image.asset(
//     //                         item.imageName,
//     //                         height: 22,
//     //                         width: 22,
//     //                         color: Colors.white,
//     //                       ),
//     //                       const SizedBox(width: 12),
//     //                       Expanded(
//     //                         child: Text(
//     //                           item.title,
//     //                           style: const TextStyle(
//     //                             color: Colors.white,
//     //                             fontSize: 14,
//     //                             fontWeight: FontWeight.w600,
//     //                           ),
//     //                         ),
//     //                       ),
//     //                     ],
//     //                   ),
//     //                 ),
//     //               );
//     //
//     //             }).toList(),
//     //           ),
//     //         ),
//     //       ),
//     //     ),
//     //   ),
//     // );
//     return Positioned(
//       bottom: 110.0,
//       left: (MediaQuery.of(context).size.width -
//           (MediaQuery.of(context).size.width - 160)) /
//           2, // Perfect center
//       child: Material(
//         color: Colors.transparent,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(28),
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
//             child: Container(
//               width: MediaQuery.of(context).size.width - 160,
//               padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.newColor3.withValues(alpha: 0.2),
//                     AppColors.newColor3.withValues(alpha: 0.5),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(28),
//                 border: Border.all(
//                   color: Colors.white.withValues(alpha: 0.35),
//                   width: 1.2,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.25),
//                     blurRadius: 18,
//                     spreadRadius: -4,
//                     offset: const Offset(0, 12),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: menuItems.asMap().entries.map((entry) {
//                   int index = entry.key;
//                   MenuItem item = entry.value;
//
//                   return Container(
//                     margin: const EdgeInsets.symmetric(vertical: 6), // spacing
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                         onOptionSelected(context, index);
//                       },
//                       borderRadius: BorderRadius.circular(25),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               Colors.white.withValues(alpha: 0.2),
//                               Colors.transparent,
//                               Colors.white.withValues(alpha: 0.2),
//                               // Color(0xFF6474C6).withOpacity(0.14)
//                             ],
//                             stops: [0.02, 0.35, 1],
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                           ),
//                           borderRadius: BorderRadius.circular(40),
//                           border: Border.all(
//                             color: Colors.white.withValues(alpha: 0.80),
//                             width: 0.8,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: const Color(0xFF6474C6).withValues(alpha: 0.09),
//                               blurRadius: 12,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           children: [
//                             Image.asset(
//                               item.imageName,
//                               height: 22,
//                               width: 22,
//                               color: Colors.white,
//                             ),
//                             const SizedBox(width: 14),
//                             Expanded(
//                               child: Text(
//                                 item.title,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w600,
//                                   letterSpacing: 0.4,
//                                 ),
//                               ),
//                             ),
//                             const Icon(
//                               Icons.arrow_right,
//                               color: Colors.white70,
//                               size: 20,
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//
//   }
// }

import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/utils/device_infomation.dart';

class FloatingSubMenuWidget extends StatelessWidget {
  final List<MenuItem> menuItems;
  final void Function(BuildContext context, int index) onOptionSelected;
  final double positionX;

  const FloatingSubMenuWidget({
    super.key,
    required this.menuItems,
    required this.onOptionSelected,
    required this.positionX,
  });

  @override
  Widget build(BuildContext context) {
    // Use a more descriptive name for the constant
    const double menuOffset = 30.0;

    // return Positioned(
    //   bottom: 70.0,
    //   left: positionX - menuOffset,
    //   child: Material(
    //     color: Colors.transparent,
    //     child: Container(
    //       width:
    //           DeviceInformation().detectDeviceType(context) == DeviceType.tablet
    //               ? 270
    //               : 180,
    //       padding: const EdgeInsets.all(10),
    //       decoration: BoxDecoration(
    //         gradient: LinearGradient(
    //           colors: [
    //             // Colors.white.withValues(alpha: 0.6),
    //             AppColors.lavender.withValues(alpha: 0.9),
    //             AppColors.lavender.withValues(alpha: 0.96),
    //             AppColors.lavender.withValues(alpha: 0.96),
    //
    //             // Colors.transparent,
    //             // Colors.white.withValues(alpha: 0.6),
    //             // Color(0xFF6474C6).withOpacity(0.14)
    //           ],
    //           // stops: [0.02, 0.35, 1],
    //           begin: Alignment.topCenter,
    //           end: Alignment.bottomCenter,
    //         ),
    //         borderRadius: BorderRadius.circular(27),
    //         border: Border.all(
    //           color: Colors.white.withValues(alpha: 0.80),
    //           width: 0.8,
    //         ),
    //         boxShadow: [
    //           BoxShadow(
    //             color: const Color(0xFF6474C6).withValues(alpha: 0.09),
    //             blurRadius: 12,
    //             offset: const Offset(0, 2),
    //           ),
    //         ],
    //       ),
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: menuItems.asMap().entries.map((entry) {
    //           int index = entry.key;
    //           MenuItem item = entry.value;
    //           return InkWell(
    //             onTap: () {
    //               Navigator.of(context).pop(); // to close sub menu
    //               onOptionSelected(context, index);
    //             },
    //             child: Padding(
    //               padding: const EdgeInsets.symmetric(vertical: 10),
    //               child: Row(
    //                 children: [
    //                   Image.asset(
    //                     item.imageName,
    //                     height: 20,
    //                     width: 20,
    //                     color: Colors.white,
    //                   ),
    //                   const SizedBox(width: 10),
    //                   Expanded(
    //                     child: Text(
    //                       item.title,
    //                       style: const TextStyle(color: Colors.white),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           );
    //         }).toList(),
    //       ),
    //     ),
    //   ),
    // );
    // return Positioned(
    //   bottom: 110.0,
    //     double calculateMenuPosition(int index, double positionX, double menuOffset, int totalItems) {
    //   if (index == 0) {
    //     // First Item → shift to right side
    //     return positionX + 20;
    //   } else if (index == totalItems - 1) {
    //     // Last Item → shift to left side
    //     return positionX - menuOffset - 60;
    //   } else {
    //     // Middle items → normal position
    //     return positionX - menuOffset;
    //   }
    // }
    //
    // // left: positionX - menuOffset,
    //   // right: menuOffset - positionX,
    //   child: Material(
    //     color: Colors.transparent,
    //     child: ClipRRect(
    //       borderRadius: BorderRadius.circular(27),
    //       child: BackdropFilter(
    //         filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
    //         child: Container(
    //           width: DeviceInformation().detectDeviceType(context) == DeviceType.tablet
    //               ? 270
    //               : 180,
    //           padding: const EdgeInsets.all(14),
    //           decoration: BoxDecoration(
    //             gradient: LinearGradient(
    //               colors: [
    //                 Colors.white.withValues(alpha: 0.35),
    //                 AppColors.lavender.withValues(alpha: 0.15),
    //               ],
    //               begin: Alignment.topLeft,
    //               end: Alignment.bottomRight,
    //             ),
    //             borderRadius: BorderRadius.circular(27),
    //             border: Border.all(
    //               color: Colors.white.withValues(alpha: 0.65),
    //               width: 1.0,
    //             ),
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Colors.black.withValues(alpha: 0.3),
    //                 blurRadius: 0,
    //                 offset: const Offset(0, 6),
    //               ),
    //             ],
    //           ),
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: menuItems.asMap().entries.map((entry) {
    //               int index = entry.key;
    //               MenuItem item = entry.value;
    //
    //               return InkWell(
    //                 onTap: () {
    //                   Navigator.of(context).pop();
    //                   onOptionSelected(context, index);
    //                 },
    //                 borderRadius: BorderRadius.circular(20),
    //                 child: Padding(
    //                   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
    //                   child: Row(
    //                     children: [
    //                       Image.asset(
    //                         item.imageName,
    //                         height: 22,
    //                         width: 22,
    //                         color: Colors.white,
    //                       ),
    //                       const SizedBox(width: 12),
    //                       Expanded(
    //                         child: Text(
    //                           item.title,
    //                           style: const TextStyle(
    //                             color: Colors.white,
    //                             fontSize: 14,
    //                             fontWeight: FontWeight.w500,
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               );
    //             }).toList(),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    // return Positioned(
    //   bottom: 110.0,
    //   left: (MediaQuery.of(context).size.width) - 650/2,
    //       // (DeviceInformation().detectDeviceType(context) == DeviceType.tablet ? 270 : 180)) / 2,
    //
    //   child: Material(
    //     color: Colors.transparent,
    //     child: ClipRRect(
    //       borderRadius: BorderRadius.circular(27),
    //       child: BackdropFilter(
    //         filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
    //         child: Container(
    //           width: MediaQuery.of(context).size.width - 200,
    //           // width: 800,
    //           // width: DeviceInformation().detectDeviceType(context) == DeviceType.tablet
    //           //     ? 270
    //           //     : 200,
    //           // padding: const EdgeInsets.only(right: 10, left: 0),
    //           decoration: BoxDecoration(
    //             gradient: LinearGradient(
    //               colors: [
    //                 // Colors.white.withValues(alpha: 0.15),
    //                 AppColors.lavender.withValues(alpha: 0.35),
    //                 AppColors.lavender.withValues(alpha: 0.35),
    //               ],
    //               begin: Alignment.topLeft,
    //               end: Alignment.bottomRight,
    //             ),
    //             borderRadius: BorderRadius.circular(27),
    //             border: Border.all(
    //               color: Colors.white.withValues(alpha: 0.65),
    //               width: 1.0,
    //             ),
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Colors.black.withValues(alpha: 0.3),
    //                 blurRadius: 0,
    //                 offset: const Offset(0, 6),
    //               ),
    //             ],
    //           ),
    //           child: Column(
    //             mainAxisSize: MainAxisSize.max,
    //             children: menuItems.asMap().entries.map((entry) {
    //               int index = entry.key;
    //               MenuItem item = entry.value;
    //
    //               // return InkWell(
    //               //   onTap: () {
    //               //     Navigator.of(context).pop();
    //               //     onOptionSelected(context, index);
    //               //   },
    //               //   borderRadius: BorderRadius.circular(20),
    //               //   child: Padding(
    //               //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
    //               //     child: Row(
    //               //       children: [
    //               //         Image.asset(
    //               //           item.imageName,
    //               //           height: 22,
    //               //           width: 22,
    //               //           color: Colors.white,
    //               //         ),
    //               //         const SizedBox(width: 12),
    //               //         Expanded(
    //               //           child: Text(
    //               //             item.title,
    //               //             style: const TextStyle(
    //               //               color: Colors.white,
    //               //               fontSize: 14,
    //               //               fontWeight: FontWeight.w500,
    //               //             ),
    //               //           ),
    //               //         ),
    //               //       ],
    //               //     ),
    //               //   ),
    //               // );
    //               return InkWell(
    //                 onTap: () {
    //                   Navigator.of(context).pop();
    //                   onOptionSelected(context, index);
    //                 },
    //                 borderRadius: BorderRadius.circular(20),
    //                 child: Container(
    //                   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    //                   decoration: BoxDecoration(
    //                     color: Colors.white.withOpacity(0.15),
    //                     borderRadius: BorderRadius.circular(16),
    //                     border: Border.all(color: Colors.white54, width: 1),
    //                   ),
    //                   child: Row(
    //                     children: [
    //                       Image.asset(
    //                         item.imageName,
    //                         height: 22,
    //                         width: 22,
    //                         color: Colors.white,
    //                       ),
    //                       const SizedBox(width: 12),
    //                       Expanded(
    //                         child: Text(
    //                           item.title,
    //                           style: const TextStyle(
    //                             color: Colors.white,
    //                             fontSize: 14,
    //                             fontWeight: FontWeight.w600,
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               );
    //
    //             }).toList(),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return Positioned(
      bottom: 110.0,
      left: (MediaQuery.of(context).size.width -
          (MediaQuery.of(context).size.width - 160)) /
          2, // Perfect center
      child: Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(
              width: MediaQuery.of(context).size.width - 160,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.newColor.withValues(alpha: 0.04),
                    AppColors.newColor.withValues(alpha: 0.04),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.35),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 18,
                    spreadRadius: -4,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                children: menuItems.asMap().entries.map((entry) {
                  int index = entry.key;
                  MenuItem item = entry.value;

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6), // spacing
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        onOptionSelected(context, index);
                      },
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
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
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.80),
                            width: 0.8,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.newColor.withValues(alpha: 0.1),
                              blurRadius: 12,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              item.imageName,
                              height: 22,
                              width: 22,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                item.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_right,
                              color: Colors.white70,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );

  }
}
