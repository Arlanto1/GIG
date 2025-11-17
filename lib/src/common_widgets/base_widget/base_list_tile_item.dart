import 'package:db_atom/index.dart';

class BaseListTileItem extends StatefulWidget {
  final num? id;
  final Organisation? location;
  final bool? returnable;
  final Organisation? locationRegion;
  final String? inputDate;
  final int? status;
  final String? vendor;
  final String? region;
  final int? guardCount;
  final int? pvcExpired;
  final int? msgbExempted;
  final List<Label>? labels;
  final String? locationStr;
  final int? guardRank;
  final Function? onTap;
  final Function? onEditTap;
  final Function? onViewTap;
  final Function? onDeleteTap;
  final Function? onEmailTap;
  final Function? onLinkOffTap;
  final int? incidentType;
  final bool isIncident;
  final Organisation? vendors;

  // final Item userItem;
  final int? index;

  final bool? showViewButton;
  final bool? showDeleteButton;
  final bool? showEmailButton;
  final bool? showLinkOffButton;
  final bool isMasterGuard;
  final bool? isMasterGuardRank;
  final bool isEventProtectionStatus;
  final bool isOccurrenceStatus;
  final bool isSLAViolationStatus;
  final bool isContactDetailsStatus;
  final bool isSecuritySystemSLA;
  final bool isKeyLossStatus;
  final bool isKeyManagementStatus;
  final bool isKeyManagementIssuanceStatus;
  final bool isVipStatus;
  final bool isMaterialMovementStatus;
  final bool isKeyManagementHistoryStatus;
  final bool isShiftScheduleStatus;
  final bool isDutyPostNameMasterStatus;
  final bool isAttendanceStatus;
  final bool? showEditButton;
  final bool isPassManagementStatus;
  final bool isLawEnforcementStatus;
  final bool isArticleFoundStatus;

  const BaseListTileItem({
    super.key,
    this.id,
    this.location,
    this.locationRegion,
    this.inputDate,
    this.status,
    this.onTap,
    this.onEditTap,
    this.showViewButton,
    this.onViewTap,
    this.onEmailTap,
    this.onLinkOffTap,
    this.index,
    this.region,
    this.vendor,
    this.guardCount,
    this.pvcExpired,
    this.msgbExempted,
    this.returnable,
    this.isIncident = false,
    this.locationStr,
    this.guardRank,
    this.labels,
    this.isMasterGuard = false,
    this.isMasterGuardRank,
    this.isEventProtectionStatus = true,
    this.isOccurrenceStatus = false,
    this.isSLAViolationStatus = false,
    this.incidentType,
    this.isContactDetailsStatus = false,
    this.isSecuritySystemSLA = false,
    this.isKeyLossStatus = false,
    this.isKeyManagementStatus = false,
    this.isKeyManagementIssuanceStatus = false,
    this.isVipStatus = false,
    this.isMaterialMovementStatus = false,
    this.onDeleteTap,
    this.isKeyManagementHistoryStatus = false,
    this.isDutyPostNameMasterStatus = false,
    this.isShiftScheduleStatus = false,
    this.isAttendanceStatus = false,
    this.vendors,
    this.showEditButton = false,
    this.showDeleteButton = true,
    this.showEmailButton = false,
    this.showLinkOffButton = false,
    this.isPassManagementStatus = false,
    this.isLawEnforcementStatus = false,
    this.isArticleFoundStatus = false,
  });

  @override
  State<BaseListTileItem> createState() => _BaseListTileItemState();
}

class _BaseListTileItemState extends State<BaseListTileItem> {
  bool isHovered = true;

