import 'dart:ui';

import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/models/day_passlist_model.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DayPassRegisterListItem extends StatefulWidget {
  final Function? onTap;
  final Function? oneditTap;
  final Function? onviewTap;
  PassInfo userItem;
  int? index;

  DayPassRegisterListItem({
    super.key,
    this.onTap,
    this.oneditTap,
    this.onviewTap,
    required this.userItem,
    this.index,
  });

  @override
  State<DayPassRegisterListItem> createState() =>
      _DayPassRegisterListItemState();
}

class _DayPassRegisterListItemState extends State<DayPassRegisterListItem> {
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
              style: Styles.textStyleRegularNormalWhite18,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              // Color(0xFF6474C6),
              // Color(0xFF6474C6),
              Colors.transparent,
              Colors.transparent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        margin: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 8),

        child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 18, sigmaY: 18),
                child: Container(
                    decoration:
                    BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.09),
                          Colors.transparent,
                          Colors.white.withValues(alpha: 0.09),
                          // Color(0xFF6474C6).withOpacity(0.14)
                        ],
                        stops: [0.02, 0.35, 1],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(27),
                      border: Border.all(
                        color: Colors.white
                            .withValues(alpha: 0.6),
                        width: 0.7,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white
                              .withValues(alpha: 0.0),
                          blurRadius: 12,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          widget.onTap != null ? widget.onTap!(widget.index) : null;
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(children: [
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     textHandling('ID : ', widget.userItem.id.toString()),
                              //   ],
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  textHandling('ID : ', widget.userItem.id.toString()),
                                  IconButton(
                                    onPressed: () {
                                      if (widget.onviewTap != null) widget.onviewTap!(widget.index);
                                    },
                                    icon: Image.asset(
                                      'assets/images/eye.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                ],
                              ),
                              if (widget.userItem.region != null) ...[
                                Row(
                                  children: [
                                    textHandling('Region : ',
                                        widget.userItem.region?.name ?? ''),
                                  ],
                                ),
                              ],
                              if (widget.userItem.location != null) ...[
                                Column(
                                  children: [
                                    CommonWidgets.verticalSpacerWidget(5),
                                    Row(
                                      children: [
                                        textHandling('Location : ',
                                            widget.userItem.location?.name ?? ''),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                              if (widget.userItem.expiryDate != null) ...[
                                CommonWidgets.verticalSpacerWidget(5),
                                Row(
                                  children: [
                                    textHandling(
                                        'Expiry Date: ',
                                        widget.userItem.expiryDate != null
                                            ? Utils.timestampToDateConversion(
                                            int.tryParse(
                                                widget.userItem.expiryDate ?? '0'),
                                            Constants.dateFormat)
                                            : ''),
                                  ],
                                ),
                              ],
                              CommonWidgets.verticalSpacerWidget(5),
                              Row(
                                children: [
                                  // Text(
                                  //   'Status : ${widget.userItem.status}',
                                  //   style: Styles.textStyleSemiBoldGrey14,
                                  textHandling('CardNo : ',
                                      (widget.userItem.passNo ?? '').toString()),
                                ],
                              ),
                              CommonWidgets.verticalSpacerWidget(5),
                              Row(
                                children: [
                                  Utils().buildPassManagementStatusRow(widget.userItem.status ?? 0),
                                ],
                              ),
                              // Container(
                              //   alignment: Alignment.topCenter,
                              //   child: Row(
                              //     children: [
                              //       IconButton(
                              //         onPressed: () {
                              //           //do action on view
                              //           widget.onviewTap != null
                              //               ? widget.onviewTap!(widget.index)
                              //               : null;
                              //         },
                              //         icon: Image.asset(
                              //           'assets/images/eye.png',
                              //           width: 30,
                              //           height: 30,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ]))
                    )
                ))));
    // return Column(
    //
    //   children: [
    //     Card(
    //         // elevation: 5,
    //         // shape: RoundedRectangleBorder(
    //         //   side:
    //         //       const BorderSide(color: AppColors.searchBarBorder, width: 1),
    //         //   borderRadius: circularBorderRadius10,
    //         // ),
    //         child: InkWell(
    //             onTap: () {
    //               HapticFeedback.lightImpact();
    //               widget.onTap != null ? widget.onTap!(widget.index) : null;
    //             },
    //             borderRadius: BorderRadius.circular(8),
    //             child: Padding(
    //                 padding: const EdgeInsets.all(20),
    //                 child: Column(children: [
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       textHandling('ID : ', widget.userItem.id.toString()),
    //                     ],
    //                   ),
    //                   if (widget.userItem.region != null) ...[
    //                     Row(
    //                       children: [
    //                         textHandling('Region : ',
    //                             widget.userItem.region?.name ?? ''),
    //                       ],
    //                     ),
    //                   ],
    //                   if (widget.userItem.location != null) ...[
    //                     Column(
    //                       children: [
    //                         CommonWidgets.verticalSpacerWidget(5),
    //                         Row(
    //                           children: [
    //                             textHandling('Location : ',
    //                                 widget.userItem.location?.name ?? ''),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                   if (widget.userItem.expiryDate != null) ...[
    //                     CommonWidgets.verticalSpacerWidget(5),
    //                     Row(
    //                       children: [
    //                         textHandling(
    //                             'Expiry Date: ',
    //                             widget.userItem.expiryDate != null
    //                                 ? Utils.timestampToDateConversion(
    //                                     int.tryParse(
    //                                         widget.userItem.expiryDate ?? '0'),
    //                                     Constants.dateFormat)
    //                                 : ''),
    //                       ],
    //                     ),
    //                   ],
    //                   CommonWidgets.verticalSpacerWidget(5),
    //                   Row(
    //                     children: [
    //                       // Text(
    //                       //   'Status : ${widget.userItem.status}',
    //                       //   style: Styles.textStyleSemiBoldGrey14,
    //                       textHandling('PassNo : ',
    //                           (widget.userItem.passNo ?? '').toString()),
    //                     ],
    //                   ),
    //                   CommonWidgets.verticalSpacerWidget(5),
    //                   Row(
    //                     children: [
    //                       Utils().buildPassManagementStatusRow(widget.userItem.status ?? 0),
    //                     ],
    //                   ),
    //                   Container(
    //                     alignment: Alignment.topCenter,
    //                     child: Row(
    //                       children: [
    //                         IconButton(
    //                           onPressed: () {
    //                             //do action on view
    //                             widget.onviewTap != null
    //                                 ? widget.onviewTap!(widget.index)
    //                                 : null;
    //                           },
    //                           icon: SvgPicture.asset(AppIcon.viewIcon),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ]))
    // )
    // ),
    //     CommonWidgets.verticalSpacerWidget(5),
    //   ],
    // );
  }
}
