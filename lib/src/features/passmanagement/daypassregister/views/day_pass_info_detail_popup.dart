import 'dart:ui';

import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/models/day_passlist_model.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';

class DayPassInfoCustomPopUpList extends StatefulWidget {
  final PassInfo userItem;

  const DayPassInfoCustomPopUpList(this.userItem, {super.key});

  @override
  State<DayPassInfoCustomPopUpList> createState() =>
      _DayPassInfoCustomPopUpListState();
}

class _DayPassInfoCustomPopUpListState
    extends State<DayPassInfoCustomPopUpList> {
  //var firstStyle = Styles.textStyleSemiBoldGrey14;
//var secondStyle = Styles.textStyleSemiBoldheighGrey14;

//var mergedStyle = firstStyle.merge(secondStyle);
  Widget textHandling(String title, String desc) {
    return Expanded(
      child: RichText(
        text: TextSpan(
          // Note: Styles for TextSpans must be explicitly defined.
          // Child text spans will inherit styles from parent
          style: Styles.textStyleRegularWhite14,
          children: <TextSpan>[
            TextSpan(text: title),
            TextSpan(
              text: desc,
              style: Styles.textStyleRegularWhite14,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          // Frosted glass blur
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.transparent,
                  Colors.white.withOpacity(0.3),
                  // Color(0xFF6474C6).withOpacity(0.14)
                ],
                stops: [0.02, 0.35, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(27),
              border: Border.all(
                color: Colors.white.withOpacity(0.80),
                width: 0.8,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6474C6).withOpacity(0.1),
                  blurRadius:12,
                  offset: const Offset(8, 0),
                ),
              ],
            ),
            height: height / 1.8,
            width: width - 18,
            // child: SingleChildScrollView(
            //   child: Column(
            //     children: getChildren(context, widget.labels),
            //   ),
            // ),
            child:
            // Row(
            //  children: [
            SingleChildScrollView(
              // child: Card(
              //         elevation: 5,
              //         shape: RoundedRectangleBorder(
              // side: const BorderSide(color: AppColors.searchBarBorder, width: 1),
              // borderRadius: circularBorderRadius10,
              //         ),
              //         child: Padding(
              //   padding: EdgeInsets.all(20),
                child: Column(children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child:
                          SvgPicture.asset(AppIcon.closeicon,  colorFilter: const ColorFilter.mode(
                            Colors.white, // your desired color
                            BlendMode.srcIn,
                          ),) //Icon(Icons.cancel)
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textHandling('ID : ', widget.userItem.id.toString()),
                    ],
                  ),
                  CommonWidgets.verticalSpacerWidget(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textHandling('Pass No : ', widget.userItem.passNo.toString()),
                    ],
                  ),
                  CommonWidgets.verticalSpacerWidget(8),
                  Row(
                    children: [
                      Utils().passManagementPassTypeRow(widget.userItem.passType ?? 0),
                    ],
                  ),
                  if (widget.userItem.region != null) ...[
                    CommonWidgets.verticalSpacerWidget(8),
                    Row(
                      children: [
                        textHandling('Region : ',
                            widget.userItem.region?.name.toString() ?? " "),
                      ],
                    ),
                  ],
                  if (widget.userItem.location != null) ...[
                    CommonWidgets.verticalSpacerWidget(8),
                    Row(
                      children: [
                        textHandling('Location : ',
                            widget.userItem.location?.name.toString() ?? " "),
                      ],
                    ),
                  ],
                  if (widget.userItem.entity != null) ...[
                    CommonWidgets.verticalSpacerWidget(8),
                    Row(
                      children: [
                        textHandling(
                            'Entity : ', widget.userItem.entity?.name.toString() ?? ""),
                      ],
                    ),
                  ],
                  if (widget.userItem.expiryDate != null) ...[
                    CommonWidgets.verticalSpacerWidget(8),
                    Row(
                      children: [
                        textHandling(
                            'Expiry Date : ',
                            widget.userItem.expiryDate != null
                                ? Utils.timestampToDateConversion(
                                int.parse(widget.userItem.expiryDate ?? '0'),
                                Constants.dateFormat)
                                : ''),
                      ],
                    ),
                  ],
                  CommonWidgets.verticalSpacerWidget(8),
                  Row(
                    children: [
                      textHandling('Is Dws Pass : ', widget.userItem.dws.toString()),
                    ],
                  ),
                  // CommonWidgets.verticalSpacerWidget(8),
                  // Row(
                  //   children: [
                  //     textHandling(
                  //         'Remarks : ',  " "),
                  //   ],
                  // ),
                  CommonWidgets.verticalSpacerWidget(8),
                  Row(
                    children: [
                      Utils().buildPassManagementStatusRow(widget.userItem.status ?? 0),
                    ],
                  )
                ])
              //),
              //    ),
            ),
          ),
        ),
      ),
      // child: Container(
      //   padding: const EdgeInsets.all(20.0),
      //   decoration: const ShapeDecoration(
      //       color: Colors.transparent,
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(20.0)),
      //       )),
      //   // color: Colors.white,
      //   height: height / 1.7,
      //   width: width - 40,
      //   child:
      //       // Row(
      //       //  children: [
      //       SingleChildScrollView(
      //           // child: Card(
      //           //         elevation: 5,
      //           //         shape: RoundedRectangleBorder(
      //           // side: const BorderSide(color: AppColors.searchBarBorder, width: 1),
      //           // borderRadius: circularBorderRadius10,
      //           //         ),
      //           //         child: Padding(
      //           //   padding: EdgeInsets.all(20),
      //           child: Column(children: [
      //     Align(
      //         alignment: Alignment.topRight,
      //         child: GestureDetector(
      //             onTap: () {
      //               Navigator.of(context).pop();
      //             },
      //             child:
      //                 SvgPicture.asset(AppIcon.closeicon) //Icon(Icons.cancel)
      //             )),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         textHandling('ID : ', widget.userItem.id.toString()),
      //       ],
      //     ),
      //     CommonWidgets.verticalSpacerWidget(8),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         textHandling('Pass No : ', widget.userItem.passNo.toString()),
      //       ],
      //     ),
      //     CommonWidgets.verticalSpacerWidget(8),
      //     Row(
      //       children: [
      //         Utils().passManagementPassTypeRow(widget.userItem.passType ?? 0),
      //       ],
      //     ),
      //     if (widget.userItem.region != null) ...[
      //       CommonWidgets.verticalSpacerWidget(8),
      //       Row(
      //         children: [
      //           textHandling('Region : ',
      //               widget.userItem.region?.name.toString() ?? " "),
      //         ],
      //       ),
      //     ],
      //     if (widget.userItem.location != null) ...[
      //       CommonWidgets.verticalSpacerWidget(8),
      //       Row(
      //         children: [
      //           textHandling('Location : ',
      //               widget.userItem.location?.name.toString() ?? " "),
      //         ],
      //       ),
      //     ],
      //     if (widget.userItem.entity != null) ...[
      //       CommonWidgets.verticalSpacerWidget(8),
      //       Row(
      //         children: [
      //           textHandling(
      //               'Entity : ', widget.userItem.entity?.name.toString() ?? ""),
      //         ],
      //       ),
      //     ],
      //     if (widget.userItem.expiryDate != null) ...[
      //       CommonWidgets.verticalSpacerWidget(8),
      //       Row(
      //         children: [
      //           textHandling(
      //               'Expiry Date : ',
      //               widget.userItem.expiryDate != null
      //                   ? Utils.timestampToDateConversion(
      //                       int.parse(widget.userItem.expiryDate ?? '0'),
      //                       Constants.dateFormat)
      //                   : ''),
      //         ],
      //       ),
      //     ],
      //     CommonWidgets.verticalSpacerWidget(8),
      //     Row(
      //       children: [
      //         textHandling('Is Dws Pass : ', widget.userItem.dws.toString()),
      //       ],
      //     ),
      //     // CommonWidgets.verticalSpacerWidget(8),
      //     // Row(
      //     //   children: [
      //     //     textHandling(
      //     //         'Remarks : ',  " "),
      //     //   ],
      //     // ),
      //     CommonWidgets.verticalSpacerWidget(8),
      //     Row(
      //       children: [
      //         Utils().buildPassManagementStatusRow(widget.userItem.status ?? 0),
      //       ],
      //     )
      //   ])
      //           //),
      //           //    ),
      //           ),
        // ],
      // ),
      // ),
    );
  }
}