  // @override
  // Widget build(BuildContext context) {
  //   final size = MediaQuery.of(context).size;
  //   final width = size.width;
  //   return Padding(
  //     padding: const EdgeInsets.all(2.5),
  //     child: Card(
  //       elevation: 5,
  //       shape: RoundedRectangleBorder(
  //         side: const BorderSide(color: AppColors.black, width: 1),
  //         borderRadius: circularBorderRadius10,
  //       ),
  //       child: InkWell(
  //         onTap: () {
  //           HapticFeedback.lightImpact();
  //           widget.onTap != null ? widget.onTap!(widget.index) : null;
  //         },
  //         borderRadius: BorderRadius.circular(8),
  //         child: Padding(
  //           padding: const EdgeInsets.all(15),
  //           child: Wrap(children: getChildren(widget.labels, width)),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        widget.onTap?.call(widget.index);
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          children: getChildren(widget.labels, width),
        ),
      ),
    );
  }

  List<Widget> getChildren(List<Label>? labels, width) {
    List<Widget> widgets = [];

    // log('--width------$width-------tab--${width * .78}---------------${width / 2}-');

    widgets = [
      Wrap(
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width > 389 ? width * .60 : width * .55,
            // height: 90,
            child: Wrap(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicWidth(
                  stepWidth: width * .2,
                  child: Wrap(
                    children: [
                      Utils().textHandling('ID : ', widget.id.toString()),
                      if (widget.locationRegion != null) ...[
                        Row(
                          children: [
                            Utils().textHandling(
                                'Region : ', widget.locationRegion?.name ?? ''),
                          ],
                        ),
                      ],
                      if (widget.location != null) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Utils().textHandling(
                                'Location : ', widget.location?.name ?? ''),
                          ],
                        ),
                      ],
                      if (widget.locationStr != null) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Utils().textHandling(
                                'Location : ', widget.locationStr.toString()),
                          ],
                        ),
                      ],
                      if (widget.vendors != null) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Utils().textHandling(
                                'Vendor : ', widget.vendors?.name ?? ''),
                          ],
                        ),
                      ],
                      if (widget.guardCount != null) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Utils().textHandling(
                                'Guard Count : ', widget.guardCount.toString()),
                          ],
                        ),
                      ],
                      if (widget.pvcExpired != null) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Utils().textHandling(
                                'Total No of Staff PVC Expired : ',
                                widget.pvcExpired.toString()),
                          ],
                        ),
                      ],
                      if (widget.vendor != null) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Row(
                          children: [
                            Utils().textHandling(
                                'Vendor : ', widget.vendor.toString()),
                          ],
                        ),
                      ],
                      if ((widget.status != null &&
                              widget.isMaterialMovementStatus == true) &&
                          !widget.isMasterGuard) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Utils()
                            .buildMaterialMovementStatusRow(widget.status ?? 0),
                      ],
                      if (widget.status != 0 && widget.isMasterGuard) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Utils().buildMasterDataStatusRow(widget.status ?? 0),
                      ],
                      if (widget.guardRank != -1 && widget.isMasterGuard) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Utils().buildGuardRank(
                                guardRank: widget.guardRank ?? 0),
                          ],
                        ),
                      ],
                      if (widget.status != null &&
                          widget.isKeyManagementIssuanceStatus) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Utils().keyManagementIssuanceStatus(widget.status ?? 0),
                      ],
                      if (widget.status != null &&
                          widget.isAttendanceStatus == true) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Utils().buildAttendanceStatusRow(
                            status: widget.status ?? 0),
                      ],
                      if (widget.status != null &&
                          widget.isKeyManagementStatus) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Utils().keyManagementStatus(widget.status ?? 0),
                      ],
                      if (widget.status != null &&
                          widget.isKeyManagementHistoryStatus) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Utils().keyManagementMasterHistoryStatus(
                            widget.status ?? 0),
                      ],
                      if (widget.status != null &&
                          widget.isOccurrenceStatus == true) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Utils().buildOccurrenceStatus(widget.status ?? 0),
                          ],
                        ),
                      ],
                      if (widget.status != null &&
                          widget.isKeyLossStatus == true) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Utils().keyLossDestructionStatus(widget.status ?? 0),
                      ],
                      if (widget.status != null &&
                          widget.isSLAViolationStatus == true) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Utils().buildSLAViolationStatus(widget.status ?? 0),
                      ],
                      if (widget.status != null &&
                          widget.isIncident == true) ...[
                        CommonWidgets.verticalSpacerWidget(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Utils().buildIncidentStatus(widget.status ?? 0),
                          ],
                        ),
                      ],
                      if (widget.incidentType != null) ...[
                        CommonWidgets.verticalSpacerWidget(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Utils().incidentType(widget.incidentType ?? 0),
                          ],
                        ),
                      ],
                      if (widget.status != null &&
                          widget.isContactDetailsStatus == true &&
                          widget.isEventProtectionStatus == false) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Utils().contactDetailsStatus(widget.status ?? 0),
                      ],
                      if (widget.status != null &&
                          widget.isEventProtectionStatus == false &&
                          widget.isSecuritySystemSLA == true) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Utils()
                            .buildSecuritySystemStatusRow(widget.status ?? 0),
                      ],
                      if (widget.isVipStatus == true) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Utils().vIPVisitorStatusRow(widget.status ?? 0),
                      ],
                      if (widget.status != null &&
                          widget.isShiftScheduleStatus == true) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Utils().shiftScheduleStatusRow(widget.status ?? 0),
                          ],
                        ),
                      ],
                      if (widget.status != null &&
                          widget.isDutyPostNameMasterStatus == true) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Utils()
                                .dutyPostNameMasterStatus(widget.status ?? 0),
                          ],
                        )
                      ],
                      if (widget.status != null &&
                          widget.isPassManagementStatus == true &&
                          !widget.isShiftScheduleStatus) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Utils()
                            .buildPassManagementStatusRow(widget.status ?? 0),
                      ],
                      if (widget.status != null &&
                          widget.isLawEnforcementStatus == true &&
                          !widget.isShiftScheduleStatus) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Utils().buildLeoStatusRow(widget.status ?? 0),
                      ],
                    ],
                  ),
                ),
                getLabelWidgets(labels),
                if (widget.status != null &&
                    widget.isArticleFoundStatus == true &&
                    !widget.isShiftScheduleStatus) ...[
                  CommonWidgets.horizontalSpacerWidget(5),
                  Utils().buildFoundStatusRow(widget.status ?? 0),
                  CommonWidgets.verticalSpacerWidget(6),
                ],
                if (widget.status != null &&
                    widget.isEventProtectionStatus &&
                    !widget.isMasterGuard) ...[
                  CommonWidgets.horizontalSpacerWidget(5),
                  Utils()
                      .buildEventProtectionStatusRow(widget.status ?? 0),
                ],
              ],
            ),
          ),
          IntrinsicWidth(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    //do action on view
                    widget.onEditTap != null
                        ? widget.onEditTap!(widget.index)
                        : null;
                  },
                  icon: widget.showEditButton ?? true
                      ? const Icon(Icons.edit, color: Color(0xFF0000CC))
                      : const Icon(Icons.edit_off_outlined, color:  Color(0xFF0000CC),),
                ),

                // if (widget.showNonEditButton ?? true) ...[
                //   IconButton(
                //     onPressed: () {
                //       //do action on view
                //       widget.onEditTap != null
                //           ? widget.onEditTap!(widget.index)
                //           : null;
                //     },
                //     icon: const Icon(Icons.edit_off_outlined),
                //   ),
                // ],
                if (widget.showViewButton ?? true) ...[
                  // IconButton(
                  //   onPressed: () {
                  //     //do action on view
                  //     widget.onViewTap != null
                  //         ? widget.onViewTap!(widget.index)
                  //         : null;
                  //   },
                  //   // icon: const Icon(Icons.remove_red_eye, color: Color(0xFF071130)),
                  //   icon: const Icon(Icons.remove_red_eye, color: Color(0xFF02257F)),
                  //
                  // ),
                  IconButton(
                    onPressed: () {
                      //do action on view
                      widget.onViewTap != null
                          ? widget.onViewTap!(widget.index)
                          : null;
                    },
                    icon: Image.asset(
                      'assets/images/eye.png',
                      width: 30,
                      height: 30,
                    ),
                  ),
                ],
                if (widget.isSecuritySystemSLA == true && widget.status == 2 ||
                    widget.status == 3 ||
                    widget.status == 4 ||
                    widget.status == 5 ||
                    widget.status == 8 ||
                    widget.status == 10 ||
                    widget.status == 12) ...[
                  if (widget.showEmailButton ?? true) ...[
                    IconButton(
                      onPressed: () {
                        widget.onEmailTap != null
                            ? widget.onEmailTap!(widget.index)
                            : null;
                      },
                      icon: const Icon(Icons.email, color:  Color(0xFF0000CC)),
                    ),
                  ],
                ],
                if (widget.showLinkOffButton ?? true) ...[
                  IconButton(
                    onPressed: () {
                      widget.onLinkOffTap != null
                          ? widget.onLinkOffTap!(widget.index)
                          : null;
                    },
                    icon: const Icon(Icons.link_off, color:  Color(0xFF0000CC)),
                  ),
                ],
                if (widget.showDeleteButton ?? true) ...[
                  if (widget.onDeleteTap != null) ...[
                    IconButton(
                      onPressed: () {
                        //do action on view
                        widget.onDeleteTap != null
                            ? widget.onDeleteTap!(widget.index)
                            : null;
                      },
                      icon: const Icon(Icons.delete, color:  Color(0xFF0000CC)),
                    ),
                  ]
                ],
              ],
            ),
          ),
          // IntrinsicWidth(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       // Reusable builder for each icon button
          //       if (widget.showEditButton ?? true)
          //         _buildIconButton(
          //           tooltip: 'Edit',
          //           onTap: () => widget.onEditTap?.call(widget.index),
          //           icon: Icons.edit,
          //           color:  const Color(0xFF1E40AF),
          //         )
          //       else
          //         _buildIconButton(
          //           tooltip: 'Edit Disabled',
          //           onTap:  () => widget.onEditTap?.call(widget.index), // Disabled state
          //           icon:
          //             Icons.edit_off_outlined,
          //             color:const Color(0xFF1E40AF),
          //         ),
          //
          //       if (widget.showViewButton ?? true)
          //         _buildIconButton(
          //           // imagePath: 'assets/images/viewFile1.jpeg',
          //           // color: Colors.transparent,
          //           tooltip: "View Details",
          //           onTap: () => widget.onViewTap?.call(widget.index),
          //           icon: Image.asset(
          //             'assets/app_icon/img.png',
          //             width: 24,
          //             height: 24,
          //           ),
          //         ),
          //
          //       if ((widget.isSecuritySystemSLA == true &&
          //               widget.status == 2) ||
          //           widget.status == 3 ||
          //           widget.status == 4 ||
          //           widget.status == 5 ||
          //           widget.status == 8 ||
          //           widget.status == 10 ||
          //           widget.status == 12)
          //         if (widget.showEmailButton ?? true)
          //           _buildIconButton(
          //             icon: Icons.email_outlined,
          //             color: const Color(0xFF0057D8),
          //             tooltip: "Send Email",
          //             onTap: () => widget.onEmailTap?.call(widget.index),
          //           ),
          //
          //       if (widget.showLinkOffButton ?? true)
          //         _buildIconButton(
          //           icon: Icons.link_off,
          //           color: const Color(0xFFDA3C3C),
          //           tooltip: "Unlink",
          //           onTap: () => widget.onLinkOffTap?.call(widget.index),
          //         ),
          //
          //       if (widget.showDeleteButton ?? true) ...[
          //         if (widget.onDeleteTap != null) ...[
          //           _buildIconButton(
          //             icon: Icons.delete_outline,
          //             color: const Color(0xFFB71C1C),
          //             tooltip: "Delete",
          //             onTap: () => widget.onDeleteTap?.call(widget.index),
          //           ),
          //         ]
          //       ],
          //
          //     ],
          //   ),
          // ),
        ],
      ),
    ];

    return widgets;
  }


  // Widget _buildIconButton({
  //   required IconData icon,
  //   required Color color,
  //   required VoidCallback onTap,
  //   String? tooltip,
  // }) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 4.0),
  //     child: Tooltip(
  //       message: tooltip ?? '',
  //       child: InkWell(
  //         borderRadius: BorderRadius.circular(30),
  //         onTap: onTap,
  //         splashColor: color.withValues(alpha: 0.3),
  //         child: AnimatedContainer(
  //           duration: const Duration(milliseconds: 200),
  //           width: 0,
  //           height: 0,
  //           decoration: BoxDecoration(
  //             color: Colors.white.withValues(alpha: 0.3),
  //             border: Border.all(color: color.withValues(alpha:0.1), width: 2),
  //             borderRadius: BorderRadius.circular(30),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: color.withValues(alpha: 0.6),
  //                 blurRadius: 0,
  //                 offset: const Offset(0, 3),
  //               ),
  //             ],
  //             // backdropFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
  //           ),
  //           child: Icon(icon, color: color, size: 22),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget getLabelWidgets(List<Label>? labels) {
    List<Widget> widgets = [];

    for (Label label in labels ?? []) {
      if (label.value == 'null' || label.value.isEmpty) {
        continue;
      }
      widgets.add(CommonWidgets.verticalSpacerWidget(5));
      widgets.add(
        IntrinsicWidth(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Wrap(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Utils().textHandling('${label.key} : ', label.value),
              ],
            ),
          ),
        ),
      );
    }
    return Wrap(
      children: widgets,
    );
  }
}

