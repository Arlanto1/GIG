// import 'dart:developer';
//
// import '../../../index.dart';
//
// class BaseAppBar {
//   AppHeader buildAppHeader({
//     required BuildContext context,
//     required String title,
//     required bool showPopUp,
//     required bool showSaveButton,
//     required bool showSubmitButton,
//     required bool showLikeButton,
//     required bool showDisLikeButton,
//     Function? onTapSubmit,
//     Function? onTapSave,
//     Function? onTapLikeButton,
//     Function? onTapDislikeButton,
//     void Function()? popAndReplace,
//     bool? showCustomIcon,
//     Function? onTapCustomIcon,
//     Function? onTapPDFIcon,
//     String? excelAPIName,
//     String? pdfAPIName, // used for Listing Page and Details Page
//     IconData? customIcon,
//   }) {
//     return AppHeader(
//       isTitleCenter: false,
//       backgroundColour: AppColors.newColor,
//       title: title,
//       backBtn: IconButton(
//         onPressed: popAndReplace ??
//             () {
//               Navigator.pop(context);
//               CommonServices().unlock();
//             },
//         icon:
//             const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
//       ),
//       action: [
//         if (showPopUp) ...[
//           CustomPopmenu(
//             itemList: const [
//               PopMenuItems("Export Excel", AppIcon.exportexcel),
//               PopMenuItems("Export PDF", AppIcon.exportpdf),
//               // PopMenuItems("Export XML", AppIcon.exportxml),
//               //PopMenuItems("Close", AppIcon.close),
//             ],
//             itemTap: (value) async {
//               // String userid = await SharedPrefs.getUserId();
//
//               log('value--$value');
//               if (value == 0) {
//                 DownloadImage()
//                     .exportExcel(context, 'export.xslx', '/$excelAPIName');
//               } else if (value == 1) {
//                 DownloadImage()
//                     .exportPdf(context, 'export.pdf', '/$pdfAPIName');
//               }
//               // else if(value == 2){
//               //   Navigator.pop(context);
//               // }
//             },
//             popupimagename: AppIcon.morewhiteicon,
//           ),
//         ],
//         if (showSaveButton) ...[
//           GestureDetector(
//             onTap: () {
//               onTapSave!();
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(right: 20.0),
//               child: SvgPicture.asset(
//                 AppIcon.createfoundsaveicon,
//               ),
//             ),
//           )
//         ],
//         if (showSubmitButton) ...[
//           GestureDetector(
//             onTap: () {
//               onTapSubmit!();
//             },
//             child: const Padding(
//               padding: EdgeInsets.only(right: 20.0),
//               child: Icon(
//                 Icons.send,
//                 color: AppColors.white,
//               ),
//             ),
//           )
//         ],
//         if (showLikeButton) ...[
//           GestureDetector(
//             onTap: () {
//               onTapLikeButton!();
//             },
//             child: const Padding(
//               padding: EdgeInsets.only(right: 20.0),
//               child: Icon(
//                 Icons.thumb_up,
//                 color: AppColors.white,
//               ),
//             ),
//           )
//         ],
//         if (showDisLikeButton) ...[
//           GestureDetector(
//             onTap: () {
//               onTapDislikeButton!();
//             },
//             child: const Padding(
//               padding: EdgeInsets.only(right: 20.0),
//               child: Icon(
//                 Icons.thumb_down,
//                 color: AppColors.white,
//               ),
//             ),
//           )
//         ],
//         if (showCustomIcon ?? false) ...[
//           GestureDetector(
//             onTap: () {
//               onTapCustomIcon!();
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(right: 20.0),
//               child: Icon(customIcon ?? Icons.history, color: Colors.white),
//             ),
//           )
//         ],
//         if (!pdfAPIName.isEmptyOrNull && checkIfUrlContainsId(pdfAPIName!)) ...[
//           GestureDetector(
//             onTap: () {
//               DownloadImage().exportPdf(context, 'export.pdf', '/$pdfAPIName');
//             },
//             child: const Padding(
//               padding: EdgeInsets.only(right: 20.0),
//               child: Icon(Icons.picture_as_pdf, color: Colors.white),
//             ),
//           )
//         ],
//       ],
//     );
//   }
//
//   bool containsInteger(String input) {
//     // Regular expression to check if the string contains any digits
//     RegExp regExp = RegExp(r'\d');
//     return regExp.hasMatch(input);
//   }
//
//   bool checkIfUrlContainsId(String url) {
//     Uri uri = Uri.parse(url);
//
//     // Check if the query parameters contain "id" and Integer
//     RegExp regExp = RegExp(r'\d');
//     return uri.queryParameters.containsKey('id') && regExp.hasMatch(url);
//   }
//  }
//
// // import 'dart:developer';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // import '../../../index.dart';
// //
// // class BaseAppBar {
// //   AppBar buildAppHeader({
// //     required BuildContext context,
// //     required String title,
// //     required bool showPopUp,
// //     required bool showSaveButton,
// //     required bool showSubmitButton,
// //     required bool showLikeButton,
// //     required bool showDisLikeButton,
// //     Function? onTapSubmit,
// //     Function? onTapSave,
// //     Function? onTapLikeButton,
// //     Function? onTapDislikeButton,
// //     void Function()? popAndReplace,
// //     bool? showCustomIcon,
// //     Function? onTapCustomIcon,
// //     Function? onTapPDFIcon,
// //     String? excelAPIName,
// //     String? pdfAPIName,
// //     IconData? customIcon,
// //   }) {
// //     return AppBar(
// //       automaticallyImplyLeading: false,
// //       backgroundColor: Colors.black,
// //       elevation: 0,
// //       flexibleSpace: SafeArea(
// //         bottom: false,
// //         child: Container(
// //           margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 1),
// //           decoration: BoxDecoration(
// //             color: const Color(0xFF5A63F6),
// //             borderRadius: BorderRadius.circular(14),
// //             border: Border.all(color: Colors.white.withOpacity(0.8), width: 1),
// //             boxShadow: [
// //               BoxShadow(
// //                 color: Colors.black.withOpacity(0.15),
// //                 blurRadius: 8,
// //                 offset: const Offset(0, 3),
// //               ),
// //             ],
// //           ),
// //           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               // Back Button
// //               IconButton(
// //                 icon: const Icon(Icons.arrow_back_ios_new_rounded,
// //                     color: Colors.white, size: 20),
// //                 onPressed: popAndReplace ??
// //                         () {
// //                       Navigator.pop(context);
// //                       CommonServices().unlock();
// //                     },
// //               ),
// //
// //               // Title
// //               Expanded(
// //                 child: Text(
// //                   title,
// //                   textAlign: TextAlign.center,
// //                   style: const TextStyle(
// //                     color: Colors.white,
// //                     fontWeight: FontWeight.w600,
// //                     fontSize: 18,
// //                   ),
// //                 ),
// //               ),
// //
// //               // Popup Menu
// //               if (showPopUp)
// //                 CustomPopmenu(
// //                   itemList: const [
// //                     PopMenuItems("Export Excel", AppIcon.exportexcel),
// //                     PopMenuItems("Export PDF", AppIcon.exportpdf),
// //                   ],
// //                   itemTap: (value) async {
// //                     log('value--$value');
// //                     if (value == 0) {
// //                       DownloadImage()
// //                           .exportExcel(context, 'export.xslx', '/$excelAPIName');
// //                     } else if (value == 1) {
// //                       DownloadImage()
// //                           .exportPdf(context, 'export.pdf', '/$pdfAPIName');
// //                     }
// //                   },
// //                   popupimagename: AppIcon.morewhiteicon,
// //                 )
// //               else
// //                 const SizedBox(width: 44),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   bool containsInteger(String input) {
// //     RegExp regExp = RegExp(r'\d');
// //     return regExp.hasMatch(input);
// //   }
// //
// //   bool checkIfUrlContainsId(String url) {
// //     Uri uri = Uri.parse(url);
// //     RegExp regExp = RegExp(r'\d');
// //     return uri.queryParameters.containsKey('id') && regExp.hasMatch(url);
// //   }
// // }
import 'dart:developer';