class Label {
  final String key;
  final String value;

  const Label({
    required this.key,
    required this.value,
  });
}

// import 'dart:ui';
// import 'package:db_atom/index.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class BaseListTileItem extends StatefulWidget {
//   final num? id;
//   final Organisation? location;
//   final bool? returnable;
//   final Organisation? locationRegion;
//   final String? inputDate;
//   final int? status;
//   final String? vendor;
//   final String? region;
//   final int? guardCount;
//   final int? pvcExpired;
//   final int? msgbExempted;
//   final List<Label>? labels;
//   final String? locationStr;
//   final int? guardRank;
//   final Function? onTap;
//   final Function? onEditTap;
//   final Function? onViewTap;
//   final Function? onDeleteTap;
//   final Function? onEmailTap;
//   final Function? onLinkOffTap;
//   final int? incidentType;
//   final bool isIncident;
//   final Organisation? vendors;
//   final int? index;
//   final bool? showViewButton;
//   final bool? showDeleteButton;
//   final bool? showEmailButton;
//   final bool? showLinkOffButton;
//   final bool isMasterGuard;
//   final bool? isMasterGuardRank;
//   final bool isEventProtectionStatus;
//   final bool isOccurrenceStatus;
//   final bool isSLAViolationStatus;
//   final bool isContactDetailsStatus;
//   final bool isSecuritySystemSLA;
//   final bool isKeyLossStatus;
//   final bool isKeyManagementStatus;
//   final bool isKeyManagementIssuanceStatus;
//   final bool isVipStatus;
//   final bool isMaterialMovementStatus;
//   final bool isKeyManagementHistoryStatus;
//   final bool isShiftScheduleStatus;
//   final bool isDutyPostNameMasterStatus;
//   final bool isAttendanceStatus;
//   final bool? showEditButton;
//   final bool isPassManagementStatus;
//   final bool isLawEnforcementStatus;
//   final bool isArticleFoundStatus;
//
//   const BaseListTileItem({
//     super.key,
//     this.id,
//     this.location,
//     this.locationRegion,
//     this.inputDate,
//     this.status,
//     this.onTap,
//     this.onEditTap,
//     this.showViewButton,
//     this.onViewTap,
//     this.onEmailTap,
//     this.onLinkOffTap,
//     this.index,
//     this.region,
//     this.vendor,
//     this.guardCount,
//     this.pvcExpired,
//     this.msgbExempted,
//     this.returnable,
//     this.isIncident = false,
//     this.locationStr,
//     this.guardRank,
//     this.labels,
//     this.isMasterGuard = false,
//     this.isMasterGuardRank,
//     this.isEventProtectionStatus = true,
//     this.isOccurrenceStatus = false,
//     this.isSLAViolationStatus = false,
//     this.incidentType,
//     this.isContactDetailsStatus = false,
//     this.isSecuritySystemSLA = false,
//     this.isKeyLossStatus = false,
//     this.isKeyManagementStatus = false,
//     this.isKeyManagementIssuanceStatus = false,
//     this.isVipStatus = false,
//     this.isMaterialMovementStatus = false,
//     this.onDeleteTap,
//     this.isKeyManagementHistoryStatus = false,
//     this.isDutyPostNameMasterStatus = false,
//     this.isShiftScheduleStatus = false,
//     this.isAttendanceStatus = false,
//     this.vendors,
//     this.showEditButton = false,
//     this.showDeleteButton = true,
//     this.showEmailButton = false,
//     this.showLinkOffButton = false,
//     this.isPassManagementStatus = false,
//     this.isLawEnforcementStatus = false,
//     this.isArticleFoundStatus = false,
//   });
//
//   @override
//   State<BaseListTileItem> createState() => _BaseListTileItemState();
// }
//
// class _BaseListTileItemState extends State<BaseListTileItem> {
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//
//     return Padding(
//       padding: const EdgeInsets.all(6.0),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(12),
//             onTap: () {
//               HapticFeedback.lightImpact();
//               widget.onTap?.call(widget.index);
//             },
//             child: Container(
//               width: double.infinity,
//               // decoration: BoxDecoration(
//               //   color: Colors.white.withOpacity(0.08),
//               //   border: Border.all(color: Colors.white.withOpacity(0.25), width: 1),
//               //   borderRadius: BorderRadius.circular(12),
//               //   boxShadow: [
//               //     BoxShadow(
//               //       color: Colors.black.withOpacity(0.35),
//               //       offset: const Offset(0, 6),
//               //       blurRadius: 12,
//               //     ),
//               //   ],
//               // ),
//               // child: Container(
//               // decoration: BoxDecoration(
//               //   gradient: const LinearGradient(
//               //     begin: Alignment.topLeft,
//               //     end: Alignment.bottomRight,
//               //     colors: [
//               //       Colors.transparent,
//               //       Colors.transparent,
//               //       // Color(0xFF2C3E7E),
//               //       // Color(0xFF2C3E7E),
//               //       // Color(0xFF101D45),
//               //     ],
//               //   ),
//               //   borderRadius: BorderRadius.circular(16),
//               //   border: Border.all(
//               //     color: Colors.white.withOpacity(0.7),
//               //     width: 1.3,
//               //   ),
//               //   boxShadow: [
//               //     // BoxShadow(
//               //     //   color: const Color(0xFF7DA2FF).withOpacity(0.5),
//               //     //   blurRadius: 12,
//               //     //   spreadRadius: 2,
//               //     // ),
//               //     const BoxShadow(
//               //       color: Colors.transparent,
//               //       offset: Offset(0, 3),
//               //       blurRadius: 6,
//               //     ),
//               //   ],
//               // ),
//               padding: const EdgeInsets.all(15),
//               child: Wrap(
//                 children: getChildren(widget.labels, width),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   List<Widget> getChildren(List<Label>? labels, double width) {
//     return [
//       Wrap(
//         alignment: WrapAlignment.spaceBetween,
//         runAlignment: WrapAlignment.spaceBetween,
//         children: [
//           SizedBox(
//             width: width > 389 ? width * .78 : width * .55,
//             child: Wrap(
//               children: [
//                 IntrinsicWidth(
//                   stepWidth: width * .6,
//                   child: Wrap(
//                     children: [
//                       Utils().textHandling('ID : ', widget.id.toString()),
//                       if (widget.status != null &&
//                           widget.isArticleFoundStatus == true &&
//                           !widget.isShiftScheduleStatus) ...[
//                         CommonWidgets.horizontalSpacerWidget(5),
//                         Utils().buildFoundStatusRow(widget.status ?? 0),
//                       ],
//                     ],
//                   ),
//                 ),
//                 getLabelWidgets(labels),
//               ],
//             ),
//           ),
//           IntrinsicWidth(
//             child: Row(
//               children: [
//                 IconButton(
//                   onPressed: () => widget.onEditTap?.call(widget.index),
//                   icon: const Icon(Icons.edit, color: Colors.white70),
//                 ),
//                 IconButton(
//                   onPressed: () => widget.onViewTap?.call(widget.index),
//                   icon: const Icon(Icons.remove_red_eye, color: Colors.white70),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ];
//   }
//
//   Widget getLabelWidgets(List<Label>? labels) {
//     final widgets = <Widget>[];
//     for (final label in labels ?? []) {
//       if (label.value == 'null' || label.value.isEmpty) continue;
//       widgets.add(CommonWidgets.verticalSpacerWidget(5));
//       widgets.add(
//         IntrinsicWidth(
//           child: Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: Wrap(
//               children: [
//                 Utils().textHandling('${label.key} : ', label.value),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//     return Wrap(children: widgets);
//   }
// }
//
// class Label {
//   final String key;
//   final String value;
//   const Label({required this.key, required this.value});
// }