import '../../../index.dart';

class BaseAppBar {
  AppHeader buildAppHeader({
    required BuildContext context,
    required String title,
    required bool showPopUp,
    required bool showSaveButton,
    required bool showSubmitButton,
    required bool showLikeButton,
    required bool showDisLikeButton,
    bool visitorPassId = false,
    Function? onTapSubmit,
    Function? onTapSave,
    Function? onTapLikeButton,
    Function? onTapDislikeButton,
    void Function()? popAndReplace,
    bool? showCustomIcon,
    Function? onTapCustomIcon,
    Function? onTapPDFIcon,
    String? excelAPIName,
    String? pdfAPIName, // used for Listing Page and Details Page
    IconData? customIcon,
  }) {
    return AppHeader(
      isTitleCenter: false,
      backgroundColour: AppColors.newColor,
      title: title,
      backBtn: IconButton(
        onPressed: popAndReplace ??
                () {
              Navigator.pop(context);
              CommonServices().unlock();
            },
        icon:
        const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
      ),
      action: [
        if (showPopUp) ...[
          CustomPopmenu(
            itemList: const [
              PopMenuItems("Export Excel", AppIcon.exportexcel),
              PopMenuItems("Export PDF", AppIcon.exportpdf),
              // PopMenuItems("Export XML", AppIcon.exportxml),
              //PopMenuItems("Close", AppIcon.close),
            ],
            itemTap: (value) async {
              // String userid = await SharedPrefs.getUserId();

              log('value--$value');
              if (value == 0) {
                DownloadImage()
                    .exportExcel(context, 'export.xslx', '/$excelAPIName');
              } else if (value == 1) {
                DownloadImage()
                    .exportPdf(context, 'export.pdf', '/$pdfAPIName');
              }
              // else if(value == 2){
              //   Navigator.pop(context);
              // }
            },
            popupimagename: AppIcon.morewhiteicon,
          ),
        ],
        if (showSaveButton) ...[
          GestureDetector(
            onTap: () {
              onTapSave!();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgPicture.asset(
                AppIcon.createfoundsaveicon,
              ),
            ),
          )
        ],
        if (showSubmitButton) ...[
          GestureDetector(
            onTap: () {
              onTapSubmit!();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(
                visitorPassId ? Icons.print : Icons.send,
                color: AppColors.white,
              ),
            ),
          )
        ],
        if (showLikeButton) ...[
          GestureDetector(
            onTap: () {
              onTapLikeButton!();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.thumb_up,
                color: AppColors.white,
              ),
            ),
          )
        ],
        if (showDisLikeButton) ...[
          GestureDetector(
            onTap: () {
              onTapDislikeButton!();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.thumb_down,
                color: AppColors.white,
              ),
            ),
          )
        ],
        if (showCustomIcon ?? false) ...[
          GestureDetector(
            onTap: () {
              onTapCustomIcon!();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(customIcon ?? Icons.history, color: Colors.white),
            ),
          )
        ],
        if (!pdfAPIName.isEmptyOrNull && checkIfUrlContainsId(pdfAPIName!)) ...[
          GestureDetector(
            onTap: () {
              DownloadImage().exportPdf(context, 'export.pdf', '/$pdfAPIName');
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(Icons.picture_as_pdf, color: Colors.white),
            ),
          )
        ],
      ],
    );
  }

  bool containsInteger(String input) {
    // Regular expression to check if the string contains any digits
    RegExp regExp = RegExp(r'\d');
    return regExp.hasMatch(input);
  }

  bool checkIfUrlContainsId(String url) {
    Uri uri = Uri.parse(url);

    // Check if the query parameters contain "id" and Integer
    RegExp regExp = RegExp(r'\d');
    return uri.queryParameters.containsKey('id') && regExp.hasMatch(url);
  }
}

// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../index.dart';
//
// class BaseAppBar {
//   AppBar buildAppHeader({
//     required BuildContext context,
//     required String title,
//     required bool showPopUp,
//     required bool showSaveButton,
//     required bool showSubmitButton,
//     required bool showLikeButton,
//     required bool showDisLikeButton,
//     Function? onTapSubmit,
//     Function? onTapSave,
//     Function? onTapLikeButton,
//     Function? onTapDislikeButton,
//     void Function()? popAndReplace,
//     bool? showCustomIcon,
//     Function? onTapCustomIcon,
//     Function? onTapPDFIcon,
//     String? excelAPIName,
//     String? pdfAPIName,
//     IconData? customIcon,
//   }) {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       backgroundColor: Colors.black,
//       elevation: 0,
//       flexibleSpace: SafeArea(
//         bottom: false,
//         child: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 1),
//           decoration: BoxDecoration(
//             color: const Color(0xFF5A63F6),
//             borderRadius: BorderRadius.circular(14),
//             border: Border.all(color: Colors.white.withOpacity(0.8), width: 1),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.15),
//                 blurRadius: 8,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Back Button
//               IconButton(
//                 icon: const Icon(Icons.arrow_back_ios_new_rounded,
//                     color: Colors.white, size: 20),
//                 onPressed: popAndReplace ??
//                         () {
//                       Navigator.pop(context);
//                       CommonServices().unlock();
//                     },
//               ),
//
//               // Title
//               Expanded(
//                 child: Text(
//                   title,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//
//               // Popup Menu
//               if (showPopUp)
//                 CustomPopmenu(
//                   itemList: const [
//                     PopMenuItems("Export Excel", AppIcon.exportexcel),
//                     PopMenuItems("Export PDF", AppIcon.exportpdf),
//                   ],
//                   itemTap: (value) async {
//                     log('value--$value');
//                     if (value == 0) {
//                       DownloadImage()
//                           .exportExcel(context, 'export.xslx', '/$excelAPIName');
//                     } else if (value == 1) {
//                       DownloadImage()
//                           .exportPdf(context, 'export.pdf', '/$pdfAPIName');
//                     }
//                   },
//                   popupimagename: AppIcon.morewhiteicon,
//                 )
//               else
//                 const SizedBox(width: 44),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   bool containsInteger(String input) {
//     RegExp regExp = RegExp(r'\d');
//     return regExp.hasMatch(input);
//   }
//
//   bool checkIfUrlContainsId(String url) {
//     Uri uri = Uri.parse(url);
//     RegExp regExp = RegExp(r'\d');
//     return uri.queryParameters.containsKey('id') && regExp.hasMatch(url);
//   }
// }
