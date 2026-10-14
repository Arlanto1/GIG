// // // // import 'package:db_atom/index.dart';
// // // // //
// // // // // class BaseListTileItem extends StatefulWidget {
// // // // //   final num? id;
// // // // //   final Organisation? location;
// // // // //   final bool? returnable;
// // // // //   final Organisation? locationRegion;
// // // // //   final String? inputDate;
// // // // //   final int? status;
// // // // //   final String? vendor;
// // // // //   final String? region;
// // // // //   final int? guardCount;
// // // // //   final int? pvcExpired;
// // // // //   final int? msgbExempted;
// // // // //   final List<Label>? labels;
// // // // //   final String? locationStr;
// // // // //   final int? guardRank;
// // // // //   final Function? onTap;
// // // // //   final Function? onEditTap;
// // // // //   final Function? onViewTap;
// // // // //   final Function? onDeleteTap;
// // // // //   final Function? onEmailTap;
// // // // //   final Function? onLinkOffTap;
// // // // //   final Function? onApproveTap;
// // // // //   final int? incidentType;
// // // // //   final bool isIncident;
// // // // //   final Organisation? vendors;
// // // // //   final int? workShift;
// // // // //   final bool isWorkShift;
// // // // //   final int? transportIncidentType;
// // // // //   final Function? onLaunchTap;
// // // // //
// // // // //   // final Item userItem;
// // // // //   final int? index;
// // // // //
// // // // //   final bool? showViewButton;
// // // // //   final bool? showDeleteButton;
// // // // //   final bool? showEmailButton;
// // // // //   final bool? showLinkOffButton;
// // // // //   final bool? showApproveButton;
// // // // //   final bool isMasterGuard;
// // // // //   final bool? isMasterGuardRank;
// // // // //   final bool isEventProtectionStatus;
// // // // //   final bool isOccurrenceStatus;
// // // // //   final bool isSLAViolationStatus;
// // // // //   final bool isContactDetailsStatus;
// // // // //   final bool isSecuritySystemSLA;
// // // // //   final bool isKeyLossStatus;
// // // // //   final bool isKeyManagementStatus;
// // // // //   final bool isKeyManagementIssuanceStatus;
// // // // //   final bool isVipStatus;
// // // // //   final bool isMaterialMovementStatus;
// // // // //   final bool isKeyManagementHistoryStatus;
// // // // //   final bool isShiftScheduleStatus;
// // // // //   final bool isDutyPostNameMasterStatus;
// // // // //   final bool isAttendanceStatus;
// // // // //   final bool? showEditButton;
// // // // //   final bool isPassManagementStatus;
// // // // //   final bool isLawEnforcementStatus;
// // // // //   final bool isArticleFoundStatus;
// // // // //   final bool isTicketStatus;
// // // // //   final bool isTransportStatus;
// // // // //   final bool isCSREventProtectionStatus;
// // // // //   final bool isPatrollingStatus;
// // // // //   final bool isDutyPostMasterStatus;
// // // // //   final bool? showLaunchButton;
// // // // //   final bool isParkingStatus;
// // // // //
// // // // //   const BaseListTileItem({
// // // // //     super.key,
// // // // //     this.id,
// // // // //     this.location,
// // // // //     this.locationRegion,
// // // // //     this.inputDate,
// // // // //     this.status,
// // // // //     this.onTap,
// // // // //     this.onEditTap,
// // // // //     this.showViewButton,
// // // // //     this.onViewTap,
// // // // //     this.onEmailTap,
// // // // //     this.onLinkOffTap,
// // // // //     this.onApproveTap,
// // // // //     this.showApproveButton = false,
// // // // //     this.index,
// // // // //     this.region,
// // // // //     this.vendor,
// // // // //     this.guardCount,
// // // // //     this.pvcExpired,
// // // // //     this.msgbExempted,
// // // // //     this.returnable,
// // // // //     this.isIncident = false,
// // // // //     this.locationStr,
// // // // //     this.guardRank,
// // // // //     this.labels,
// // // // //     this.isMasterGuard = false,
// // // // //     this.isMasterGuardRank = false,
// // // // //     this.isEventProtectionStatus = true,
// // // // //     this.isOccurrenceStatus = false,
// // // // //     this.isSLAViolationStatus = false,
// // // // //     this.incidentType,
// // // // //     this.isContactDetailsStatus = false,
// // // // //     this.isSecuritySystemSLA = false,
// // // // //     this.isKeyLossStatus = false,
// // // // //     this.isKeyManagementStatus = false,
// // // // //     this.isKeyManagementIssuanceStatus = false,
// // // // //     this.isVipStatus = false,
// // // // //     this.isMaterialMovementStatus = false,
// // // // //     this.onDeleteTap,
// // // // //     this.isKeyManagementHistoryStatus = false,
// // // // //     this.isDutyPostNameMasterStatus = false,
// // // // //     this.isShiftScheduleStatus = false,
// // // // //     this.isAttendanceStatus = false,
// // // // //     this.vendors,
// // // // //     this.showEditButton = false,
// // // // //     this.showDeleteButton = true,
// // // // //     this.showEmailButton = false,
// // // // //     this.showLinkOffButton = false,
// // // // //     this.isPassManagementStatus = false,
// // // // //     this.isLawEnforcementStatus = false,
// // // // //     this.isArticleFoundStatus = false,
// // // // //     this.workShift,
// // // // //     this.isWorkShift = false,
// // // // //     this.isTicketStatus = false,
// // // // //     this.isTransportStatus = false,
// // // // //     this.isCSREventProtectionStatus = false,
// // // // //     this.isPatrollingStatus = false,
// // // // //     this.isDutyPostMasterStatus = false,
// // // // //     this.transportIncidentType,
// // // // //     this.showLaunchButton = false,
// // // // //     this.isParkingStatus = false,
// // // // //     this.onLaunchTap,
// // // // //   });
// // // // //
// // // // //   @override
// // // // //   State<BaseListTileItem> createState() => _BaseListTileItemState();
// // // // // }
// // // // //
// // // // // class _BaseListTileItemState extends State<BaseListTileItem> {
// // // // //   bool isHovered = true;
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final size = MediaQuery.of(context).size;
// // // // //     final width = size.width;
// // // // //
// // // // //     return InkWell(
// // // // //       onTap: () {
// // // // //         HapticFeedback.lightImpact();
// // // // //         widget.onTap?.call(widget.index);
// // // // //       },
// // // // //       borderRadius: BorderRadius.circular(12),
// // // // //       child: Padding(
// // // // //         padding: const EdgeInsets.all(10),
// // // // //         child: Wrap(
// // // // //           children: getChildren(widget.labels, width),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   List<Widget> getChildren(List<Label>? labels, width) {
// // // // //     List<Widget> widgets = [];
// // // // //
// // // // //     widgets = [
// // // // //       Wrap(
// // // // //         alignment: WrapAlignment.spaceBetween,
// // // // //         runAlignment: WrapAlignment.spaceBetween,
// // // // //         children: [
// // // // //           SizedBox(
// // // // //             width: width > 389 ? width * .60 : width * .55,
// // // // //             // height: 90,
// // // // //             child: Wrap(
// // // // //               // mainAxisAlignment: MainAxisAlignment.start,
// // // // //               // crossAxisAlignment: CrossAxisAlignment.start,
// // // // //               children: [
// // // // //                 IntrinsicWidth(
// // // // //                   stepWidth: width * .2,
// // // // //                   child: Wrap(
// // // // //                     children: [
// // // // //                       Utils().textHandling('ID : ', widget.id.toString()),
// // // // //                       if (widget.locationRegion != null) ...[
// // // // //                         Row(
// // // // //                           children: [
// // // // //                             Utils().textHandling(
// // // // //                                 'Region : ', widget.locationRegion?.name ?? ''),
// // // // //                           ],
// // // // //                         ),
// // // // //                       ],
// // // // //                       if (widget.location != null) ...[
// // // // //                         CommonWidgets.horizontalSpacerWidget(5),
// // // // //                         Row(
// // // // //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                           children: [
// // // // //                             Utils().textHandling(
// // // // //                                 'Location : ', widget.location?.name ?? ''),
// // // // //                           ],
// // // // //                         ),
// // // // //                       ],
// // // // //                       if (widget.locationStr != null) ...[
// // // // //                         CommonWidgets.horizontalSpacerWidget(5),
// // // // //                         Row(
// // // // //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                           children: [
// // // // //                             Utils().textHandling(
// // // // //                                 'Location : ', widget.locationStr.toString()),
// // // // //                           ],
// // // // //                         ),
// // // // //                       ],
// // // // //                       if (widget.vendors != null) ...[
// // // // //                         CommonWidgets.horizontalSpacerWidget(5),
// // // // //                         Row(
// // // // //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                           children: [
// // // // //                             Expanded(
// // // // //                               child: Utils().textHandling(
// // // // //                                   'Vendor: ', widget.vendors?.name ?? ''),
// // // // //                             ),
// // // // //                           ],
// // // // //                         ),
// // // // //                       ],
// // // // //                       if (widget.guardCount != null) ...[
// // // // //                         CommonWidgets.horizontalSpacerWidget(5),
// // // // //                         Row(
// // // // //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                           children: [
// // // // //                             Utils().textHandling(
// // // // //                                 'Guard Count : ', widget.guardCount.toString()),
// // // // //                           ],
// // // // //                         ),
// // // // //                       ],
// // // // //                       if (widget.pvcExpired != null) ...[
// // // // //                         CommonWidgets.horizontalSpacerWidget(5),
// // // // //                         Row(
// // // // //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                           children: [
// // // // //                             Utils().textHandling(
// // // // //                                 'Total No of Staff PVC Expired : ',
// // // // //                                 widget.pvcExpired.toString()),
// // // // //                           ],
// // // // //                         ),
// // // // //                       ],
// // // // //                       if (widget.vendor != null) ...[
// // // // //                         CommonWidgets.horizontalSpacerWidget(5),
// // // // //                         Row(
// // // // //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                           children: [
// // // // //                             Expanded(
// // // // //                               child: Utils().textHandling(
// // // // //                                   'Vendor: ', '${widget.vendor?.toString()}'),
// // // // //                             ),
// // // // //                           ],
// // // // //                         ),
// // // // //                       ],
// // // // //                       if (widget.guardRank != -1 &&
// // // // //                           widget.isMasterGuardRank == true) ...[
// // // // //                         CommonWidgets.horizontalSpacerWidget(5),
// // // // //                         Row(
// // // // //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                           children: [
// // // // //                             Utils().buildGuardRank(
// // // // //                                 guardRank: widget.guardRank ?? 0),
// // // // //                           ],
// // // // //                         ),
// // // // //                       ],
// // // // //                       if (widget.workShift != -1 &&
// // // // //                           widget.isWorkShift == true) ...[
// // // // //                         CommonWidgets.horizontalSpacerWidget(5),
// // // // //                         Row(
// // // // //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                           children: [
// // // // //                             Utils().buildWorkShift(
// // // // //                                 workShift: widget.workShift ?? 0),
// // // // //                           ],
// // // // //                         ),
// // // // //                       ],
// // // // //                       if (widget.incidentType != null) ...[
// // // // //                         CommonWidgets.verticalSpacerWidget(5),
// // // // //                         Row(
// // // // //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                           children: [
// // // // //                             Utils().incidentType(widget.incidentType ?? 0),
// // // // //                           ],
// // // // //                         ),
// // // // //                       ],
// // // // //                       if (widget.transportIncidentType != null) ...[
// // // // //                         CommonWidgets.verticalSpacerWidget(5),
// // // // //                         Row(
// // // // //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                           children: [
// // // // //                             Utils().transportIncidentType(
// // // // //                                 widget.transportIncidentType ?? 0),
// // // // //                           ],
// // // // //                         ),
// // // // //                       ],
// // // // //                     ],
// // // // //                   ),
// // // // //                 ),
// // // // //                 getLabelWidgets(labels),
// // // // //                 if (widget.status != null &&
// // // // //                     widget.isArticleFoundStatus == true &&
// // // // //                     !widget.isShiftScheduleStatus) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Utils().buildFoundStatusRow(widget.status ?? 0),
// // // // //                   CommonWidgets.verticalSpacerWidget(6),
// // // // //                 ],
// // // // //                 if (widget.status != null &&
// // // // //                     widget.isEventProtectionStatus &&
// // // // //                     !widget.isMasterGuard) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Utils().buildEventProtectionStatusRow(widget.status ?? 0),
// // // // //                 ],
// // // // //                 if (widget.status != null &&
// // // // //                     widget.isCSREventProtectionStatus &&
// // // // //                     !widget.isMasterGuard) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Utils().buildCSRProtectionStatusRow(widget.status ?? 0),
// // // // //                 ],
// // // // //                 if (widget.status != null && widget.isIncident == true) ...[
// // // // //                   CommonWidgets.verticalSpacerWidget(5),
// // // // //                   Row(
// // // // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                     children: [
// // // // //                       Utils().buildIncidentStatus(widget.status ?? 0),
// // // // //                     ],
// // // // //                   ),
// // // // //                 ],
// // // // //                 if (widget.status != null &&
// // // // //                     widget.isLawEnforcementStatus == true &&
// // // // //                     !widget.isShiftScheduleStatus) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Utils().buildLeoStatusRow(widget.status ?? 0),
// // // // //                 ],
// // // // //                 if ((widget.status != null &&
// // // // //                         widget.isMaterialMovementStatus == true) &&
// // // // //                     !widget.isMasterGuard) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Row(
// // // // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                     children: [
// // // // //                       Expanded(
// // // // //                         child: Utils()
// // // // //                             .buildMaterialMovementStatusRow(widget.status ?? 0),
// // // // //                       ),
// // // // //                     ],
// // // // //                   ),
// // // // //                 ],
// // // // //                 if (widget.status != 0 && widget.isMasterGuard) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Utils().buildMasterDataStatusRow(widget.status ?? 0),
// // // // //                 ],
// // // // //                 if (widget.status != null &&
// // // // //                     widget.isKeyManagementIssuanceStatus) ...[
// // // // //                   Row(
// // // // //                     children: [
// // // // //                       CommonWidgets.horizontalSpacerWidget(5),
// // // // //                       Expanded(
// // // // //                         child: Utils()
// // // // //                             .keyManagementIssuanceStatus(widget.status ?? 0),
// // // // //                       ),
// // // // //                     ],
// // // // //                   )
// // // // //                 ],
// // // // //                 if (widget.status != null && widget.isPatrollingStatus) ...[
// // // // //                   Row(
// // // // //                     children: [
// // // // //                       CommonWidgets.horizontalSpacerWidget(5),
// // // // //                       Expanded(
// // // // //                         child: Utils().patrollingStatus(widget.status ?? 0),
// // // // //                       ),
// // // // //                     ],
// // // // //                   )
// // // // //                 ],
// // // // //                 if (widget.status != null && widget.isParkingStatus) ...[
// // // // //                   Row(
// // // // //                     children: [
// // // // //                       CommonWidgets.horizontalSpacerWidget(5),
// // // // //                       Expanded(
// // // // //                         child: Utils().parkingStatus(widget.status ?? 0),
// // // // //                       ),
// // // // //                     ],
// // // // //                   )
// // // // //                 ],
// // // // //                 if (widget.status != null &&
// // // // //                     widget.isAttendanceStatus == true) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Utils().buildAttendanceStatusRow(widget.status ?? 0),
// // // // //                 ],
// // // // //                 if (widget.status != null && widget.isKeyManagementStatus) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Utils().keyManagementStatus(widget.status ?? 0),
// // // // //                 ],
// // // // //                 if (widget.status != null &&
// // // // //                     widget.isKeyManagementHistoryStatus) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Utils().keyManagementMasterHistoryStatus(widget.status ?? 0),
// // // // //                 ],
// // // // //                 if (widget.status != null &&
// // // // //                     widget.isOccurrenceStatus == true) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Row(
// // // // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                     children: [
// // // // //                       Utils().buildOccurrenceStatus(widget.status ?? 0),
// // // // //                     ],
// // // // //                   ),
// // // // //                 ],
// // // // //                 if (widget.status != null &&
// // // // //                     widget.isKeyLossStatus == true) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Utils().keyLossDestructionStatus(widget.status ?? 0),
// // // // //                 ],
// // // // //                 if (widget.status != null &&
// // // // //                     widget.isSLAViolationStatus == true) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Utils().buildSLAViolationStatus(widget.status ?? 0),
// // // // //                 ],
// // // // //                 if (widget.status != null &&
// // // // //                     widget.isContactDetailsStatus == true &&
// // // // //                     widget.isEventProtectionStatus == false) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Utils().contactDetailsStatus(widget.status ?? 0),
// // // // //                 ],
// // // // //                 if (widget.status != null &&
// // // // //                     widget.isEventProtectionStatus == false &&
// // // // //                     widget.isSecuritySystemSLA == true) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Utils().buildSecuritySystemStatusRow(widget.status ?? 0),
// // // // //                 ],
// // // // //                 if (widget.isVipStatus == true) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Utils().vIPVisitorStatusRow(widget.status ?? 0),
// // // // //                 ],
// // // // //                 if (widget.status != null &&
// // // // //                     widget.isShiftScheduleStatus == true) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Row(
// // // // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                     children: [
// // // // //                       Utils().shiftScheduleStatusRow(widget.status ?? 0),
// // // // //                     ],
// // // // //                   ),
// // // // //                 ],
// // // // //                 if (widget.status != null &&
// // // // //                     widget.isTransportStatus == true) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Row(
// // // // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                     children: [
// // // // //                       Utils().transportMedicalStatus(widget.status ?? 0),
// // // // //                     ],
// // // // //                   )
// // // // //                 ],
// // // // //                 if (widget.status != null &&
// // // // //                     widget.isDutyPostNameMasterStatus == true) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Row(
// // // // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                     children: [
// // // // //                       Utils().dutyPostNameMasterStatus(widget.status ?? 0),
// // // // //                     ],
// // // // //                   )
// // // // //                 ],
// // // // //                 if (widget.status != null &&
// // // // //                     widget.isDutyPostMasterStatus == true) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Row(
// // // // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                     children: [
// // // // //                       Utils().dutyPostMasterStatus(widget.status ?? 0),
// // // // //                     ],
// // // // //                   )
// // // // //                 ],
// // // // //                 if (widget.status != null &&
// // // // //                     widget.isPassManagementStatus == true &&
// // // // //                     !widget.isShiftScheduleStatus) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Utils().buildPassManagementStatusRow(widget.status ?? 0),
// // // // //                 ],
// // // // //                 if (widget.status != null && widget.isTicketStatus) ...[
// // // // //                   CommonWidgets.horizontalSpacerWidget(5),
// // // // //                   Utils().buildTicketStatusRow(widget.status ?? 0),
// // // // //                 ],
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //           IntrinsicWidth(
// // // // //             child: Row(
// // // // //               children: [
// // // // //                 IconButton(
// // // // //                   onPressed: () {
// // // // //                     //do action on view
// // // // //                     widget.onEditTap != null
// // // // //                         ? widget.onEditTap!(widget.index)
// // // // //                         : null;
// // // // //                   },
// // // // //                   icon: widget.showEditButton ?? true
// // // // //                       ? const Icon(Icons.edit, color: AppColors.white)
// // // // //                       : const Icon(Icons.edit_off_outlined,
// // // // //                           color: AppColors.white),
// // // // //                 ),
// // // // //                 if (widget.showViewButton ?? true) ...[
// // // // //                   IconButton(
// // // // //                     onPressed: () {
// // // // //                       //do action on view
// // // // //                       widget.onViewTap != null
// // // // //                           ? widget.onViewTap!(widget.index)
// // // // //                           : null;
// // // // //                     },
// // // // //                     icon: Image.asset(
// // // // //                       'assets/images/eye.png',
// // // // //                       width: 30,
// // // // //                       height: 30,
// // // // //                     ),
// // // // //                   ),
// // // // //                 ],
// // // // //                 if (widget.isSecuritySystemSLA == true && widget.status == 2 ||
// // // // //                     widget.status == 3 ||
// // // // //                     widget.status == 4 ||
// // // // //                     widget.status == 5 ||
// // // // //                     widget.status == 8 ||
// // // // //                     widget.status == 10 ||
// // // // //                     widget.status == 12) ...[
// // // // //                   if (widget.showEmailButton ?? true) ...[
// // // // //                     IconButton(
// // // // //                       onPressed: () {
// // // // //                         widget.onEmailTap != null
// // // // //                             ? widget.onEmailTap!(widget.index)
// // // // //                             : null;
// // // // //                       },
// // // // //                       icon: const Icon(Icons.email, color: Color(0xFF0C4C99)),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ],
// // // // //                 if (widget.showLinkOffButton ?? true) ...[
// // // // //                   IconButton(
// // // // //                     onPressed: () {
// // // // //                       widget.onLinkOffTap != null
// // // // //                           ? widget.onLinkOffTap!(widget.index)
// // // // //                           : null;
// // // // //                     },
// // // // //                     icon: const Icon(Icons.link_off, color: Colors.white),
// // // // //                   ),
// // // // //                 ],
// // // // //                 if (widget.showLaunchButton ?? true) ...[
// // // // //                   IconButton(
// // // // //                     onPressed: () {
// // // // //                       widget.onLaunchTap != null
// // // // //                           ? widget.onLaunchTap!(widget.index)
// // // // //                           : null;
// // // // //                     },
// // // // //                     icon: const Icon(Icons.rocket_launch, color: Colors.white),
// // // // //                   ),
// // // // //                 ],
// // // // //                 if (widget.showDeleteButton ?? true) ...[
// // // // //                   if (widget.onDeleteTap != null) ...[
// // // // //                     IconButton(
// // // // //                       onPressed: () {
// // // // //                         //do action on view
// // // // //                         widget.onDeleteTap != null
// // // // //                             ? widget.onDeleteTap!(widget.index)
// // // // //                             : null;
// // // // //                       },
// // // // //                       icon: const Icon(Icons.delete, color: Colors.white),
// // // // //                     ),
// // // // //                   ]
// // // // //                 ],
// // // // //                 if (widget.showApproveButton ?? true) ...[
// // // // //                   IconButton(
// // // // //                     onPressed: () {
// // // // //                       widget.onApproveTap != null
// // // // //                           ? widget.onApproveTap!(widget.index)
// // // // //                           : null;
// // // // //                     },
// // // // //                     icon: const Icon(Icons.approval, color: Colors.white),
// // // // //                   ),
// // // // //                 ],
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     ];
// // // // //
// // // // //     return widgets;
// // // // //   }
// // // // //
// // // // //   Widget getLabelWidgets(List<Label>? labels) {
// // // // //     List<Widget> widgets = [];
// // // // //
// // // // //     for (Label label in labels ?? []) {
// // // // //       if (label.value == 'null' || label.value.isEmpty) {
// // // // //         continue;
// // // // //       }
// // // // //       widgets.add(CommonWidgets.verticalSpacerWidget(5));
// // // // //       widgets.add(
// // // // //         IntrinsicWidth(
// // // // //           child: Padding(
// // // // //             padding: const EdgeInsets.only(right: 8.0),
// // // // //             child: Wrap(
// // // // //               // mainAxisSize: MainAxisSize.min,
// // // // //               children: [
// // // // //                 Utils().textHandling('${label.key} : ', label.value),
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //         ),
// // // // //       );
// // // // //     }
// // // // //     return Wrap(
// // // // //       children: widgets,
// // // // //     );
// // // // //   }
// // // // // }
// // // // //
// // // // // class Label {
// // // // //   final String key;
// // // // //   final String value;
// // // // //
// // // // //   const Label({
// // // // //     required this.key,
// // // // //     required this.value,
// // // // //   });
// // // // // }
// // // // import 'package:db_atom/index.dart';
// // // //
// // // // /// Theme tokens (same palette as the popup / "Select Locations" screen)
// // // // class _ListTheme {
// // // //   static const Color navy = Color(0xFF14086B);
// // // //   static const Color navyDark = Color(0xFF0B0450);
// // // //   static const Color navyMid = Color(0xFF1E0F8A);
// // // //   static const Color gold = Color(0xFFC49A6C);
// // // //   static const Color goldLight = Color(0xFFE6CFB0);
// // // //   static const Color pageBg = Color(0xFFF4F3FA);
// // // //   static const Color cardBorder = Color(0xFFDDDAF0);
// // // //   static const Color divider = Color(0xFFEDEBF7);
// // // //   static const Color chipBg = Color(0xFFF5EEE7);
// // // //   static const Color labelGrey = Color(0xFF7A76A6);
// // // //   static const Color actionBg = Color(0xFFF1EFFA);
// // // // }
// // // //
// // // // class BaseListTileItem extends StatefulWidget {
// // // //   final num? id;
// // // //   final Organisation? location;
// // // //   final bool? returnable;
// // // //   final Organisation? locationRegion;
// // // //   final String? inputDate;
// // // //   final int? status;
// // // //   final String? vendor;
// // // //   final String? region;
// // // //   final int? guardCount;
// // // //   final int? pvcExpired;
// // // //   final int? msgbExempted;
// // // //   final List<Label>? labels;
// // // //   final String? locationStr;
// // // //   final int? guardRank;
// // // //   final Function? onTap;
// // // //   final Function? onEditTap;
// // // //   final Function? onViewTap;
// // // //   final Function? onDeleteTap;
// // // //   final Function? onEmailTap;
// // // //   final Function? onLinkOffTap;
// // // //   final Function? onApproveTap;
// // // //   final int? incidentType;
// // // //   final bool isIncident;
// // // //   final Organisation? vendors;
// // // //   final int? workShift;
// // // //   final bool isWorkShift;
// // // //   final int? transportIncidentType;
// // // //   final Function? onLaunchTap;
// // // //
// // // //   // final Item userItem;
// // // //   final int? index;
// // // //
// // // //   final bool? showViewButton;
// // // //   final bool? showDeleteButton;
// // // //   final bool? showEmailButton;
// // // //   final bool? showLinkOffButton;
// // // //   final bool? showApproveButton;
// // // //   final bool isMasterGuard;
// // // //   final bool? isMasterGuardRank;
// // // //   final bool isEventProtectionStatus;
// // // //   final bool isOccurrenceStatus;
// // // //   final bool isSLAViolationStatus;
// // // //   final bool isContactDetailsStatus;
// // // //   final bool isSecuritySystemSLA;
// // // //   final bool isKeyLossStatus;
// // // //   final bool isKeyManagementStatus;
// // // //   final bool isKeyManagementIssuanceStatus;
// // // //   final bool isVipStatus;
// // // //   final bool isMaterialMovementStatus;
// // // //   final bool isKeyManagementHistoryStatus;
// // // //   final bool isShiftScheduleStatus;
// // // //   final bool isDutyPostNameMasterStatus;
// // // //   final bool isAttendanceStatus;
// // // //   final bool? showEditButton;
// // // //   final bool isPassManagementStatus;
// // // //   final bool isLawEnforcementStatus;
// // // //   final bool isArticleFoundStatus;
// // // //   final bool isTicketStatus;
// // // //   final bool isTransportStatus;
// // // //   final bool isCSREventProtectionStatus;
// // // //   final bool isPatrollingStatus;
// // // //   final bool isDutyPostMasterStatus;
// // // //   final bool? showLaunchButton;
// // // //   final bool isParkingStatus;
// // // //
// // // //   const BaseListTileItem({
// // // //     super.key,
// // // //     this.id,
// // // //     this.location,
// // // //     this.locationRegion,
// // // //     this.inputDate,
// // // //     this.status,
// // // //     this.onTap,
// // // //     this.onEditTap,
// // // //     this.showViewButton,
// // // //     this.onViewTap,
// // // //     this.onEmailTap,
// // // //     this.onLinkOffTap,
// // // //     this.onApproveTap,
// // // //     this.showApproveButton = false,
// // // //     this.index,
// // // //     this.region,
// // // //     this.vendor,
// // // //     this.guardCount,
// // // //     this.pvcExpired,
// // // //     this.msgbExempted,
// // // //     this.returnable,
// // // //     this.isIncident = false,
// // // //     this.locationStr,
// // // //     this.guardRank,
// // // //     this.labels,
// // // //     this.isMasterGuard = false,
// // // //     this.isMasterGuardRank = false,
// // // //     this.isEventProtectionStatus = true,
// // // //     this.isOccurrenceStatus = false,
// // // //     this.isSLAViolationStatus = false,
// // // //     this.incidentType,
// // // //     this.isContactDetailsStatus = false,
// // // //     this.isSecuritySystemSLA = false,
// // // //     this.isKeyLossStatus = false,
// // // //     this.isKeyManagementStatus = false,
// // // //     this.isKeyManagementIssuanceStatus = false,
// // // //     this.isVipStatus = false,
// // // //     this.isMaterialMovementStatus = false,
// // // //     this.onDeleteTap,
// // // //     this.isKeyManagementHistoryStatus = false,
// // // //     this.isDutyPostNameMasterStatus = false,
// // // //     this.isShiftScheduleStatus = false,
// // // //     this.isAttendanceStatus = false,
// // // //     this.vendors,
// // // //     this.showEditButton = false,
// // // //     this.showDeleteButton = true,
// // // //     this.showEmailButton = false,
// // // //     this.showLinkOffButton = false,
// // // //     this.isPassManagementStatus = false,
// // // //     this.isLawEnforcementStatus = false,
// // // //     this.isArticleFoundStatus = false,
// // // //     this.workShift,
// // // //     this.isWorkShift = false,
// // // //     this.isTicketStatus = false,
// // // //     this.isTransportStatus = false,
// // // //     this.isCSREventProtectionStatus = false,
// // // //     this.isPatrollingStatus = false,
// // // //     this.isDutyPostMasterStatus = false,
// // // //     this.transportIncidentType,
// // // //     this.showLaunchButton = false,
// // // //     this.isParkingStatus = false,
// // // //     this.onLaunchTap,
// // // //   });
// // // //
// // // //   @override
// // // //   State<BaseListTileItem> createState() => _BaseListTileItemState();
// // // // }
// // // //
// // // // class _BaseListTileItemState extends State<BaseListTileItem> {
// // // //   bool isHovered = true;
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final details = _buildDetails();
// // // //     final statuses = _buildStatusWidgets();
// // // //     final actions = _buildActions();
// // // //
// // // //     return Padding(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
// // // //       child: Material(
// // // //         color: Colors.transparent,
// // // //         child: InkWell(
// // // //           onTap: () {
// // // //             HapticFeedback.lightImpact();
// // // //             widget.onTap?.call(widget.index);
// // // //           },
// // // //           borderRadius: BorderRadius.circular(20),
// // // //           child: Ink(
// // // //             decoration: BoxDecoration(
// // // //               color: Colors.white,
// // // //               borderRadius: BorderRadius.circular(20),
// // // //               border: Border.all(color: _ListTheme.cardBorder, width: 1),
// // // //               boxShadow: [
// // // //                 BoxShadow(
// // // //                   color: _ListTheme.navy.withValues(alpha: 0.06),
// // // //                   blurRadius: 14,
// // // //                   offset: const Offset(0, 6),
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //             child: Padding(
// // // //               padding: const EdgeInsets.all(14),
// // // //               child: Column(
// // // //                 crossAxisAlignment: CrossAxisAlignment.stretch,
// // // //                 children: [
// // // //                   _buildHeaderRow(),
// // // //                   if (details.isNotEmpty) ...[
// // // //                     const SizedBox(height: 10),
// // // //                     _buildDetailsBlock(details),
// // // //                   ],
// // // //                   if (statuses.isNotEmpty) ...[
// // // //                     const SizedBox(height: 12),
// // // //                     _buildStatusBlock(statuses),
// // // //                   ],
// // // //                   if (actions.isNotEmpty) ...[
// // // //                     const SizedBox(height: 12),
// // // //                     const Divider(
// // // //                       height: 1,
// // // //                       thickness: 1,
// // // //                       color: _ListTheme.divider,
// // // //                     ),
// // // //                     const SizedBox(height: 10),
// // // //                     Align(
// // // //                       alignment: Alignment.centerRight,
// // // //                       child: Wrap(
// // // //                         spacing: 8,
// // // //                         runSpacing: 8,
// // // //                         alignment: WrapAlignment.end,
// // // //                         children: actions,
// // // //                       ),
// // // //                     ),
// // // //                   ],
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   // ---------------------------------------------------------------------------
// // // //   // HEADER: icon tile + ID chip
// // // //   // ---------------------------------------------------------------------------
// // // //   Widget _buildHeaderRow() {
// // // //     return Row(
// // // //       children: [
// // // //         Container(
// // // //           height: 48,
// // // //           width: 48,
// // // //           decoration: BoxDecoration(
// // // //             borderRadius: BorderRadius.circular(14),
// // // //             gradient: const LinearGradient(
// // // //               colors: [_ListTheme.navyMid, _ListTheme.navyDark],
// // // //               begin: Alignment.topLeft,
// // // //               end: Alignment.bottomRight,
// // // //             ),
// // // //             boxShadow: [
// // // //               BoxShadow(
// // // //                 color: _ListTheme.navy.withValues(alpha: 0.3),
// // // //                 blurRadius: 10,
// // // //                 offset: const Offset(0, 4),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //           child: const Icon(Icons.assignment_rounded,
// // // //               color: Colors.white, size: 24),
// // // //         ),
// // // //         const SizedBox(width: 14),
// // // //         Expanded(
// // // //           child: Column(
// // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // //             children: [
// // // //               Text(
// // // //                 'ID : ${widget.id ?? '-'}',
// // // //                 maxLines: 1,
// // // //                 overflow: TextOverflow.ellipsis,
// // // //                 style: const TextStyle(
// // // //                   color: _ListTheme.navy,
// // // //                   fontSize: 18,
// // // //                   fontWeight: FontWeight.w800,
// // // //                 ),
// // // //               ),
// // // //               if (widget.locationRegion != null) ...[
// // // //                 const SizedBox(height: 6),
// // // //                 Container(
// // // //                   padding:
// // // //                   const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
// // // //                   decoration: BoxDecoration(
// // // //                     color: _ListTheme.chipBg,
// // // //                     borderRadius: BorderRadius.circular(20),
// // // //                   ),
// // // //                   child: Text(
// // // //                     widget.locationRegion?.name ?? '',
// // // //                     maxLines: 1,
// // // //                     overflow: TextOverflow.ellipsis,
// // // //                     style: const TextStyle(
// // // //                       color: _ListTheme.gold,
// // // //                       fontSize: 12,
// // // //                       fontWeight: FontWeight.w700,
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //               ],
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ],
// // // //     );
// // // //   }
// // // //
// // // //   // ---------------------------------------------------------------------------
// // // //   // DETAILS (label / value rows)
// // // //   // ---------------------------------------------------------------------------
// // // //   Widget _buildDetailsBlock(List<MapEntry<String, String>> details) {
// // // //     final rows = <Widget>[];
// // // //     for (int i = 0; i < details.length; i++) {
// // // //       rows.add(_detailRow(details[i].key, details[i].value));
// // // //       if (i != details.length - 1) {
// // // //         rows.add(const Divider(
// // // //           height: 1,
// // // //           thickness: 1,
// // // //           color: _ListTheme.divider,
// // // //         ));
// // // //       }
// // // //     }
// // // //     return Container(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
// // // //       decoration: BoxDecoration(
// // // //         color: _ListTheme.pageBg,
// // // //         borderRadius: BorderRadius.circular(14),
// // // //       ),
// // // //       child: Column(children: rows),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _detailRow(String label, String value) {
// // // //     final cleanLabel = label.replaceAll(RegExp(r'\s*:\s*$'), '').trim();
// // // //     return Padding(
// // // //       padding: const EdgeInsets.symmetric(vertical: 9),
// // // //       child: Row(
// // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // //         children: [
// // // //           Expanded(
// // // //             flex: 5,
// // // //             child: Text(
// // // //               cleanLabel,
// // // //               softWrap: true,
// // // //               style: const TextStyle(
// // // //                 color: _ListTheme.labelGrey,
// // // //                 fontSize: 12.5,
// // // //                 fontWeight: FontWeight.w600,
// // // //               ),
// // // //             ),
// // // //           ),
// // // //           const SizedBox(width: 10),
// // // //           Expanded(
// // // //             flex: 6,
// // // //             child: Text(
// // // //               value.isEmpty ? '-' : value,
// // // //               softWrap: true,
// // // //               style: const TextStyle(
// // // //                 color: _ListTheme.navy,
// // // //                 fontSize: 14,
// // // //                 fontWeight: FontWeight.w800,
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   // ---------------------------------------------------------------------------
// // // //   // STATUS block (navy, so the existing white-text Utils() widgets stay readable)
// // // //   // ---------------------------------------------------------------------------
// // // //   Widget _buildStatusBlock(List<Widget> statuses) {
// // // //     return Container(
// // // //       padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
// // // //       decoration: BoxDecoration(
// // // //         borderRadius: BorderRadius.circular(16),
// // // //         gradient: const LinearGradient(
// // // //           colors: [_ListTheme.navyMid, _ListTheme.navyDark],
// // // //           begin: Alignment.topLeft,
// // // //           end: Alignment.bottomRight,
// // // //         ),
// // // //       ),
// // // //       child: Column(
// // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // //         children: statuses,
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _statusItem(Widget child, {bool expand = false}) {
// // // //     return Padding(
// // // //       padding: const EdgeInsets.only(bottom: 8),
// // // //       child: expand
// // // //           ? Row(children: [Expanded(child: child)])
// // // //           : Align(alignment: Alignment.centerLeft, child: child),
// // // //     );
// // // //   }
// // // //
// // // //   // ---------------------------------------------------------------------------
// // // //   // ACTION BUTTONS (round, lavender, navy icons)
// // // //   // ---------------------------------------------------------------------------
// // // //   Widget _actionButton({
// // // //     required IconData icon,
// // // //     required VoidCallback onPressed,
// // // //     Color? color,
// // // //     String? tooltip,
// // // //   }) {
// // // //     return Tooltip(
// // // //       message: tooltip ?? '',
// // // //       child: InkWell(
// // // //         onTap: onPressed,
// // // //         customBorder: const CircleBorder(),
// // // //         child: Container(
// // // //           height: 38,
// // // //           width: 38,
// // // //           decoration: BoxDecoration(
// // // //             shape: BoxShape.circle,
// // // //             color: _ListTheme.actionBg,
// // // //             border: Border.all(color: _ListTheme.cardBorder, width: 1),
// // // //           ),
// // // //           child: Icon(icon, size: 19, color: color ?? _ListTheme.navy),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   List<Widget> _buildActions() {
// // // //     final a = <Widget>[];
// // // //
// // // //     // Edit (always shown, icon changes with showEditButton)
// // // //     a.add(_actionButton(
// // // //       icon: (widget.showEditButton ?? true)
// // // //           ? Icons.edit_rounded
// // // //           : Icons.edit_off_outlined,
// // // //       tooltip: 'Edit',
// // // //       onPressed: () {
// // // //         widget.onEditTap != null ? widget.onEditTap!(widget.index) : null;
// // // //       },
// // // //     ));
// // // //
// // // //     if (widget.showViewButton ?? true) {
// // // //       a.add(_actionButton(
// // // //         icon: Icons.visibility_rounded,
// // // //         tooltip: 'View',
// // // //         onPressed: () {
// // // //           widget.onViewTap != null ? widget.onViewTap!(widget.index) : null;
// // // //         },
// // // //       ));
// // // //     }
// // // //
// // // //     if (widget.isSecuritySystemSLA == true && widget.status == 2 ||
// // // //         widget.status == 3 ||
// // // //         widget.status == 4 ||
// // // //         widget.status == 5 ||
// // // //         widget.status == 8 ||
// // // //         widget.status == 10 ||
// // // //         widget.status == 12) {
// // // //       if (widget.showEmailButton ?? true) {
// // // //         a.add(_actionButton(
// // // //           icon: Icons.email_rounded,
// // // //           tooltip: 'Email',
// // // //           color: const Color(0xFF0C4C99),
// // // //           onPressed: () {
// // // //             widget.onEmailTap != null ? widget.onEmailTap!(widget.index) : null;
// // // //           },
// // // //         ));
// // // //       }
// // // //     }
// // // //
// // // //     if (widget.showLinkOffButton ?? true) {
// // // //       a.add(_actionButton(
// // // //         icon: Icons.link_off_rounded,
// // // //         tooltip: 'Unlink',
// // // //         onPressed: () {
// // // //           widget.onLinkOffTap != null
// // // //               ? widget.onLinkOffTap!(widget.index)
// // // //               : null;
// // // //         },
// // // //       ));
// // // //     }
// // // //
// // // //     if (widget.showLaunchButton ?? true) {
// // // //       a.add(_actionButton(
// // // //         icon: Icons.rocket_launch_rounded,
// // // //         tooltip: 'Launch',
// // // //         color: _ListTheme.gold,
// // // //         onPressed: () {
// // // //           widget.onLaunchTap != null
// // // //               ? widget.onLaunchTap!(widget.index)
// // // //               : null;
// // // //         },
// // // //       ));
// // // //     }
// // // //
// // // //     if ((widget.showDeleteButton ?? true) && widget.onDeleteTap != null) {
// // // //       a.add(_actionButton(
// // // //         icon: Icons.delete_rounded,
// // // //         tooltip: 'Delete',
// // // //         color: const Color(0xFFD64545),
// // // //         onPressed: () {
// // // //           widget.onDeleteTap != null
// // // //               ? widget.onDeleteTap!(widget.index)
// // // //               : null;
// // // //         },
// // // //       ));
// // // //     }
// // // //
// // // //     if (widget.showApproveButton ?? true) {
// // // //       a.add(_actionButton(
// // // //         icon: Icons.approval_rounded,
// // // //         tooltip: 'Approve',
// // // //         onPressed: () {
// // // //           widget.onApproveTap != null
// // // //               ? widget.onApproveTap!(widget.index)
// // // //               : null;
// // // //         },
// // // //       ));
// // // //     }
// // // //
// // // //     return a;
// // // //   }
// // // //
// // // //   // ---------------------------------------------------------------------------
// // // //   // DATA: label / value rows
// // // //   // ---------------------------------------------------------------------------
// // // //   List<MapEntry<String, String>> _buildDetails() {
// // // //     final d = <MapEntry<String, String>>[];
// // // //
// // // //     void add(String label, Object? value) {
// // // //       if (value == null) return;
// // // //       d.add(MapEntry(label, value.toString()));
// // // //     }
// // // //
// // // //     if (widget.location != null) {
// // // //       add('Location : ', widget.location?.name ?? '');
// // // //     }
// // // //     if (widget.locationStr != null) add('Location : ', widget.locationStr);
// // // //     if (widget.vendors != null) add('Vendor : ', widget.vendors?.name ?? '');
// // // //     if (widget.guardCount != null) add('Guard Count : ', widget.guardCount);
// // // //     if (widget.pvcExpired != null) {
// // // //       add('Staff PVC Expired : ', widget.pvcExpired);
// // // //     }
// // // //     if (widget.vendor != null) add('Vendor : ', widget.vendor);
// // // //
// // // //     for (Label label in widget.labels ?? []) {
// // // //       if (label.value == 'null' || label.value.isEmpty) continue;
// // // //       d.add(MapEntry('${label.key} : ', label.value));
// // // //     }
// // // //     return d;
// // // //   }
// // // //
// // // //   // ---------------------------------------------------------------------------
// // // //   // DATA: status widgets (built by Utils())
// // // //   // ---------------------------------------------------------------------------
// // // //   List<Widget> _buildStatusWidgets() {
// // // //     final w = <Widget>[];
// // // //     final s = widget.status;
// // // //
// // // //     if (widget.guardRank != -1 && widget.isMasterGuardRank == true) {
// // // //       w.add(_statusItem(
// // // //           Utils().buildGuardRank(guardRank: widget.guardRank ?? 0)));
// // // //     }
// // // //     if (widget.workShift != -1 && widget.isWorkShift == true) {
// // // //       w.add(_statusItem(
// // // //           Utils().buildWorkShift(workShift: widget.workShift ?? 0)));
// // // //     }
// // // //     if (widget.incidentType != null) {
// // // //       w.add(_statusItem(Utils().incidentType(widget.incidentType ?? 0)));
// // // //     }
// // // //     if (widget.transportIncidentType != null) {
// // // //       w.add(_statusItem(
// // // //           Utils().transportIncidentType(widget.transportIncidentType ?? 0)));
// // // //     }
// // // //     if (s != null &&
// // // //         widget.isArticleFoundStatus == true &&
// // // //         !widget.isShiftScheduleStatus) {
// // // //       w.add(_statusItem(Utils().buildFoundStatusRow(s)));
// // // //     }
// // // //     if (s != null && widget.isEventProtectionStatus && !widget.isMasterGuard) {
// // // //       w.add(_statusItem(Utils().buildEventProtectionStatusRow(s)));
// // // //     }
// // // //     if (s != null &&
// // // //         widget.isCSREventProtectionStatus &&
// // // //         !widget.isMasterGuard) {
// // // //       w.add(_statusItem(Utils().buildCSRProtectionStatusRow(s)));
// // // //     }
// // // //     if (s != null && widget.isIncident == true) {
// // // //       w.add(_statusItem(Utils().buildIncidentStatus(s)));
// // // //     }
// // // //     if (s != null &&
// // // //         widget.isLawEnforcementStatus == true &&
// // // //         !widget.isShiftScheduleStatus) {
// // // //       w.add(_statusItem(Utils().buildLeoStatusRow(s)));
// // // //     }
// // // //     if (s != null &&
// // // //         widget.isMaterialMovementStatus == true &&
// // // //         !widget.isMasterGuard) {
// // // //       w.add(_statusItem(Utils().buildMaterialMovementStatusRow(s),
// // // //           expand: true));
// // // //     }
// // // //     if (s != 0 && widget.isMasterGuard) {
// // // //       w.add(_statusItem(Utils().buildMasterDataStatusRow(s ?? 0)));
// // // //     }
// // // //     if (s != null && widget.isKeyManagementIssuanceStatus) {
// // // //       w.add(_statusItem(Utils().keyManagementIssuanceStatus(s),
// // // //           expand: true));
// // // //     }
// // // //     if (s != null && widget.isPatrollingStatus) {
// // // //       w.add(_statusItem(Utils().patrollingStatus(s), expand: true));
// // // //     }
// // // //     if (s != null && widget.isParkingStatus) {
// // // //       w.add(_statusItem(Utils().parkingStatus(s), expand: true));
// // // //     }
// // // //     if (s != null && widget.isAttendanceStatus == true) {
// // // //       w.add(_statusItem(Utils().buildAttendanceStatusRow(s)));
// // // //     }
// // // //     if (s != null && widget.isKeyManagementStatus) {
// // // //       w.add(_statusItem(Utils().keyManagementStatus(s)));
// // // //     }
// // // //     if (s != null && widget.isKeyManagementHistoryStatus) {
// // // //       w.add(_statusItem(Utils().keyManagementMasterHistoryStatus(s)));
// // // //     }
// // // //     if (s != null && widget.isOccurrenceStatus == true) {
// // // //       w.add(_statusItem(Utils().buildOccurrenceStatus(s)));
// // // //     }
// // // //     if (s != null && widget.isKeyLossStatus == true) {
// // // //       w.add(_statusItem(Utils().keyLossDestructionStatus(s)));
// // // //     }
// // // //     if (s != null && widget.isSLAViolationStatus == true) {
// // // //       w.add(_statusItem(Utils().buildSLAViolationStatus(s)));
// // // //     }
// // // //     if (s != null &&
// // // //         widget.isContactDetailsStatus == true &&
// // // //         widget.isEventProtectionStatus == false) {
// // // //       w.add(_statusItem(Utils().contactDetailsStatus(s)));
// // // //     }
// // // //     if (s != null &&
// // // //         widget.isEventProtectionStatus == false &&
// // // //         widget.isSecuritySystemSLA == true) {
// // // //       w.add(_statusItem(Utils().buildSecuritySystemStatusRow(s)));
// // // //     }
// // // //     if (widget.isVipStatus == true) {
// // // //       w.add(_statusItem(Utils().vIPVisitorStatusRow(s ?? 0)));
// // // //     }
// // // //     if (s != null && widget.isShiftScheduleStatus == true) {
// // // //       w.add(_statusItem(Utils().shiftScheduleStatusRow(s)));
// // // //     }
// // // //     if (s != null && widget.isTransportStatus == true) {
// // // //       w.add(_statusItem(Utils().transportMedicalStatus(s)));
// // // //     }
// // // //     if (s != null && widget.isDutyPostNameMasterStatus == true) {
// // // //       w.add(_statusItem(Utils().dutyPostNameMasterStatus(s)));
// // // //     }
// // // //     if (s != null && widget.isDutyPostMasterStatus == true) {
// // // //       w.add(_statusItem(Utils().dutyPostMasterStatus(s)));
// // // //     }
// // // //     if (s != null &&
// // // //         widget.isPassManagementStatus == true &&
// // // //         !widget.isShiftScheduleStatus) {
// // // //       w.add(_statusItem(Utils().buildPassManagementStatusRow(s)));
// // // //     }
// // // //     if (s != null && widget.isTicketStatus) {
// // // //       w.add(_statusItem(Utils().buildTicketStatusRow(s)));
// // // //     }
// // // //
// // // //     return w;
// // // //   }
// // // // }
// // // //
// // // // class Label {
// // // //   final String key;
// // // //   final String value;
// // // //
// // // //   const Label({
// // // //     required this.key,
// // // //     required this.value,
// // // //   });
// // // // }
// // //
// // // import 'package:db_atom/index.dart';
// // //
// // // /// Theme tokens (same palette as the popup / "Select Locations" screen)
// // // class _ListTheme {
// // //   static const Color navy = Color(0xFF14086B);
// // //   static const Color navyDark = Color(0xFF0B0450);
// // //   static const Color navyMid = Color(0xFF1E0F8A);
// // //   static const Color gold = Color(0xFFC49A6C);
// // //   static const Color goldLight = Color(0xFFE6CFB0);
// // //   static const Color pageBg = Color(0xFFF4F3FA);
// // //   static const Color cardBorder = Color(0xFFDDDAF0);
// // //   static const Color divider = Color(0xFFEDEBF7);
// // //   static const Color chipBg = Color(0xFFF5EEE7);
// // //   static const Color labelGrey = Color(0xFF7A76A6);
// // //   static const Color actionBg = Color(0xFFF1EFFA);
// // //   static const Color iconTint = Color(0xFFEEEBFA);
// // // }
// // //
// // // class BaseListTileItem extends StatefulWidget {
// // //   final num? id;
// // //   final Organisation? location;
// // //   final bool? returnable;
// // //   final Organisation? locationRegion;
// // //   final String? inputDate;
// // //   final int? status;
// // //   final String? vendor;
// // //   final String? region;
// // //   final int? guardCount;
// // //   final int? pvcExpired;
// // //   final int? msgbExempted;
// // //   final List<Label>? labels;
// // //   final String? locationStr;
// // //   final int? guardRank;
// // //   final Function? onTap;
// // //   final Function? onEditTap;
// // //   final Function? onViewTap;
// // //   final Function? onDeleteTap;
// // //   final Function? onEmailTap;
// // //   final Function? onLinkOffTap;
// // //   final Function? onApproveTap;
// // //   final int? incidentType;
// // //   final bool isIncident;
// // //   final Organisation? vendors;
// // //   final int? workShift;
// // //   final bool isWorkShift;
// // //   final int? transportIncidentType;
// // //   final Function? onLaunchTap;
// // //
// // //   // final Item userItem;
// // //   final int? index;
// // //
// // //   final bool? showViewButton;
// // //   final bool? showDeleteButton;
// // //   final bool? showEmailButton;
// // //   final bool? showLinkOffButton;
// // //   final bool? showApproveButton;
// // //   final bool isMasterGuard;
// // //   final bool? isMasterGuardRank;
// // //   final bool isEventProtectionStatus;
// // //   final bool isOccurrenceStatus;
// // //   final bool isSLAViolationStatus;
// // //   final bool isContactDetailsStatus;
// // //   final bool isSecuritySystemSLA;
// // //   final bool isKeyLossStatus;
// // //   final bool isKeyManagementStatus;
// // //   final bool isKeyManagementIssuanceStatus;
// // //   final bool isVipStatus;
// // //   final bool isMaterialMovementStatus;
// // //   final bool isKeyManagementHistoryStatus;
// // //   final bool isShiftScheduleStatus;
// // //   final bool isDutyPostNameMasterStatus;
// // //   final bool isAttendanceStatus;
// // //   final bool? showEditButton;
// // //   final bool isPassManagementStatus;
// // //   final bool isLawEnforcementStatus;
// // //   final bool isArticleFoundStatus;
// // //   final bool isTicketStatus;
// // //   final bool isTransportStatus;
// // //   final bool isCSREventProtectionStatus;
// // //   final bool isPatrollingStatus;
// // //   final bool isDutyPostMasterStatus;
// // //   final bool? showLaunchButton;
// // //   final bool isParkingStatus;
// // //
// // //   const BaseListTileItem({
// // //     super.key,
// // //     this.id,
// // //     this.location,
// // //     this.locationRegion,
// // //     this.inputDate,
// // //     this.status,
// // //     this.onTap,
// // //     this.onEditTap,
// // //     this.showViewButton,
// // //     this.onViewTap,
// // //     this.onEmailTap,
// // //     this.onLinkOffTap,
// // //     this.onApproveTap,
// // //     this.showApproveButton = false,
// // //     this.index,
// // //     this.region,
// // //     this.vendor,
// // //     this.guardCount,
// // //     this.pvcExpired,
// // //     this.msgbExempted,
// // //     this.returnable,
// // //     this.isIncident = false,
// // //     this.locationStr,
// // //     this.guardRank,
// // //     this.labels,
// // //     this.isMasterGuard = false,
// // //     this.isMasterGuardRank = false,
// // //     this.isEventProtectionStatus = true,
// // //     this.isOccurrenceStatus = false,
// // //     this.isSLAViolationStatus = false,
// // //     this.incidentType,
// // //     this.isContactDetailsStatus = false,
// // //     this.isSecuritySystemSLA = false,
// // //     this.isKeyLossStatus = false,
// // //     this.isKeyManagementStatus = false,
// // //     this.isKeyManagementIssuanceStatus = false,
// // //     this.isVipStatus = false,
// // //     this.isMaterialMovementStatus = false,
// // //     this.onDeleteTap,
// // //     this.isKeyManagementHistoryStatus = false,
// // //     this.isDutyPostNameMasterStatus = false,
// // //     this.isShiftScheduleStatus = false,
// // //     this.isAttendanceStatus = false,
// // //     this.vendors,
// // //     this.showEditButton = false,
// // //     this.showDeleteButton = true,
// // //     this.showEmailButton = false,
// // //     this.showLinkOffButton = false,
// // //     this.isPassManagementStatus = false,
// // //     this.isLawEnforcementStatus = false,
// // //     this.isArticleFoundStatus = false,
// // //     this.workShift,
// // //     this.isWorkShift = false,
// // //     this.isTicketStatus = false,
// // //     this.isTransportStatus = false,
// // //     this.isCSREventProtectionStatus = false,
// // //     this.isPatrollingStatus = false,
// // //     this.isDutyPostMasterStatus = false,
// // //     this.transportIncidentType,
// // //     this.showLaunchButton = false,
// // //     this.isParkingStatus = false,
// // //     this.onLaunchTap,
// // //   });
// // //
// // //   @override
// // //   State<BaseListTileItem> createState() => _BaseListTileItemState();
// // // }
// // //
// // // class _BaseListTileItemState extends State<BaseListTileItem> {
// // //   bool isHovered = true;
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final details = _buildDetails();
// // //     final statuses = _buildStatusWidgets();
// // //     final actions = _buildActions();
// // //
// // //     // Soft fade + slide-up when the card first appears
// // //     return TweenAnimationBuilder<double>(
// // //       tween: Tween(begin: 0, end: 1),
// // //       duration: const Duration(milliseconds: 380),
// // //       curve: Curves.easeOutCubic,
// // //       builder: (context, t, child) => Opacity(
// // //         opacity: t,
// // //         child: Transform.translate(offset: Offset(0, 14 * (1 - t)), child: child),
// // //       ),
// // //       child: Padding(
// // //         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
// // //         child: Container(
// // //           decoration: BoxDecoration(
// // //             color: Colors.white,
// // //             borderRadius: BorderRadius.circular(24),
// // //             border: Border.all(color: _ListTheme.cardBorder, width: 1),
// // //             boxShadow: [
// // //               BoxShadow(
// // //                 color: _ListTheme.navy.withValues(alpha: 0.10),
// // //                 blurRadius: 24,
// // //                 offset: const Offset(0, 10),
// // //               ),
// // //               BoxShadow(
// // //                 color: _ListTheme.gold.withValues(alpha: 0.08),
// // //                 blurRadius: 10,
// // //                 offset: const Offset(0, 2),
// // //               ),
// // //             ],
// // //           ),
// // //           child: ClipRRect(
// // //             borderRadius: BorderRadius.circular(23),
// // //             child: Material(
// // //               color: Colors.transparent,
// // //               child: InkWell(
// // //                 onTap: () {
// // //                   HapticFeedback.lightImpact();
// // //                   widget.onTap?.call(widget.index);
// // //                 },
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.stretch,
// // //                   children: [
// // //                     _buildHeader(),
// // //                     if (details.isNotEmpty) _buildDetailsBlock(details),
// // //                     if (actions.isNotEmpty) _buildActionsRow(actions),
// // //                     if (statuses.isNotEmpty)
// // //                       _buildStatusFooter(statuses)
// // //                     else
// // //                       const SizedBox(height: 14),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   // ---------------------------------------------------------------------------
// // //   // HEADER: gradient wash, decorative rings, icon tile with gold glow, ID
// // //   // ---------------------------------------------------------------------------
// // //   // ---------------------------------------------------------------------------
// // //   // HEADER: clean gradient wash, icon tile, ID, date pill + chevron button
// // //   // ---------------------------------------------------------------------------
// // //   Widget _buildHeader() {
// // //     final int? ts = int.tryParse(widget.inputDate ?? '');
// // //     final String? dateText = ts == null
// // //         ? null
// // //         : Utils.timestampToDateConversion(ts, Constants.dateFormat);
// // //
// // //     return Container(
// // //       padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
// // //       decoration: const BoxDecoration(
// // //         gradient: LinearGradient(
// // //           colors: [Colors.white, _ListTheme.pageBg],
// // //           begin: Alignment.topCenter,
// // //           end: Alignment.bottomCenter,
// // //         ),
// // //       ),
// // //       child: Row(
// // //         children: [
// // //           // Navy tile with a gold outline + glow
// // //           Container(
// // //             height: 54,
// // //             width: 54,
// // //             decoration: BoxDecoration(
// // //               borderRadius: BorderRadius.circular(16),
// // //               gradient: const LinearGradient(
// // //                 colors: [_ListTheme.navyMid, _ListTheme.navyDark],
// // //                 begin: Alignment.topLeft,
// // //                 end: Alignment.bottomRight,
// // //               ),
// // //               border: Border.all(
// // //                 color: _ListTheme.gold.withValues(alpha: 0.7),
// // //                 width: 1.2,
// // //               ),
// // //               boxShadow: [
// // //                 BoxShadow(
// // //                   color: _ListTheme.navy.withValues(alpha: 0.35),
// // //                   blurRadius: 14,
// // //                   offset: const Offset(0, 6),
// // //                 ),
// // //               ],
// // //             ),
// // //             child: const Icon(Icons.assignment_rounded,
// // //                 color: Colors.white, size: 26),
// // //           ),
// // //           const SizedBox(width: 14),
// // //           Expanded(
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 const Text(
// // //                   'ID',
// // //                   style: TextStyle(
// // //                     color: _ListTheme.gold,
// // //                     fontSize: 11,
// // //                     fontWeight: FontWeight.w800,
// // //                     letterSpacing: 2.2,
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 2),
// // //                 Text(
// // //                   '${widget.id ?? '-'}',
// // //                   maxLines: 1,
// // //                   overflow: TextOverflow.ellipsis,
// // //                   style: const TextStyle(
// // //                     color: _ListTheme.navy,
// // //                     fontSize: 24,
// // //                     fontWeight: FontWeight.w900,
// // //                     height: 1.1,
// // //                   ),
// // //                 ),
// // //                 if (widget.locationRegion != null) ...[
// // //                   const SizedBox(height: 6),
// // //                   Container(
// // //                     padding: const EdgeInsets.symmetric(
// // //                         horizontal: 10, vertical: 3),
// // //                     decoration: BoxDecoration(
// // //                       color: _ListTheme.chipBg,
// // //                       borderRadius: BorderRadius.circular(20),
// // //                     ),
// // //                     child: Row(
// // //                       mainAxisSize: MainAxisSize.min,
// // //                       children: [
// // //                         const Icon(Icons.public_rounded,
// // //                             size: 13, color: _ListTheme.gold),
// // //                         const SizedBox(width: 5),
// // //                         Flexible(
// // //                           child: Text(
// // //                             widget.locationRegion?.name ?? '',
// // //                             maxLines: 1,
// // //                             overflow: TextOverflow.ellipsis,
// // //                             style: const TextStyle(
// // //                               color: _ListTheme.gold,
// // //                               fontSize: 12,
// // //                               fontWeight: FontWeight.w700,
// // //                             ),
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ],
// // //             ),
// // //           ),
// // //           const SizedBox(width: 8),
// // //           // Right side: optional date pill + lavender chevron button
// // //           Column(
// // //             crossAxisAlignment: CrossAxisAlignment.end,
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               if (dateText != null && dateText.isNotEmpty) ...[
// // //                 Container(
// // //                   padding:
// // //                   const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
// // //                   decoration: BoxDecoration(
// // //                     color: Colors.white,
// // //                     borderRadius: BorderRadius.circular(20),
// // //                     border: Border.all(color: _ListTheme.cardBorder, width: 1),
// // //                   ),
// // //                   child: Row(
// // //                     mainAxisSize: MainAxisSize.min,
// // //                     children: [
// // //                       const Icon(Icons.calendar_today_rounded,
// // //                           size: 12, color: _ListTheme.labelGrey),
// // //                       const SizedBox(width: 5),
// // //                       Text(
// // //                         dateText,
// // //                         style: const TextStyle(
// // //                           color: _ListTheme.labelGrey,
// // //                           fontSize: 11.5,
// // //                           fontWeight: FontWeight.w700,
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 8),
// // //               ],
// // //               Container(
// // //                 height: 34,
// // //                 width: 34,
// // //                 decoration: BoxDecoration(
// // //                   shape: BoxShape.circle,
// // //                   color: _ListTheme.actionBg,
// // //                   border: Border.all(color: _ListTheme.cardBorder, width: 1),
// // //                 ),
// // //                 child: const Icon(Icons.chevron_right_rounded,
// // //                     size: 22, color: _ListTheme.navyMid),
// // //               ),
// // //             ],
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //   // ---------------------------------------------------------------------------
// // //   // DETAILS: icon bubble + small label above bold value
// // //   // ---------------------------------------------------------------------------
// // //   Widget _buildDetailsBlock(List<MapEntry<String, String>> details) {
// // //     final rows = <Widget>[];
// // //     for (int i = 0; i < details.length; i++) {
// // //       rows.add(_detailRow(details[i].key, details[i].value));
// // //       if (i != details.length - 1) {
// // //         rows.add(const Padding(
// // //           padding: EdgeInsets.only(left: 48),
// // //           child: Divider(height: 1, thickness: 1, color: _ListTheme.divider),
// // //         ));
// // //       }
// // //     }
// // //     return Padding(
// // //       padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
// // //       child: Column(children: rows),
// // //     );
// // //   }
// // //
// // //   IconData _iconForLabel(String label) {
// // //     final l = label.toLowerCase();
// // //     if (l.contains('date') || l.contains('time') || l.contains('valid')) {
// // //       return Icons.calendar_month_rounded;
// // //     }
// // //     if (l.contains('location') || l.contains('region') || l.contains('area')) {
// // //       return Icons.location_on_rounded;
// // //     }
// // //     if (l.contains('created') ||
// // //         l.contains('by') ||
// // //         l.contains('name') ||
// // //         l.contains('manager') ||
// // //         l.contains('guard')) {
// // //       return Icons.person_rounded;
// // //     }
// // //     if (l.contains('vendor') || l.contains('company') || l.contains('dept')) {
// // //       return Icons.business_rounded;
// // //     }
// // //     if (l.contains('pvc') || l.contains('count') || l.contains('no')) {
// // //       return Icons.tag_rounded;
// // //     }
// // //     return Icons.circle_outlined;
// // //   }
// // //
// // //   Widget _detailRow(String label, String value) {
// // //     final cleanLabel = label.replaceAll(RegExp(r'\s*:\s*$'), '').trim();
// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(vertical: 10),
// // //       child: Row(
// // //         crossAxisAlignment: CrossAxisAlignment.center,
// // //         children: [
// // //           Container(
// // //             height: 34,
// // //             width: 34,
// // //             decoration: BoxDecoration(
// // //               color: _ListTheme.iconTint,
// // //               borderRadius: BorderRadius.circular(11),
// // //             ),
// // //             child: Icon(_iconForLabel(cleanLabel),
// // //                 size: 18, color: _ListTheme.navyMid),
// // //           ),
// // //           const SizedBox(width: 14),
// // //           Expanded(
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Text(
// // //                   cleanLabel,
// // //                   softWrap: true,
// // //                   style: const TextStyle(
// // //                     color: _ListTheme.labelGrey,
// // //                     fontSize: 12,
// // //                     fontWeight: FontWeight.w600,
// // //                     letterSpacing: 0.2,
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 2),
// // //                 Text(
// // //                   value.isEmpty ? '-' : value,
// // //                   softWrap: true,
// // //                   style: const TextStyle(
// // //                     color: _ListTheme.navy,
// // //                     fontSize: 15,
// // //                     fontWeight: FontWeight.w800,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   // ---------------------------------------------------------------------------
// // //   // ACTIONS: pill buttons with icon + label (View is the filled primary)
// // //   // ---------------------------------------------------------------------------
// // //   Widget _actionPill({
// // //     required IconData icon,
// // //     required String label,
// // //     required VoidCallback onPressed,
// // //     Color? color,
// // //     bool primary = false,
// // //   }) {
// // //     final fg = primary ? Colors.white : (color ?? _ListTheme.navy);
// // //     return Material(
// // //       color: Colors.transparent,
// // //       child: InkWell(
// // //         onTap: onPressed,
// // //         borderRadius: BorderRadius.circular(30),
// // //         child: Ink(
// // //           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
// // //           decoration: BoxDecoration(
// // //             borderRadius: BorderRadius.circular(30),
// // //             gradient: primary
// // //                 ? const LinearGradient(
// // //                 colors: [_ListTheme.navyMid, _ListTheme.navyDark])
// // //                 : null,
// // //             color: primary ? null : _ListTheme.actionBg,
// // //             border: primary
// // //                 ? null
// // //                 : Border.all(color: _ListTheme.cardBorder, width: 1),
// // //             boxShadow: primary
// // //                 ? [
// // //               BoxShadow(
// // //                 color: _ListTheme.navy.withValues(alpha: 0.3),
// // //                 blurRadius: 10,
// // //                 offset: const Offset(0, 4),
// // //               ),
// // //             ]
// // //                 : null,
// // //           ),
// // //           child: Row(
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               Icon(icon, size: 17, color: fg),
// // //               const SizedBox(width: 6),
// // //               Text(
// // //                 label,
// // //                 style: TextStyle(
// // //                   color: fg,
// // //                   fontSize: 13,
// // //                   fontWeight: FontWeight.w700,
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildActionsRow(List<Widget> actions) {
// // //     return Padding(
// // //       padding: const EdgeInsets.fromLTRB(16, 6, 16, 14),
// // //       child: Wrap(
// // //         spacing: 8,
// // //         runSpacing: 8,
// // //         alignment: WrapAlignment.end,
// // //         children: actions,
// // //       ),
// // //     );
// // //   }
// // //
// // //   List<Widget> _buildActions() {
// // //     final a = <Widget>[];
// // //
// // //     // Edit (always shown, icon changes with showEditButton)
// // //     a.add(_actionPill(
// // //       icon: (widget.showEditButton ?? true)
// // //           ? Icons.edit_rounded
// // //           : Icons.edit_off_outlined,
// // //       label: 'Edit',
// // //       onPressed: () {
// // //         widget.onEditTap != null ? widget.onEditTap!(widget.index) : null;
// // //       },
// // //     ));
// // //
// // //     if (widget.showViewButton ?? true) {
// // //       a.add(_actionPill(
// // //         icon: Icons.visibility_rounded,
// // //         label: 'View',
// // //         primary: true,
// // //         onPressed: () {
// // //           widget.onViewTap != null ? widget.onViewTap!(widget.index) : null;
// // //         },
// // //       ));
// // //     }
// // //
// // //     if (widget.isSecuritySystemSLA == true && widget.status == 2 ||
// // //         widget.status == 3 ||
// // //         widget.status == 4 ||
// // //         widget.status == 5 ||
// // //         widget.status == 8 ||
// // //         widget.status == 10 ||
// // //         widget.status == 12) {
// // //       if (widget.showEmailButton ?? true) {
// // //         a.add(_actionPill(
// // //           icon: Icons.email_rounded,
// // //           label: 'Email',
// // //           color: const Color(0xFF0C4C99),
// // //           onPressed: () {
// // //             widget.onEmailTap != null ? widget.onEmailTap!(widget.index) : null;
// // //           },
// // //         ));
// // //       }
// // //     }
// // //
// // //     if (widget.showLinkOffButton ?? true) {
// // //       a.add(_actionPill(
// // //         icon: Icons.link_off_rounded,
// // //         label: 'Unlink',
// // //         onPressed: () {
// // //           widget.onLinkOffTap != null
// // //               ? widget.onLinkOffTap!(widget.index)
// // //               : null;
// // //         },
// // //       ));
// // //     }
// // //
// // //     if (widget.showLaunchButton ?? true) {
// // //       a.add(_actionPill(
// // //         icon: Icons.rocket_launch_rounded,
// // //         label: 'Launch',
// // //         color: _ListTheme.gold,
// // //         onPressed: () {
// // //           widget.onLaunchTap != null
// // //               ? widget.onLaunchTap!(widget.index)
// // //               : null;
// // //         },
// // //       ));
// // //     }
// // //
// // //     if ((widget.showDeleteButton ?? true) && widget.onDeleteTap != null) {
// // //       a.add(_actionPill(
// // //         icon: Icons.delete_rounded,
// // //         label: 'Delete',
// // //         color: const Color(0xFFD64545),
// // //         onPressed: () {
// // //           widget.onDeleteTap != null
// // //               ? widget.onDeleteTap!(widget.index)
// // //               : null;
// // //         },
// // //       ));
// // //     }
// // //
// // //     if (widget.showApproveButton ?? true) {
// // //       a.add(_actionPill(
// // //         icon: Icons.approval_rounded,
// // //         label: 'Approve',
// // //         onPressed: () {
// // //           widget.onApproveTap != null
// // //               ? widget.onApproveTap!(widget.index)
// // //               : null;
// // //         },
// // //       ));
// // //     }
// // //
// // //     return a;
// // //   }
// // //
// // //   // ---------------------------------------------------------------------------
// // //   // STATUS FOOTER: full-width navy band with a gold edge, flush to card bottom
// // //   // ---------------------------------------------------------------------------
// // //   Widget _buildStatusFooter(List<Widget> statuses) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.stretch,
// // //       children: [
// // //         Container(
// // //           height: 3,
// // //           decoration: const BoxDecoration(
// // //             gradient: LinearGradient(
// // //               colors: [
// // //                 _ListTheme.gold,
// // //                 _ListTheme.goldLight,
// // //                 _ListTheme.gold,
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //         Container(
// // //           padding: const EdgeInsets.fromLTRB(18, 14, 18, 6),
// // //           decoration: const BoxDecoration(
// // //             gradient: LinearGradient(
// // //               colors: [_ListTheme.navyMid, _ListTheme.navyDark],
// // //               begin: Alignment.topLeft,
// // //               end: Alignment.bottomRight,
// // //             ),
// // //           ),
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: statuses,
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   Widget _statusItem(Widget child, {bool expand = false}) {
// // //     return Padding(
// // //       padding: const EdgeInsets.only(bottom: 8),
// // //       child: expand
// // //           ? Row(children: [Expanded(child: child)])
// // //           : Align(alignment: Alignment.centerLeft, child: child),
// // //     );
// // //   }
// // //
// // //   // ---------------------------------------------------------------------------
// // //   // DATA: label / value rows
// // //   // ---------------------------------------------------------------------------
// // //   List<MapEntry<String, String>> _buildDetails() {
// // //     final d = <MapEntry<String, String>>[];
// // //
// // //     void add(String label, Object? value) {
// // //       if (value == null) return;
// // //       d.add(MapEntry(label, value.toString()));
// // //     }
// // //
// // //     if (widget.location != null) {
// // //       add('Location : ', widget.location?.name ?? '');
// // //     }
// // //     if (widget.locationStr != null) add('Location : ', widget.locationStr);
// // //     if (widget.vendors != null) add('Vendor : ', widget.vendors?.name ?? '');
// // //     if (widget.guardCount != null) add('Guard Count : ', widget.guardCount);
// // //     if (widget.pvcExpired != null) {
// // //       add('Staff PVC Expired : ', widget.pvcExpired);
// // //     }
// // //     if (widget.vendor != null) add('Vendor : ', widget.vendor);
// // //
// // //     for (Label label in widget.labels ?? []) {
// // //       if (label.value == 'null' || label.value.isEmpty) continue;
// // //       d.add(MapEntry('${label.key} : ', label.value));
// // //     }
// // //     return d;
// // //   }
// // //
// // //   // ---------------------------------------------------------------------------
// // //   // DATA: status widgets (built by Utils())
// // //   // ---------------------------------------------------------------------------
// // //   List<Widget> _buildStatusWidgets() {
// // //     final w = <Widget>[];
// // //     final s = widget.status;
// // //
// // //     if (widget.guardRank != -1 && widget.isMasterGuardRank == true) {
// // //       w.add(_statusItem(
// // //           Utils().buildGuardRank(guardRank: widget.guardRank ?? 0)));
// // //     }
// // //     if (widget.workShift != -1 && widget.isWorkShift == true) {
// // //       w.add(_statusItem(
// // //           Utils().buildWorkShift(workShift: widget.workShift ?? 0)));
// // //     }
// // //     if (widget.incidentType != null) {
// // //       w.add(_statusItem(Utils().incidentType(widget.incidentType ?? 0)));
// // //     }
// // //     if (widget.transportIncidentType != null) {
// // //       w.add(_statusItem(
// // //           Utils().transportIncidentType(widget.transportIncidentType ?? 0)));
// // //     }
// // //     if (s != null &&
// // //         widget.isArticleFoundStatus == true &&
// // //         !widget.isShiftScheduleStatus) {
// // //       w.add(_statusItem(Utils().buildFoundStatusRow(s)));
// // //     }
// // //     if (s != null && widget.isEventProtectionStatus && !widget.isMasterGuard) {
// // //       w.add(_statusItem(Utils().buildEventProtectionStatusRow(s)));
// // //     }
// // //     if (s != null &&
// // //         widget.isCSREventProtectionStatus &&
// // //         !widget.isMasterGuard) {
// // //       w.add(_statusItem(Utils().buildCSRProtectionStatusRow(s)));
// // //     }
// // //     if (s != null && widget.isIncident == true) {
// // //       w.add(_statusItem(Utils().buildIncidentStatus(s)));
// // //     }
// // //     if (s != null &&
// // //         widget.isLawEnforcementStatus == true &&
// // //         !widget.isShiftScheduleStatus) {
// // //       w.add(_statusItem(Utils().buildLeoStatusRow(s)));
// // //     }
// // //     if (s != null &&
// // //         widget.isMaterialMovementStatus == true &&
// // //         !widget.isMasterGuard) {
// // //       w.add(_statusItem(Utils().buildMaterialMovementStatusRow(s),
// // //           expand: true));
// // //     }
// // //     if (s != 0 && widget.isMasterGuard) {
// // //       w.add(_statusItem(Utils().buildMasterDataStatusRow(s ?? 0)));
// // //     }
// // //     if (s != null && widget.isKeyManagementIssuanceStatus) {
// // //       w.add(_statusItem(Utils().keyManagementIssuanceStatus(s),
// // //           expand: true));
// // //     }
// // //     if (s != null && widget.isPatrollingStatus) {
// // //       w.add(_statusItem(Utils().patrollingStatus(s), expand: true));
// // //     }
// // //     if (s != null && widget.isParkingStatus) {
// // //       w.add(_statusItem(Utils().parkingStatus(s), expand: true));
// // //     }
// // //     if (s != null && widget.isAttendanceStatus == true) {
// // //       w.add(_statusItem(Utils().buildAttendanceStatusRow(s)));
// // //     }
// // //     if (s != null && widget.isKeyManagementStatus) {
// // //       w.add(_statusItem(Utils().keyManagementStatus(s)));
// // //     }
// // //     if (s != null && widget.isKeyManagementHistoryStatus) {
// // //       w.add(_statusItem(Utils().keyManagementMasterHistoryStatus(s)));
// // //     }
// // //     if (s != null && widget.isOccurrenceStatus == true) {
// // //       w.add(_statusItem(Utils().buildOccurrenceStatus(s)));
// // //     }
// // //     if (s != null && widget.isKeyLossStatus == true) {
// // //       w.add(_statusItem(Utils().keyLossDestructionStatus(s)));
// // //     }
// // //     if (s != null && widget.isSLAViolationStatus == true) {
// // //       w.add(_statusItem(Utils().buildSLAViolationStatus(s)));
// // //     }
// // //     if (s != null &&
// // //         widget.isContactDetailsStatus == true &&
// // //         widget.isEventProtectionStatus == false) {
// // //       w.add(_statusItem(Utils().contactDetailsStatus(s)));
// // //     }
// // //     if (s != null &&
// // //         widget.isEventProtectionStatus == false &&
// // //         widget.isSecuritySystemSLA == true) {
// // //       w.add(_statusItem(Utils().buildSecuritySystemStatusRow(s)));
// // //     }
// // //     if (widget.isVipStatus == true) {
// // //       w.add(_statusItem(Utils().vIPVisitorStatusRow(s ?? 0)));
// // //     }
// // //     if (s != null && widget.isShiftScheduleStatus == true) {
// // //       w.add(_statusItem(Utils().shiftScheduleStatusRow(s)));
// // //     }
// // //     if (s != null && widget.isTransportStatus == true) {
// // //       w.add(_statusItem(Utils().transportMedicalStatus(s)));
// // //     }
// // //     if (s != null && widget.isDutyPostNameMasterStatus == true) {
// // //       w.add(_statusItem(Utils().dutyPostNameMasterStatus(s)));
// // //     }
// // //     if (s != null && widget.isDutyPostMasterStatus == true) {
// // //       w.add(_statusItem(Utils().dutyPostMasterStatus(s)));
// // //     }
// // //     if (s != null &&
// // //         widget.isPassManagementStatus == true &&
// // //         !widget.isShiftScheduleStatus) {
// // //       w.add(_statusItem(Utils().buildPassManagementStatusRow(s)));
// // //     }
// // //     if (s != null && widget.isTicketStatus) {
// // //       w.add(_statusItem(Utils().buildTicketStatusRow(s)));
// // //     }
// // //
// // //     return w;
// // //   }
// // // }
// // //
// // // class Label {
// // //   final String key;
// // //   final String value;
// // //
// // //   const Label({
// // //     required this.key,
// // //     required this.value,
// // //   });
// // // }
// //
// // // import 'package:db_atom/index.dart';
// // //
// // // /// Card designs. Pick one per screen with `variant:`.
// // // enum BaseTileVariant {
// // //   classic, // header + detail rows + status footer
// // //   strip, // accent strip, 2-column detail chips
// // //   expandable, // collapsed summary, tap chevron to open
// // //   dark, // navy card with gold accents
// // // }
// // //
// // // class _ListTheme {
// // //   static const Color navy = Color(0xFF14086B);
// // //   static const Color navyDark = Color(0xFF0B0450);
// // //   static const Color navyMid = Color(0xFF1E0F8A);
// // //   static const Color gold = Color(0xFFB8895A);
// // //   static const Color goldLight = Color(0xFFE6CFB0);
// // //   static const Color goldBorder = Color(0xFFC9A98A);
// // //   static const Color pageBg = Color(0xFFFBF7F0);
// // //   static const Color cardBorder = Color(0xFFE8DFD0);
// // //   static const Color divider = Color(0xFFF1EBE0);
// // //   static const Color chipBg = Color(0xFFF5EEE7);
// // //   static const Color labelGrey = Color(0xFF8A8499);
// // //   static const Color actionBg = Color(0xFFFBF3E6);
// // //   static const Color iconTint = Color(0xFFEEEBFA);
// // //
// // //   // Accent colours for detail icons
// // //   static const Color amber = Color(0xFFD98E2B);
// // //   static const Color amberTint = Color(0xFFFDF0DA);
// // //   static const Color teal = Color(0xFF1F9488);
// // //   static const Color tealTint = Color(0xFFE0F3F0);
// // //   static const Color violet = Color(0xFF7D5BB5);
// // //   static const Color violetTint = Color(0xFFEFE8F8);
// // //   static const Color blue = Color(0xFF2F6DB5);
// // //   static const Color blueTint = Color(0xFFE3EEF9);
// // // }
// // //
// // // class BaseListTileItem extends StatefulWidget {
// // //   final num? id;
// // //   final Organisation? location;
// // //   final bool? returnable;
// // //   final Organisation? locationRegion;
// // //   final String? inputDate;
// // //   final int? status;
// // //   final String? vendor;
// // //   final String? region;
// // //   final int? guardCount;
// // //   final int? pvcExpired;
// // //   final int? msgbExempted;
// // //   final List<Label>? labels;
// // //   final String? locationStr;
// // //   final int? guardRank;
// // //   final Function? onTap;
// // //   final Function? onEditTap;
// // //   final Function? onViewTap;
// // //   final Function? onDeleteTap;
// // //   final Function? onEmailTap;
// // //   final Function? onLinkOffTap;
// // //   final Function? onApproveTap;
// // //   final int? incidentType;
// // //   final bool isIncident;
// // //   final Organisation? vendors;
// // //   final int? workShift;
// // //   final bool isWorkShift;
// // //   final int? transportIncidentType;
// // //   final Function? onLaunchTap;
// // //
// // //   // final Item userItem;
// // //   final int? index;
// // //
// // //   final bool? showViewButton;
// // //   final bool? showDeleteButton;
// // //   final bool? showEmailButton;
// // //   final bool? showLinkOffButton;
// // //   final bool? showApproveButton;
// // //   final bool isMasterGuard;
// // //   final bool? isMasterGuardRank;
// // //   final bool isEventProtectionStatus;
// // //   final bool isOccurrenceStatus;
// // //   final bool isSLAViolationStatus;
// // //   final bool isContactDetailsStatus;
// // //   final bool isSecuritySystemSLA;
// // //   final bool isKeyLossStatus;
// // //   final bool isKeyManagementStatus;
// // //   final bool isKeyManagementIssuanceStatus;
// // //   final bool isVipStatus;
// // //   final bool isMaterialMovementStatus;
// // //   final bool isKeyManagementHistoryStatus;
// // //   final bool isShiftScheduleStatus;
// // //   final bool isDutyPostNameMasterStatus;
// // //   final bool isAttendanceStatus;
// // //   final bool? showEditButton;
// // //   final bool isPassManagementStatus;
// // //   final bool isLawEnforcementStatus;
// // //   final bool isArticleFoundStatus;
// // //   final bool isTicketStatus;
// // //   final bool isTransportStatus;
// // //   final bool isCSREventProtectionStatus;
// // //   final bool isPatrollingStatus;
// // //   final bool isDutyPostMasterStatus;
// // //   final bool? showLaunchButton;
// // //   final bool isParkingStatus;
// // //
// // //   /// NEW (optional): which card design to use.
// // //   final BaseTileVariant variant;
// // //
// // //   /// NEW (optional): only used by `BaseTileVariant.expandable`.
// // //   final bool initiallyExpanded;
// // //
// // //   const BaseListTileItem({
// // //     super.key,
// // //     this.id,
// // //     this.location,
// // //     this.locationRegion,
// // //     this.inputDate,
// // //     this.status,
// // //     this.onTap,
// // //     this.onEditTap,
// // //     this.showViewButton,
// // //     this.onViewTap,
// // //     this.onEmailTap,
// // //     this.onLinkOffTap,
// // //     this.onApproveTap,
// // //     this.showApproveButton = false,
// // //     this.index,
// // //     this.region,
// // //     this.vendor,
// // //     this.guardCount,
// // //     this.pvcExpired,
// // //     this.msgbExempted,
// // //     this.returnable,
// // //     this.isIncident = false,
// // //     this.locationStr,
// // //     this.guardRank,
// // //     this.labels,
// // //     this.isMasterGuard = false,
// // //     this.isMasterGuardRank = false,
// // //     this.isEventProtectionStatus = true,
// // //     this.isOccurrenceStatus = false,
// // //     this.isSLAViolationStatus = false,
// // //     this.incidentType,
// // //     this.isContactDetailsStatus = false,
// // //     this.isSecuritySystemSLA = false,
// // //     this.isKeyLossStatus = false,
// // //     this.isKeyManagementStatus = false,
// // //     this.isKeyManagementIssuanceStatus = false,
// // //     this.isVipStatus = false,
// // //     this.isMaterialMovementStatus = false,
// // //     this.onDeleteTap,
// // //     this.isKeyManagementHistoryStatus = false,
// // //     this.isDutyPostNameMasterStatus = false,
// // //     this.isShiftScheduleStatus = false,
// // //     this.isAttendanceStatus = false,
// // //     this.vendors,
// // //     this.showEditButton = false,
// // //     this.showDeleteButton = true,
// // //     this.showEmailButton = false,
// // //     this.showLinkOffButton = false,
// // //     this.isPassManagementStatus = false,
// // //     this.isLawEnforcementStatus = false,
// // //     this.isArticleFoundStatus = false,
// // //     this.workShift,
// // //     this.isWorkShift = false,
// // //     this.isTicketStatus = false,
// // //     this.isTransportStatus = false,
// // //     this.isCSREventProtectionStatus = false,
// // //     this.isPatrollingStatus = false,
// // //     this.isDutyPostMasterStatus = false,
// // //     this.transportIncidentType,
// // //     this.showLaunchButton = false,
// // //     this.isParkingStatus = false,
// // //     this.onLaunchTap,
// // //     this.variant = BaseTileVariant.classic,
// // //     this.initiallyExpanded = false,
// // //   });
// // //
// // //   @override
// // //   State<BaseListTileItem> createState() => _BaseListTileItemState();
// // // }
// // //
// // // class _BaseListTileItemState extends State<BaseListTileItem> {
// // //   bool isHovered = true;
// // //   late bool _expanded;
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _expanded = widget.initiallyExpanded;
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final details = _buildDetails();
// // //     final statuses = _buildStatusWidgets();
// // //     final iconOnly = widget.variant != BaseTileVariant.classic;
// // //     final onDark = widget.variant == BaseTileVariant.dark;
// // //     final actions = _buildActions(iconOnly: iconOnly, onDark: onDark);
// // //
// // //     Widget card;
// // //     switch (widget.variant) {
// // //       case BaseTileVariant.classic:
// // //         card = _classicCard(details, statuses, actions);
// // //         break;
// // //       case BaseTileVariant.strip:
// // //         card = _stripCard(details, statuses, actions);
// // //         break;
// // //       case BaseTileVariant.expandable:
// // //         card = _expandableCard(details, statuses, actions);
// // //         break;
// // //       case BaseTileVariant.dark:
// // //         card = _darkCard(details, statuses, actions);
// // //         break;
// // //     }
// // //
// // //     // Soft fade + slide-up when the card first appears
// // //     return TweenAnimationBuilder<double>(
// // //       tween: Tween(begin: 0, end: 1),
// // //       duration: const Duration(milliseconds: 380),
// // //       curve: Curves.easeOutCubic,
// // //       builder: (context, t, child) => Opacity(
// // //         opacity: t,
// // //         child:
// // //         Transform.translate(offset: Offset(0, 14 * (1 - t)), child: child),
// // //       ),
// // //       child: Padding(
// // //         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
// // //         child: card,
// // //       ),
// // //     );
// // //   }
// // //
// // //   void _handleTap() {
// // //     HapticFeedback.lightImpact();
// // //     widget.onTap?.call(widget.index);
// // //   }
// // //
// // //   BoxDecoration _cardDeco({double radius = 24, bool open = false}) {
// // //     return BoxDecoration(
// // //       color: Colors.white,
// // //       borderRadius: BorderRadius.circular(radius),
// // //       border: Border.all(
// // //         color: open ? _ListTheme.goldBorder : _ListTheme.cardBorder,
// // //         width: open ? 2.5 : 1,
// // //       ),
// // //       boxShadow: [
// // //         BoxShadow(
// // //           color: _ListTheme.navy.withValues(alpha: 0.09),
// // //           blurRadius: 24,
// // //           offset: const Offset(0, 10),
// // //         ),
// // //         BoxShadow(
// // //           color: _ListTheme.gold.withValues(alpha: 0.08),
// // //           blurRadius: 10,
// // //           offset: const Offset(0, 2),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   // ===========================================================================
// // //   // DESIGN 1: CLASSIC
// // //   // ===========================================================================
// // //   Widget _classicCard(
// // //       List<MapEntry<String, String>> details,
// // //       List<Widget> statuses,
// // //       List<Widget> actions,
// // //       ) {
// // //     return Container(
// // //       decoration: _cardDeco(),
// // //       child: ClipRRect(
// // //         borderRadius: BorderRadius.circular(23),
// // //         child: Material(
// // //           color: Colors.transparent,
// // //           child: InkWell(
// // //             onTap: _handleTap,
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.stretch,
// // //               children: [
// // //                 _buildHeader(),
// // //                 if (details.isNotEmpty) _buildDetailsBlock(details),
// // //                 if (actions.isNotEmpty)
// // //                   _actionsRow(actions,
// // //                       padding: const EdgeInsets.fromLTRB(16, 6, 16, 14)),
// // //                 if (statuses.isNotEmpty)
// // //                   _buildStatusFooter(statuses)
// // //                 else
// // //                   const SizedBox(height: 14),
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildHeader() {
// // //     final dateText = _dateText();
// // //
// // //     return Container(
// // //       padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
// // //       decoration: const BoxDecoration(
// // //         gradient: LinearGradient(
// // //           colors: [Colors.white, _ListTheme.pageBg],
// // //           begin: Alignment.topCenter,
// // //           end: Alignment.bottomCenter,
// // //         ),
// // //       ),
// // //       child: Row(
// // //         children: [
// // //           _goldTile(size: 35, radius: 16),
// // //           const SizedBox(width: 14),
// // //           Expanded(
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 const Text(
// // //                   'ID',
// // //                   style: TextStyle(
// // //                     color: _ListTheme.gold,
// // //                     fontSize: 11,
// // //                     fontWeight: FontWeight.w900,
// // //                     letterSpacing: 2.2,
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 2),
// // //                 Text(
// // //                   '${widget.id ?? '-'}',
// // //                   maxLines: 1,
// // //                   overflow: TextOverflow.ellipsis,
// // //                   style: const TextStyle(
// // //                     color: _ListTheme.navy,
// // //                     fontSize: 20,
// // //                     fontWeight: FontWeight.w900,
// // //                     height: 0.8,
// // //                   ),
// // //                 ),
// // //                 if (widget.locationRegion != null) ...[
// // //                   const SizedBox(height: 6),
// // //                   _regionChip(),
// // //                 ],
// // //               ],
// // //             ),
// // //           ),
// // //           // const SizedBox(width: 0),
// // //           Column(
// // //             crossAxisAlignment: CrossAxisAlignment.end,
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               if (dateText != null) ...[
// // //                 _datePill(dateText),
// // //                 // const SizedBox(height: 8),
// // //               ],
// // //               Container(
// // //                 height: 30,
// // //                 width: 30,
// // //                 decoration: BoxDecoration(
// // //                   shape: BoxShape.circle,
// // //                   color: _ListTheme.actionBg,
// // //                   border: Border.all(color: _ListTheme.cardBorder, width: 1),
// // //                 ),
// // //                 child: const Icon(Icons.chevron_right_rounded,
// // //                     size: 22, color: _ListTheme.gold),
// // //               ),
// // //             ],
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildDetailsBlock(List<MapEntry<String, String>> details) {
// // //     final rows = <Widget>[];
// // //     for (int i = 0; i < details.length; i++) {
// // //       rows.add(_detailRow(details[i].key, details[i].value));
// // //       if (i != details.length - 1) {
// // //         rows.add(const Padding(
// // //           padding: EdgeInsets.only(left: 52),
// // //           child: Divider(height: 1, thickness: 1, color: _ListTheme.divider),
// // //         ));
// // //       }
// // //     }
// // //     return Padding(
// // //       padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
// // //       child: Column(children: rows),
// // //     );
// // //   }
// // //
// // //   Widget _detailRow(String label, String value) {
// // //     final cleanLabel = _clean(label);
// // //     final accent = _accentForLabel(cleanLabel);
// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(vertical: 10),
// // //       child: Row(
// // //         children: [
// // //           Container(
// // //             height: 34,
// // //             width: 34,
// // //             decoration: BoxDecoration(
// // //               color: accent.tint,
// // //               shape: BoxShape.circle,
// // //             ),
// // //             child: Icon(accent.icon, size: 19, color: accent.color),
// // //           ),
// // //           // const SizedBox(width: 14),
// // //           Expanded(
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Text(
// // //                   cleanLabel,
// // //                   softWrap: true,
// // //                   style: const TextStyle(
// // //                     color: _ListTheme.labelGrey,
// // //                     fontSize: 12,
// // //                     fontWeight: FontWeight.w600,
// // //                     letterSpacing: 0.2,
// // //                   ),
// // //                 ),
// // //                 // const SizedBox(height: 2),
// // //                 Text(
// // //                   value.isEmpty ? '-' : value,
// // //                   softWrap: true,
// // //                   style: const TextStyle(
// // //                     color: _ListTheme.navy,
// // //                     fontSize: 15,
// // //                     fontWeight: FontWeight.w800,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildStatusFooter(List<Widget> statuses) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.stretch,
// // //       children: [
// // //         Container(
// // //           height: 3,
// // //           decoration: const BoxDecoration(
// // //             gradient: LinearGradient(
// // //               colors: [
// // //                 _ListTheme.gold,
// // //                 _ListTheme.goldLight,
// // //                 _ListTheme.gold,
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //         Container(
// // //           padding: const EdgeInsets.fromLTRB(18, 14, 18, 6),
// // //           decoration: const BoxDecoration(
// // //             gradient: LinearGradient(
// // //               colors: [_ListTheme.navyMid, _ListTheme.navyDark],
// // //               begin: Alignment.topLeft,
// // //               end: Alignment.bottomRight,
// // //             ),
// // //           ),
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: statuses,
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   // ===========================================================================
// // //   // DESIGN 2: STRIP (gold-to-teal accent strip, 2-column chips)
// // //   // ===========================================================================
// // //   Widget _stripCard(
// // //       List<MapEntry<String, String>> details,
// // //       List<Widget> statuses,
// // //       List<Widget> actions,
// // //       ) {
// // //     final dateText = _dateText();
// // //
// // //     return Container(
// // //       decoration: _cardDeco(radius: 22),
// // //       child: ClipRRect(
// // //         borderRadius: BorderRadius.circular(21),
// // //         child: Material(
// // //           color: Colors.transparent,
// // //           child: InkWell(
// // //             onTap: _handleTap,
// // //             child: Stack(
// // //               children: [
// // //                 const Positioned(
// // //                   left: 0,
// // //                   top: 0,
// // //                   bottom: 0,
// // //                   width: 6,
// // //                   child: DecoratedBox(
// // //                     decoration: BoxDecoration(
// // //                       gradient: LinearGradient(
// // //                         colors: [_ListTheme.gold, _ListTheme.teal],
// // //                         begin: Alignment.topCenter,
// // //                         end: Alignment.bottomCenter,
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 Padding(
// // //                   padding: const EdgeInsets.fromLTRB(22, 16, 16, 14),
// // //                   child: Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Row(
// // //                         children: [
// // //                           _goldTile(size: 46, radius: 14),
// // //                           const SizedBox(width: 12),
// // //                           Expanded(
// // //                             child: Column(
// // //                               crossAxisAlignment: CrossAxisAlignment.start,
// // //                               children: [
// // //                                 const Text(
// // //                                   'ID',
// // //                                   style: TextStyle(
// // //                                     color: _ListTheme.gold,
// // //                                     fontSize: 10.5,
// // //                                     fontWeight: FontWeight.w800,
// // //                                     letterSpacing: 2,
// // //                                   ),
// // //                                 ),
// // //                                 Text(
// // //                                   '${widget.id ?? '-'}',
// // //                                   maxLines: 1,
// // //                                   overflow: TextOverflow.ellipsis,
// // //                                   style: const TextStyle(
// // //                                     color: _ListTheme.navy,
// // //                                     fontSize: 22,
// // //                                     fontWeight: FontWeight.w900,
// // //                                     height: 1.1,
// // //                                   ),
// // //                                 ),
// // //                               ],
// // //                             ),
// // //                           ),
// // //                           if (dateText != null) _datePill(dateText),
// // //                         ],
// // //                       ),
// // //                       if (details.isNotEmpty) ...[
// // //                         const SizedBox(height: 14),
// // //                         LayoutBuilder(
// // //                           builder: (context, c) {
// // //                             final half = (c.maxWidth - 10) / 2;
// // //                             return Wrap(
// // //                               spacing: 10,
// // //                               runSpacing: 10,
// // //                               children: details
// // //                                   .map((e) => SizedBox(
// // //                                 width: details.length == 1
// // //                                     ? c.maxWidth
// // //                                     : half,
// // //                                 child: _detailChip(e.key, e.value),
// // //                               ))
// // //                                   .toList(),
// // //                             );
// // //                           },
// // //                         ),
// // //                       ],
// // //                       if (statuses.isNotEmpty) ...[
// // //                         const SizedBox(height: 14),
// // //                         _statusBand(statuses, radius: 16),
// // //                       ],
// // //                       if (actions.isNotEmpty) ...[
// // //                         const SizedBox(height: 12),
// // //                         Align(
// // //                           alignment: Alignment.centerRight,
// // //                           child: Wrap(
// // //                             spacing: 10,
// // //                             runSpacing: 10,
// // //                             alignment: WrapAlignment.end,
// // //                             children: actions,
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _detailChip(String label, String value) {
// // //     final cleanLabel = _clean(label);
// // //     final accent = _accentForLabel(cleanLabel);
// // //     return Container(
// // //       padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
// // //       decoration: BoxDecoration(
// // //         color: accent.tint.withValues(alpha: 0.55),
// // //         borderRadius: BorderRadius.circular(16),
// // //       ),
// // //       child: Row(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Container(
// // //             height: 30,
// // //             width: 30,
// // //             decoration: const BoxDecoration(
// // //               color: Colors.white,
// // //               shape: BoxShape.circle,
// // //             ),
// // //             child: Icon(accent.icon, size: 16, color: accent.color),
// // //           ),
// // //           const SizedBox(width: 8),
// // //           Expanded(
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Text(
// // //                   cleanLabel,
// // //                   style: const TextStyle(
// // //                     color: _ListTheme.labelGrey,
// // //                     fontSize: 11,
// // //                     fontWeight: FontWeight.w600,
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 2),
// // //                 Text(
// // //                   value.isEmpty ? '-' : value,
// // //                   style: const TextStyle(
// // //                     color: _ListTheme.navy,
// // //                     fontSize: 13.5,
// // //                     fontWeight: FontWeight.w800,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   // ===========================================================================
// // //   // DESIGN 3: EXPANDABLE (collapsed summary, chevron opens the details)
// // //   // ===========================================================================
// // //   Widget _expandableCard(
// // //       List<MapEntry<String, String>> details,
// // //       List<Widget> statuses,
// // //       List<Widget> actions,
// // //       ) {
// // //     final hasDetails = details.isNotEmpty;
// // //     final chipText = widget.locationRegion?.name ??
// // //         (hasDetails ? '${details.length} details' : null);
// // //
// // //     return AnimatedContainer(
// // //       duration: const Duration(milliseconds: 250),
// // //       curve: Curves.easeOut,
// // //       decoration: _cardDeco(radius: 26, open: _expanded),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.stretch,
// // //         children: [
// // //           InkWell(
// // //             borderRadius: BorderRadius.circular(26),
// // //             onTap: () {
// // //               HapticFeedback.lightImpact();
// // //               if (widget.onTap != null) {
// // //                 widget.onTap!(widget.index);
// // //               } else if (hasDetails) {
// // //                 setState(() => _expanded = !_expanded);
// // //               }
// // //             },
// // //             child: Padding(
// // //               padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
// // //               child: Row(
// // //                 children: [
// // //                   _goldTile(size: 58, radius: 18, glow: _expanded),
// // //                   const SizedBox(width: 16),
// // //                   Expanded(
// // //                     child: Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // //                       children: [
// // //                         Text(
// // //                           'ID : ${widget.id ?? '-'}',
// // //                           maxLines: 1,
// // //                           overflow: TextOverflow.ellipsis,
// // //                           style: const TextStyle(
// // //                             color: _ListTheme.navy,
// // //                             fontSize: 20,
// // //                             fontWeight: FontWeight.w800,
// // //                           ),
// // //                         ),
// // //                         if (chipText != null && chipText.isNotEmpty) ...[
// // //                           const SizedBox(height: 6),
// // //                           Container(
// // //                             padding: const EdgeInsets.symmetric(
// // //                                 horizontal: 10, vertical: 3),
// // //                             decoration: BoxDecoration(
// // //                               color: _ListTheme.chipBg,
// // //                               borderRadius: BorderRadius.circular(20),
// // //                             ),
// // //                             child: Text(
// // //                               chipText,
// // //                               maxLines: 1,
// // //                               overflow: TextOverflow.ellipsis,
// // //                               style: const TextStyle(
// // //                                 color: _ListTheme.gold,
// // //                                 fontSize: 12,
// // //                                 fontWeight: FontWeight.w700,
// // //                               ),
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ],
// // //                     ),
// // //                   ),
// // //                   if (hasDetails) ...[
// // //                     const SizedBox(width: 10),
// // //                     GestureDetector(
// // //                       behavior: HitTestBehavior.opaque,
// // //                       onTap: () {
// // //                         HapticFeedback.selectionClick();
// // //                         setState(() => _expanded = !_expanded);
// // //                       },
// // //                       child: AnimatedContainer(
// // //                         duration: const Duration(milliseconds: 250),
// // //                         height: 40,
// // //                         width: 40,
// // //                         decoration: BoxDecoration(
// // //                           shape: BoxShape.circle,
// // //                           color: _expanded
// // //                               ? _ListTheme.gold
// // //                               : _ListTheme.actionBg,
// // //                         ),
// // //                         child: Icon(
// // //                           _expanded
// // //                               ? Icons.keyboard_arrow_up_rounded
// // //                               : Icons.keyboard_arrow_down_rounded,
// // //                           size: 24,
// // //                           color: _expanded ? Colors.white : _ListTheme.gold,
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //           AnimatedSize(
// // //             duration: const Duration(milliseconds: 250),
// // //             curve: Curves.easeOut,
// // //             alignment: Alignment.topCenter,
// // //             child: (_expanded && hasDetails)
// // //                 ? Padding(
// // //               padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
// // //               child: Column(
// // //                 children: details
// // //                     .map((e) => _detailPill(e.key, e.value))
// // //                     .toList(),
// // //               ),
// // //             )
// // //                 : const SizedBox(width: double.infinity),
// // //           ),
// // //           if (statuses.isNotEmpty)
// // //             Padding(
// // //               padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
// // //               child: _statusBand(statuses, radius: 20),
// // //             ),
// // //           if (actions.isNotEmpty)
// // //             _actionsRow(actions,
// // //                 padding: const EdgeInsets.fromLTRB(16, 12, 16, 14))
// // //           else
// // //             const SizedBox(height: 14),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _detailPill(String label, String value) {
// // //     final cleanLabel = _clean(label);
// // //     final accent = _accentForLabel(cleanLabel);
// // //     return Container(
// // //       margin: const EdgeInsets.only(top: 10),
// // //       padding: const EdgeInsets.fromLTRB(12, 10, 16, 10),
// // //       decoration: BoxDecoration(
// // //         color: _ListTheme.pageBg,
// // //         borderRadius: BorderRadius.circular(20),
// // //         border: Border.all(color: _ListTheme.cardBorder, width: 1),
// // //       ),
// // //       child: Row(
// // //         children: [
// // //           Container(
// // //             height: 42,
// // //             width: 42,
// // //             decoration: BoxDecoration(
// // //               shape: BoxShape.circle,
// // //               color: accent.tint,
// // //             ),
// // //             child: Icon(accent.icon, size: 20, color: accent.color),
// // //           ),
// // //           const SizedBox(width: 14),
// // //           Expanded(
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Text(
// // //                   cleanLabel,
// // //                   style: const TextStyle(
// // //                     color: _ListTheme.labelGrey,
// // //                     fontSize: 12,
// // //                     fontWeight: FontWeight.w600,
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 2),
// // //                 Text(
// // //                   value.isEmpty ? '-' : value,
// // //                   style: const TextStyle(
// // //                     color: _ListTheme.navy,
// // //                     fontSize: 15.5,
// // //                     fontWeight: FontWeight.w700,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   // ===========================================================================
// // //   // DESIGN 4: DARK (navy card, gold border, glass detail rows)
// // //   // ===========================================================================
// // //   Widget _darkCard(
// // //       List<MapEntry<String, String>> details,
// // //       List<Widget> statuses,
// // //       List<Widget> actions,
// // //       ) {
// // //     final dateText = _dateText();
// // //
// // //     return Container(
// // //       decoration: BoxDecoration(
// // //         borderRadius: BorderRadius.circular(24),
// // //         gradient: const LinearGradient(
// // //           colors: [_ListTheme.navyMid, _ListTheme.navyDark],
// // //           begin: Alignment.topLeft,
// // //           end: Alignment.bottomRight,
// // //         ),
// // //         border: Border.all(
// // //           color: _ListTheme.goldBorder.withValues(alpha: 0.65),
// // //           width: 1.2,
// // //         ),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: _ListTheme.navy.withValues(alpha: 0.35),
// // //             blurRadius: 24,
// // //             offset: const Offset(0, 12),
// // //           ),
// // //         ],
// // //       ),
// // //       child: ClipRRect(
// // //         borderRadius: BorderRadius.circular(23),
// // //         child: Material(
// // //           color: Colors.transparent,
// // //           child: InkWell(
// // //             onTap: _handleTap,
// // //             child: Padding(
// // //               padding: const EdgeInsets.all(16),
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.stretch,
// // //                 children: [
// // //                   Row(
// // //                     children: [
// // //                       _goldTile(size: 50, radius: 15),
// // //                       const SizedBox(width: 14),
// // //                       Expanded(
// // //                         child: Column(
// // //                           crossAxisAlignment: CrossAxisAlignment.start,
// // //                           children: [
// // //                             const Text(
// // //                               'ID',
// // //                               style: TextStyle(
// // //                                 color: _ListTheme.goldLight,
// // //                                 fontSize: 11,
// // //                                 fontWeight: FontWeight.w800,
// // //                                 letterSpacing: 2.2,
// // //                               ),
// // //                             ),
// // //                             Text(
// // //                               '${widget.id ?? '-'}',
// // //                               maxLines: 1,
// // //                               overflow: TextOverflow.ellipsis,
// // //                               style: const TextStyle(
// // //                                 color: Colors.white,
// // //                                 fontSize: 24,
// // //                                 fontWeight: FontWeight.w900,
// // //                                 height: 1.1,
// // //                               ),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                       if (dateText != null)
// // //                         _datePill(dateText, onDark: true),
// // //                     ],
// // //                   ),
// // //                   if (details.isNotEmpty) ...[
// // //                     const SizedBox(height: 6),
// // //                     ...details.map((e) => _darkDetail(e.key, e.value)),
// // //                   ],
// // //                   if (statuses.isNotEmpty) ...[
// // //                     const SizedBox(height: 14),
// // //                     Divider(
// // //                       height: 1,
// // //                       thickness: 1,
// // //                       color: _ListTheme.goldLight.withValues(alpha: 0.25),
// // //                     ),
// // //                     const SizedBox(height: 12),
// // //                     Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // //                       children: statuses,
// // //                     ),
// // //                   ],
// // //                   if (actions.isNotEmpty) ...[
// // //                     const SizedBox(height: 4),
// // //                     Align(
// // //                       alignment: Alignment.centerRight,
// // //                       child: Wrap(
// // //                         spacing: 10,
// // //                         runSpacing: 10,
// // //                         alignment: WrapAlignment.end,
// // //                         children: actions,
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _darkDetail(String label, String value) {
// // //     final cleanLabel = _clean(label);
// // //     final accent = _accentForLabel(cleanLabel);
// // //     final light = Color.lerp(accent.color, Colors.white, 0.35)!;
// // //     return Container(
// // //       margin: const EdgeInsets.only(top: 10),
// // //       padding: const EdgeInsets.fromLTRB(10, 10, 14, 10),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white.withValues(alpha: 0.07),
// // //         borderRadius: BorderRadius.circular(18),
// // //         border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
// // //       ),
// // //       child: Row(
// // //         children: [
// // //           Container(
// // //             height: 38,
// // //             width: 38,
// // //             decoration: BoxDecoration(
// // //               shape: BoxShape.circle,
// // //               color: accent.color.withValues(alpha: 0.2),
// // //             ),
// // //             child: Icon(accent.icon, size: 19, color: light),
// // //           ),
// // //           const SizedBox(width: 12),
// // //           Expanded(
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Text(
// // //                   cleanLabel,
// // //                   style: const TextStyle(
// // //                     color: Color(0xFFB9B4E0),
// // //                     fontSize: 11.5,
// // //                     fontWeight: FontWeight.w600,
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 2),
// // //                 Text(
// // //                   value.isEmpty ? '-' : value,
// // //                   style: const TextStyle(
// // //                     color: Colors.white,
// // //                     fontSize: 15,
// // //                     fontWeight: FontWeight.w700,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   // ===========================================================================
// // //   // SHARED PIECES
// // //   // ===========================================================================
// // //   String _clean(String label) =>
// // //       label.replaceAll(RegExp(r'\s*:\s*$'), '').trim();
// // //
// // //   String? _dateText() {
// // //     final ts = int.tryParse(widget.inputDate ?? '');
// // //     if (ts == null) return null;
// // //     final t = Utils.timestampToDateConversion(ts, Constants.dateFormat);
// // //     return (t.isEmpty) ? null : t;
// // //   }
// // //
// // //   Widget _goldTile({
// // //     required double size,
// // //     required double radius,
// // //     bool glow = true,
// // //   }) {
// // //     return Container(
// // //       height: size,
// // //       width: size,
// // //       decoration: BoxDecoration(
// // //         borderRadius: BorderRadius.circular(radius),
// // //         gradient: const LinearGradient(
// // //           colors: [_ListTheme.goldLight, _ListTheme.gold],
// // //           begin: Alignment.topLeft,
// // //           end: Alignment.bottomRight,
// // //         ),
// // //         border: Border.all(
// // //           color: Colors.white.withValues(alpha: 0.8),
// // //           width: 1.2,
// // //         ),
// // //         boxShadow: glow
// // //             ? [
// // //           BoxShadow(
// // //             color: _ListTheme.gold.withValues(alpha: 0.45),
// // //             blurRadius: 14,
// // //             offset: const Offset(0, 6),
// // //           ),
// // //         ]
// // //             : null,
// // //       ),
// // //       child: Icon(Icons.assignment_rounded,
// // //           color: Colors.white, size: size * 0.48),
// // //     );
// // //   }
// // //
// // //   Widget _regionChip() {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
// // //       decoration: BoxDecoration(
// // //         color: _ListTheme.chipBg,
// // //         borderRadius: BorderRadius.circular(20),
// // //       ),
// // //       child: Row(
// // //         mainAxisSize: MainAxisSize.min,
// // //         children: [
// // //           const Icon(Icons.public_rounded, size: 13, color: _ListTheme.gold),
// // //           const SizedBox(width: 5),
// // //           Flexible(
// // //             child: Text(
// // //               widget.locationRegion?.name ?? '',
// // //               maxLines: 1,
// // //               overflow: TextOverflow.ellipsis,
// // //               style: const TextStyle(
// // //                 color: _ListTheme.gold,
// // //                 fontSize: 12,
// // //                 fontWeight: FontWeight.w700,
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _datePill(String text, {bool onDark = false}) {
// // //     final fg = onDark ? _ListTheme.goldLight : _ListTheme.labelGrey;
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
// // //       decoration: BoxDecoration(
// // //         color: onDark ? Colors.white.withValues(alpha: 0.1) : Colors.white,
// // //         borderRadius: BorderRadius.circular(20),
// // //         border: Border.all(
// // //           color: onDark
// // //               ? Colors.white.withValues(alpha: 0.25)
// // //               : _ListTheme.cardBorder,
// // //           width: 1,
// // //         ),
// // //       ),
// // //       child: Row(
// // //         mainAxisSize: MainAxisSize.min,
// // //         children: [
// // //           Icon(Icons.calendar_today_rounded, size: 12, color: fg),
// // //           const SizedBox(width: 5),
// // //           Text(
// // //             text,
// // //             style: TextStyle(
// // //               color: fg,
// // //               fontSize: 11.5,
// // //               fontWeight: FontWeight.w700,
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _statusBand(List<Widget> statuses, {double radius = 16}) {
// // //     return Container(
// // //       padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
// // //       decoration: BoxDecoration(
// // //         borderRadius: BorderRadius.circular(radius),
// // //         gradient: const LinearGradient(
// // //           colors: [_ListTheme.navyMid, _ListTheme.navyDark],
// // //           begin: Alignment.topLeft,
// // //           end: Alignment.bottomRight,
// // //         ),
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: statuses,
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _statusItem(Widget child, {bool expand = false}) {
// // //     return Padding(
// // //       padding: const EdgeInsets.only(bottom: 8),
// // //       child: expand
// // //           ? Row(children: [Expanded(child: child)])
// // //           : Align(alignment: Alignment.centerLeft, child: child),
// // //     );
// // //   }
// // //
// // //   Widget _actionsRow(List<Widget> actions, {required EdgeInsets padding}) {
// // //     return Padding(
// // //       padding: padding,
// // //       child: Wrap(
// // //         spacing: 10,
// // //         runSpacing: 10,
// // //         alignment: WrapAlignment.end,
// // //         children: actions,
// // //       ),
// // //     );
// // //   }
// // //
// // //   ({IconData icon, Color color, Color tint}) _accentForLabel(String label) {
// // //     final l = label.toLowerCase();
// // //     if (l.contains('date') || l.contains('time') || l.contains('valid')) {
// // //       return (
// // //       icon: Icons.calendar_month_rounded,
// // //       color: _ListTheme.amber,
// // //       tint: _ListTheme.amberTint
// // //       );
// // //     }
// // //     if (l.contains('location') || l.contains('region') || l.contains('area')) {
// // //       return (
// // //       icon: Icons.location_on_rounded,
// // //       color: _ListTheme.teal,
// // //       tint: _ListTheme.tealTint
// // //       );
// // //     }
// // //     if (l.contains('created') ||
// // //         l.contains('by') ||
// // //         l.contains('name') ||
// // //         l.contains('manager') ||
// // //         l.contains('guard')) {
// // //       return (
// // //       icon: Icons.person_rounded,
// // //       color: _ListTheme.violet,
// // //       tint: _ListTheme.violetTint
// // //       );
// // //     }
// // //     if (l.contains('vendor') || l.contains('company') || l.contains('dept')) {
// // //       return (
// // //       icon: Icons.business_rounded,
// // //       color: _ListTheme.blue,
// // //       tint: _ListTheme.blueTint
// // //       );
// // //     }
// // //     return (
// // //     icon: Icons.tag_rounded,
// // //     color: _ListTheme.gold,
// // //     tint: _ListTheme.chipBg
// // //     );
// // //   }
// // //
// // //   // ---------------------------------------------------------------------------
// // //   // ACTION BUTTONS (pill with label for classic, round icon for the others)
// // //   // ---------------------------------------------------------------------------
// // //   Widget _actionPill({
// // //     required IconData icon,
// // //     required String label,
// // //     required VoidCallback onPressed,
// // //     Color? color,
// // //     bool primary = false,
// // //     bool iconOnly = false,
// // //     bool onDark = false,
// // //   }) {
// // //     final Color fg = primary
// // //         ? Colors.white
// // //         : (color ?? (onDark ? Colors.white : _ListTheme.navy));
// // //
// // //     final decoration = BoxDecoration(
// // //       shape: iconOnly ? BoxShape.circle : BoxShape.rectangle,
// // //       borderRadius: iconOnly ? null : BorderRadius.circular(30),
// // //       gradient: primary
// // //           ? LinearGradient(
// // //         colors: onDark
// // //             ? const [_ListTheme.goldLight, _ListTheme.gold]
// // //             : const [_ListTheme.navyMid, _ListTheme.navyDark],
// // //       )
// // //           : null,
// // //       color: primary
// // //           ? null
// // //           : (onDark
// // //           ? Colors.white.withValues(alpha: 0.1)
// // //           : _ListTheme.actionBg),
// // //       border: primary
// // //           ? null
// // //           : Border.all(
// // //         color: onDark
// // //             ? Colors.white.withValues(alpha: 0.25)
// // //             : _ListTheme.cardBorder,
// // //         width: 1,
// // //       ),
// // //       boxShadow: primary
// // //           ? [
// // //         BoxShadow(
// // //           color: (onDark ? _ListTheme.gold : _ListTheme.navy)
// // //               .withValues(alpha: 0.3),
// // //           blurRadius: 10,
// // //           offset: const Offset(0, 4),
// // //         ),
// // //       ]
// // //           : null,
// // //     );
// // //
// // //     final button = Material(
// // //       color: Colors.transparent,
// // //       child: InkWell(
// // //         onTap: onPressed,
// // //         customBorder: iconOnly ? const CircleBorder() : null,
// // //         borderRadius: iconOnly ? null : BorderRadius.circular(30),
// // //         child: Ink(
// // //           decoration: decoration,
// // //           child: iconOnly
// // //               ? SizedBox(
// // //             height: 40,
// // //             width: 40,
// // //             child: Icon(icon, size: 19, color: fg),
// // //           )
// // //               : Padding(
// // //             padding:
// // //             const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
// // //             child: Row(
// // //               mainAxisSize: MainAxisSize.min,
// // //               children: [
// // //                 Icon(icon, size: 17, color: fg),
// // //                 const SizedBox(width: 6),
// // //                 Text(
// // //                   label,
// // //                   style: TextStyle(
// // //                     color: fg,
// // //                     fontSize: 13,
// // //                     fontWeight: FontWeight.w700,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //
// // //     return iconOnly ? Tooltip(message: label, child: button) : button;
// // //   }
// // //
// // //   List<Widget> _buildActions({bool iconOnly = false, bool onDark = false}) {
// // //     final a = <Widget>[];
// // //
// // //     void add(
// // //         IconData icon,
// // //         String label,
// // //         Function? cb, {
// // //           Color? color,
// // //           bool primary = false,
// // //         }) {
// // //       a.add(_actionPill(
// // //         icon: icon,
// // //         label: label,
// // //         color: color,
// // //         primary: primary,
// // //         iconOnly: iconOnly,
// // //         onDark: onDark,
// // //         onPressed: () {
// // //           cb != null ? cb(widget.index) : null;
// // //         },
// // //       ));
// // //     }
// // //
// // //     add(
// // //       (widget.showEditButton ?? true)
// // //           ? Icons.edit_rounded
// // //           : Icons.edit_off_outlined,
// // //       'Edit',
// // //       widget.onEditTap,
// // //       color: onDark ? _ListTheme.goldLight : _ListTheme.gold,
// // //     );
// // //
// // //     if (widget.showViewButton ?? true) {
// // //       add(
// // //         iconOnly ? Icons.arrow_forward_rounded : Icons.visibility_rounded,
// // //         'View',
// // //         widget.onViewTap,
// // //         primary: true,
// // //       );
// // //     }
// // //
// // //     if (widget.isSecuritySystemSLA == true && widget.status == 2 ||
// // //         widget.status == 3 ||
// // //         widget.status == 4 ||
// // //         widget.status == 5 ||
// // //         widget.status == 8 ||
// // //         widget.status == 10 ||
// // //         widget.status == 12) {
// // //       if (widget.showEmailButton ?? true) {
// // //         add(Icons.email_rounded, 'Email', widget.onEmailTap,
// // //             color: onDark ? const Color(0xFF8EC3FF) : const Color(0xFF0C4C99));
// // //       }
// // //     }
// // //
// // //     if (widget.showLinkOffButton ?? true) {
// // //       add(Icons.link_off_rounded, 'Unlink', widget.onLinkOffTap);
// // //     }
// // //
// // //     if (widget.showLaunchButton ?? true) {
// // //       add(Icons.rocket_launch_rounded, 'Launch', widget.onLaunchTap,
// // //           color: onDark ? _ListTheme.goldLight : _ListTheme.gold);
// // //     }
// // //
// // //     if ((widget.showDeleteButton ?? true) && widget.onDeleteTap != null) {
// // //       add(Icons.delete_rounded, 'Delete', widget.onDeleteTap,
// // //           color: onDark ? const Color(0xFFFF8E8E) : const Color(0xFFD64545));
// // //     }
// // //
// // //     if (widget.showApproveButton ?? true) {
// // //       add(Icons.approval_rounded, 'Approve', widget.onApproveTap);
// // //     }
// // //
// // //     return a;
// // //   }
// // //
// // //   // ---------------------------------------------------------------------------
// // //   // DATA: label / value rows
// // //   // ---------------------------------------------------------------------------
// // //   List<MapEntry<String, String>> _buildDetails() {
// // //     final d = <MapEntry<String, String>>[];
// // //
// // //     void add(String label, Object? value) {
// // //       if (value == null) return;
// // //       d.add(MapEntry(label, value.toString()));
// // //     }
// // //
// // //     if (widget.location != null) {
// // //       add('Location : ', widget.location?.name ?? '');
// // //     }
// // //     if (widget.locationStr != null) add('Location : ', widget.locationStr);
// // //     if (widget.vendors != null) add('Vendor : ', widget.vendors?.name ?? '');
// // //     if (widget.guardCount != null) add('Guard Count : ', widget.guardCount);
// // //     if (widget.pvcExpired != null) {
// // //       add('Staff PVC Expired : ', widget.pvcExpired);
// // //     }
// // //     if (widget.vendor != null) add('Vendor : ', widget.vendor);
// // //
// // //     for (Label label in widget.labels ?? []) {
// // //       if (label.value == 'null' || label.value.isEmpty) continue;
// // //       d.add(MapEntry('${label.key} : ', label.value));
// // //     }
// // //     return d;
// // //   }
// // //
// // //   // ---------------------------------------------------------------------------
// // //   // DATA: status widgets (built by Utils())
// // //   // ---------------------------------------------------------------------------
// // //   List<Widget> _buildStatusWidgets() {
// // //     final w = <Widget>[];
// // //     final s = widget.status;
// // //
// // //     if (widget.guardRank != -1 && widget.isMasterGuardRank == true) {
// // //       w.add(_statusItem(
// // //           Utils().buildGuardRank(guardRank: widget.guardRank ?? 0)));
// // //     }
// // //     if (widget.workShift != -1 && widget.isWorkShift == true) {
// // //       w.add(_statusItem(
// // //           Utils().buildWorkShift(workShift: widget.workShift ?? 0)));
// // //     }
// // //     if (widget.incidentType != null) {
// // //       w.add(_statusItem(Utils().incidentType(widget.incidentType ?? 0)));
// // //     }
// // //     if (widget.transportIncidentType != null) {
// // //       w.add(_statusItem(
// // //           Utils().transportIncidentType(widget.transportIncidentType ?? 0)));
// // //     }
// // //     if (s != null &&
// // //         widget.isArticleFoundStatus == true &&
// // //         !widget.isShiftScheduleStatus) {
// // //       w.add(_statusItem(Utils().buildFoundStatusRow(s)));
// // //     }
// // //     if (s != null && widget.isEventProtectionStatus && !widget.isMasterGuard) {
// // //       w.add(_statusItem(Utils().buildEventProtectionStatusRow(s)));
// // //     }
// // //     if (s != null &&
// // //         widget.isCSREventProtectionStatus &&
// // //         !widget.isMasterGuard) {
// // //       w.add(_statusItem(Utils().buildCSRProtectionStatusRow(s)));
// // //     }
// // //     if (s != null && widget.isIncident == true) {
// // //       w.add(_statusItem(Utils().buildIncidentStatus(s)));
// // //     }
// // //     if (s != null &&
// // //         widget.isLawEnforcementStatus == true &&
// // //         !widget.isShiftScheduleStatus) {
// // //       w.add(_statusItem(Utils().buildLeoStatusRow(s)));
// // //     }
// // //     if (s != null &&
// // //         widget.isMaterialMovementStatus == true &&
// // //         !widget.isMasterGuard) {
// // //       w.add(_statusItem(Utils().buildMaterialMovementStatusRow(s),
// // //           expand: true));
// // //     }
// // //     if (s != 0 && widget.isMasterGuard) {
// // //       w.add(_statusItem(Utils().buildMasterDataStatusRow(s ?? 0)));
// // //     }
// // //     if (s != null && widget.isKeyManagementIssuanceStatus) {
// // //       w.add(_statusItem(Utils().keyManagementIssuanceStatus(s),
// // //           expand: true));
// // //     }
// // //     if (s != null && widget.isPatrollingStatus) {
// // //       w.add(_statusItem(Utils().patrollingStatus(s), expand: true));
// // //     }
// // //     if (s != null && widget.isParkingStatus) {
// // //       w.add(_statusItem(Utils().parkingStatus(s), expand: true));
// // //     }
// // //     if (s != null && widget.isAttendanceStatus == true) {
// // //       w.add(_statusItem(Utils().buildAttendanceStatusRow(s)));
// // //     }
// // //     if (s != null && widget.isKeyManagementStatus) {
// // //       w.add(_statusItem(Utils().keyManagementStatus(s)));
// // //     }
// // //     if (s != null && widget.isKeyManagementHistoryStatus) {
// // //       w.add(_statusItem(Utils().keyManagementMasterHistoryStatus(s)));
// // //     }
// // //     if (s != null && widget.isOccurrenceStatus == true) {
// // //       w.add(_statusItem(Utils().buildOccurrenceStatus(s)));
// // //     }
// // //     if (s != null && widget.isKeyLossStatus == true) {
// // //       w.add(_statusItem(Utils().keyLossDestructionStatus(s)));
// // //     }
// // //     if (s != null && widget.isSLAViolationStatus == true) {
// // //       w.add(_statusItem(Utils().buildSLAViolationStatus(s)));
// // //     }
// // //     if (s != null &&
// // //         widget.isContactDetailsStatus == true &&
// // //         widget.isEventProtectionStatus == false) {
// // //       w.add(_statusItem(Utils().contactDetailsStatus(s)));
// // //     }
// // //     if (s != null &&
// // //         widget.isEventProtectionStatus == false &&
// // //         widget.isSecuritySystemSLA == true) {
// // //       w.add(_statusItem(Utils().buildSecuritySystemStatusRow(s)));
// // //     }
// // //     if (widget.isVipStatus == true) {
// // //       w.add(_statusItem(Utils().vIPVisitorStatusRow(s ?? 0)));
// // //     }
// // //     if (s != null && widget.isShiftScheduleStatus == true) {
// // //       w.add(_statusItem(Utils().shiftScheduleStatusRow(s)));
// // //     }
// // //     if (s != null && widget.isTransportStatus == true) {
// // //       w.add(_statusItem(Utils().transportMedicalStatus(s)));
// // //     }
// // //     if (s != null && widget.isDutyPostNameMasterStatus == true) {
// // //       w.add(_statusItem(Utils().dutyPostNameMasterStatus(s)));
// // //     }
// // //     if (s != null && widget.isDutyPostMasterStatus == true) {
// // //       w.add(_statusItem(Utils().dutyPostMasterStatus(s)));
// // //     }
// // //     if (s != null &&
// // //         widget.isPassManagementStatus == true &&
// // //         !widget.isShiftScheduleStatus) {
// // //       w.add(_statusItem(Utils().buildPassManagementStatusRow(s)));
// // //     }
// // //     if (s != null && widget.isTicketStatus) {
// // //       w.add(_statusItem(Utils().buildTicketStatusRow(s)));
// // //     }
// // //
// // //     return w;
// // //   }
// // // }
// // //
// // // class Label {
// // //   final String key;
// // //   final String value;
// // //
// // //   const Label({
// // //     required this.key,
// // //     required this.value,
// // //   });
// // // }
// //
// // import 'package:db_atom/index.dart';
// //
// // /// Card designs. Pick one per screen with `variant:`.
// // enum BaseTileVariant {
// //   classic, // header + detail rows + status footer (with Edit beside status)
// //   strip, // accent strip, 2-column detail chips
// //   expandable, // collapsed summary, tap chevron to open
// //   dark, // navy card with gold accents
// // }
// //
// // class _ListTheme {
// //   static const Color navy = Color(0xFF14086B);
// //   static const Color navyDark = Color(0xFF0B0450);
// //   static const Color navyMid = Color(0xFF1E0F8A);
// //   static const Color gold = Color(0xFFB8895A);
// //   static const Color goldLight = Color(0xFFE6CFB0);
// //   static const Color goldBorder = Color(0xFFC9A98A);
// //   static const Color pageBg = Color(0xFFFBF7F0);
// //   static const Color cardBorder = Color(0xFFE8DFD0);
// //   static const Color divider = Color(0xFFF1EBE0);
// //   static const Color chipBg = Color(0xFFF5EEE7);
// //   static const Color labelGrey = Color(0xFF8A8499);
// //   static const Color actionBg = Color(0xFFFBF3E6);
// //   static const Color iconTint = Color(0xFFEEEBFA);
// //
// //   // Accent colours for detail icons
// //   static const Color amber = Color(0xFFD98E2B);
// //   static const Color amberTint = Color(0xFFFDF0DA);
// //   static const Color teal = Color(0xFF1F9488);
// //   static const Color tealTint = Color(0xFFE0F3F0);
// //   static const Color violet = Color(0xFF7D5BB5);
// //   static const Color violetTint = Color(0xFFEFE8F8);
// //   static const Color blue = Color(0xFF2F6DB5);
// //   static const Color blueTint = Color(0xFFE3EEF9);
// // }
// //
// // class BaseListTileItem extends StatefulWidget {
// //   final num? id;
// //   final Organisation? location;
// //   final bool? returnable;
// //   final Organisation? locationRegion;
// //   final String? inputDate;
// //   final int? status;
// //   final String? vendor;
// //   final String? region;
// //   final int? guardCount;
// //   final int? pvcExpired;
// //   final int? msgbExempted;
// //   final List<Label>? labels;
// //   final String? locationStr;
// //   final int? guardRank;
// //   final Function? onTap;
// //   final Function? onEditTap;
// //   final Function? onViewTap;
// //   final Function? onDeleteTap;
// //   final Function? onEmailTap;
// //   final Function? onLinkOffTap;
// //   final Function? onApproveTap;
// //   final int? incidentType;
// //   final bool isIncident;
// //   final Organisation? vendors;
// //   final int? workShift;
// //   final bool isWorkShift;
// //   final int? transportIncidentType;
// //   final Function? onLaunchTap;
// //
// //   // final Item userItem;
// //   final int? index;
// //
// //   final bool? showViewButton;
// //   final bool? showDeleteButton;
// //   final bool? showEmailButton;
// //   final bool? showLinkOffButton;
// //   final bool? showApproveButton;
// //   final bool isMasterGuard;
// //   final bool? isMasterGuardRank;
// //   final bool isEventProtectionStatus;
// //   final bool isOccurrenceStatus;
// //   final bool isSLAViolationStatus;
// //   final bool isContactDetailsStatus;
// //   final bool isSecuritySystemSLA;
// //   final bool isKeyLossStatus;
// //   final bool isKeyManagementStatus;
// //   final bool isKeyManagementIssuanceStatus;
// //   final bool isVipStatus;
// //   final bool isMaterialMovementStatus;
// //   final bool isKeyManagementHistoryStatus;
// //   final bool isShiftScheduleStatus;
// //   final bool isDutyPostNameMasterStatus;
// //   final bool isAttendanceStatus;
// //   final bool? showEditButton;
// //   final bool isPassManagementStatus;
// //   final bool isLawEnforcementStatus;
// //   final bool isArticleFoundStatus;
// //   final bool isTicketStatus;
// //   final bool isTransportStatus;
// //   final bool isCSREventProtectionStatus;
// //   final bool isPatrollingStatus;
// //   final bool isDutyPostMasterStatus;
// //   final bool? showLaunchButton;
// //   final bool isParkingStatus;
// //
// //   /// NEW (optional): which card design to use.
// //   final BaseTileVariant variant;
// //
// //   /// NEW (optional): only used by `BaseTileVariant.expandable`.
// //   final bool initiallyExpanded;
// //
// //   const BaseListTileItem({
// //     super.key,
// //     this.id,
// //     this.location,
// //     this.locationRegion,
// //     this.inputDate,
// //     this.status,
// //     this.onTap,
// //     this.onEditTap,
// //     this.showViewButton,
// //     this.onViewTap,
// //     this.onEmailTap,
// //     this.onLinkOffTap,
// //     this.onApproveTap,
// //     this.showApproveButton = false,
// //     this.index,
// //     this.region,
// //     this.vendor,
// //     this.guardCount,
// //     this.pvcExpired,
// //     this.msgbExempted,
// //     this.returnable,
// //     this.isIncident = false,
// //     this.locationStr,
// //     this.guardRank,
// //     this.labels,
// //     this.isMasterGuard = false,
// //     this.isMasterGuardRank = false,
// //     this.isEventProtectionStatus = true,
// //     this.isOccurrenceStatus = false,
// //     this.isSLAViolationStatus = false,
// //     this.incidentType,
// //     this.isContactDetailsStatus = false,
// //     this.isSecuritySystemSLA = false,
// //     this.isKeyLossStatus = false,
// //     this.isKeyManagementStatus = false,
// //     this.isKeyManagementIssuanceStatus = false,
// //     this.isVipStatus = false,
// //     this.isMaterialMovementStatus = false,
// //     this.onDeleteTap,
// //     this.isKeyManagementHistoryStatus = false,
// //     this.isDutyPostNameMasterStatus = false,
// //     this.isShiftScheduleStatus = false,
// //     this.isAttendanceStatus = false,
// //     this.vendors,
// //     this.showEditButton = false,
// //     this.showDeleteButton = true,
// //     this.showEmailButton = false,
// //     this.showLinkOffButton = false,
// //     this.isPassManagementStatus = false,
// //     this.isLawEnforcementStatus = false,
// //     this.isArticleFoundStatus = false,
// //     this.workShift,
// //     this.isWorkShift = false,
// //     this.isTicketStatus = false,
// //     this.isTransportStatus = false,
// //     this.isCSREventProtectionStatus = false,
// //     this.isPatrollingStatus = false,
// //     this.isDutyPostMasterStatus = false,
// //     this.transportIncidentType,
// //     this.showLaunchButton = false,
// //     this.isParkingStatus = false,
// //     this.onLaunchTap,
// //     this.variant = BaseTileVariant.classic,
// //     this.initiallyExpanded = false,
// //   });
// //
// //   @override
// //   State<BaseListTileItem> createState() => _BaseListTileItemState();
// // }
// //
// // class _BaseListTileItemState extends State<BaseListTileItem> {
// //   bool isHovered = true;
// //   late bool _expanded;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _expanded = widget.initiallyExpanded;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final details = _buildDetails();
// //     final statuses = _buildStatusWidgets();
// //     final isClassic = widget.variant == BaseTileVariant.classic;
// //     final iconOnly = !isClassic;
// //     final onDark = widget.variant == BaseTileVariant.dark;
// //
// //     // Classic: Edit moves beside the status, View is removed.
// //     final actions = _buildActions(
// //       iconOnly: iconOnly,
// //       onDark: onDark,
// //       includeEdit: !isClassic,
// //       includeView: !isClassic,
// //     );
// //
// //     Widget card;
// //     switch (widget.variant) {
// //       case BaseTileVariant.classic:
// //         card = _classicCard(details, statuses, actions);
// //         break;
// //       case BaseTileVariant.strip:
// //         card = _stripCard(details, statuses, actions);
// //         break;
// //       case BaseTileVariant.expandable:
// //         card = _expandableCard(details, statuses, actions);
// //         break;
// //       case BaseTileVariant.dark:
// //         card = _darkCard(details, statuses, actions);
// //         break;
// //     }
// //
// //     // Soft fade + slide-up when the card first appears
// //     return TweenAnimationBuilder<double>(
// //       tween: Tween(begin: 0, end: 1),
// //       duration: const Duration(milliseconds: 380),
// //       curve: Curves.easeOutCubic,
// //       builder: (context, t, child) => Opacity(
// //         opacity: t,
// //         child:
// //         Transform.translate(offset: Offset(0, 14 * (1 - t)), child: child),
// //       ),
// //       child: Padding(
// //         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
// //         child: card,
// //       ),
// //     );
// //   }
// //
// //   void _handleTap() {
// //     HapticFeedback.lightImpact();
// //     widget.onTap?.call(widget.index);
// //   }
// //
// //   BoxDecoration _cardDeco({double radius = 24, bool open = false}) {
// //     return BoxDecoration(
// //       color: Colors.white,
// //       borderRadius: BorderRadius.circular(radius),
// //       border: Border.all(
// //         color: open ? _ListTheme.goldBorder : _ListTheme.cardBorder,
// //         width: open ? 2.5 : 1,
// //       ),
// //       boxShadow: [
// //         BoxShadow(
// //           color: _ListTheme.navy.withValues(alpha: 0.09),
// //           blurRadius: 24,
// //           offset: const Offset(0, 10),
// //         ),
// //         BoxShadow(
// //           color: _ListTheme.gold.withValues(alpha: 0.08),
// //           blurRadius: 10,
// //           offset: const Offset(0, 2),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   // ===========================================================================
// //   // DESIGN 1: CLASSIC
// //   // ===========================================================================
// //   Widget _classicCard(
// //       List<MapEntry<String, String>> details,
// //       List<Widget> statuses,
// //       List<Widget> actions,
// //       ) {
// //     return Container(
// //       decoration: _cardDeco(),
// //       child: ClipRRect(
// //         borderRadius: BorderRadius.circular(23),
// //         child: Material(
// //           color: Colors.transparent,
// //           child: InkWell(
// //             onTap: _handleTap,
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.stretch,
// //               children: [
// //                 _buildHeader(),
// //                 if (details.isNotEmpty) _buildDetailsBlock(details),
// //                 if (actions.isNotEmpty)
// //                   _actionsRow(actions,
// //                       padding: const EdgeInsets.fromLTRB(16, 6, 16, 14)),
// //                 // Footer always shows: status on the left, Edit on the right
// //                 _buildStatusFooter(statuses),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildHeader() {
// //     final dateText = _dateText();
// //
// //     return Container(
// //       padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
// //       decoration: const BoxDecoration(
// //         gradient: LinearGradient(
// //           colors: [Colors.white, _ListTheme.pageBg],
// //           begin: Alignment.topCenter,
// //           end: Alignment.bottomCenter,
// //         ),
// //       ),
// //       child: Row(
// //         children: [
// //           _goldTile(size: 35, radius: 16),
// //           const SizedBox(width: 14),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const Text(
// //                   'ID',
// //                   style: TextStyle(
// //                     color: _ListTheme.gold,
// //                     fontSize: 11,
// //                     fontWeight: FontWeight.w900,
// //                     letterSpacing: 2.2,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 2),
// //                 Text(
// //                   '${widget.id ?? '-'}',
// //                   maxLines: 1,
// //                   overflow: TextOverflow.ellipsis,
// //                   style: const TextStyle(
// //                     color: _ListTheme.navy,
// //                     fontSize: 20,
// //                     fontWeight: FontWeight.w900,
// //                     height: 0.8,
// //                   ),
// //                 ),
// //                 if (widget.locationRegion != null) ...[
// //                   const SizedBox(height: 6),
// //                   _regionChip(),
// //                 ],
// //               ],
// //             ),
// //           ),
// //           Column(
// //             crossAxisAlignment: CrossAxisAlignment.end,
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               if (dateText != null) ...[
// //                 _datePill(dateText),
// //               ],
// //               if (widget.showViewButton ?? true)
// //                 Tooltip(
// //                   message: 'View',
// //                   child: InkWell(
// //                     customBorder: const CircleBorder(),
// //                     onTap: () {
// //                       HapticFeedback.lightImpact();
// //                       widget.onViewTap?.call(widget.index);
// //                     },
// //                     child: Container(
// //                       height: 30,
// //                       width: 30,
// //                       decoration: BoxDecoration(
// //                         shape: BoxShape.circle,
// //                         color: _ListTheme.actionBg,
// //                         border:
// //                         Border.all(color: _ListTheme.cardBorder, width: 1),
// //                       ),
// //                       child: const Icon(Icons.visibility_rounded,
// //                           size: 17, color: _ListTheme.gold),
// //                     ),
// //                   ),
// //                 ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildDetailsBlock(List<MapEntry<String, String>> details) {
// //     final rows = <Widget>[];
// //     for (int i = 0; i < details.length; i++) {
// //       rows.add(_detailRow(details[i].key, details[i].value));
// //       if (i != details.length - 1) {
// //         rows.add(const Padding(
// //           padding: EdgeInsets.only(left: 46),
// //           child: Divider(height: 1, thickness: 1, color: _ListTheme.divider),
// //         ));
// //       }
// //     }
// //     return Padding(
// //       padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
// //       child: Column(children: rows),
// //     );
// //   }
// //
// //   /// Classic detail row: icon | label ........ value  (label and value sit
// //   /// side by side in one row instead of stacked).
// //   Widget _detailRow(String label, String value) {
// //     final cleanLabel = _clean(label);
// //     final accent = _accentForLabel(cleanLabel);
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 10),
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //           Container(
// //             height: 34,
// //             width: 34,
// //             decoration: BoxDecoration(
// //               color: accent.tint,
// //               shape: BoxShape.circle,
// //             ),
// //             child: Icon(accent.icon, size: 19, color: accent.color),
// //           ),
// //           const SizedBox(width: 12),
// //           Expanded(
// //             flex: 5,
// //             child: Text(
// //               cleanLabel,
// //               softWrap: true,
// //               style: const TextStyle(
// //                 color: _ListTheme.labelGrey,
// //                 fontSize: 12,
// //                 fontWeight: FontWeight.w600,
// //                 letterSpacing: 0.2,
// //               ),
// //             ),
// //           ),
// //           const SizedBox(width: 8),
// //           Expanded(
// //             flex: 6,
// //             child: Text(
// //               value.isEmpty ? '-' : value,
// //               softWrap: true,
// //               textAlign: TextAlign.end,
// //               style: const TextStyle(
// //                 color: _ListTheme.navy,
// //                 fontSize: 14,
// //                 fontWeight: FontWeight.w800,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   /// Status on the left, Edit button beside it on the right.
// //   Widget _buildStatusFooter(List<Widget> statuses) {
// //     final showEdit = widget.onEditTap != null || (widget.showEditButton ?? false);
// //
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.stretch,
// //       children: [
// //         Container(
// //           height: 3,
// //           decoration: const BoxDecoration(
// //             gradient: LinearGradient(
// //               colors: [
// //                 _ListTheme.gold,
// //                 _ListTheme.goldLight,
// //                 _ListTheme.gold,
// //               ],
// //             ),
// //           ),
// //         ),
// //         Container(
// //           padding: const EdgeInsets.fromLTRB(18, 14, 14, 6),
// //           decoration: const BoxDecoration(
// //             gradient: LinearGradient(
// //               colors: [_ListTheme.navyMid, _ListTheme.navyDark],
// //               begin: Alignment.topLeft,
// //               end: Alignment.bottomRight,
// //             ),
// //           ),
// //           child: Row(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: statuses,
// //                 ),
// //               ),
// //               if (showEdit)
// //                 Padding(
// //                   padding: const EdgeInsets.only(left: 10, bottom: 8),
// //                   child: _editButton(onDark: true),
// //                 ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _editButton({bool onDark = false}) {
// //     return _actionPill(
// //       icon: (widget.showEditButton ?? true)
// //           ? Icons.edit_rounded
// //           : Icons.edit_off_outlined,
// //       label: 'Edit',
// //       color: onDark ? _ListTheme.goldLight : _ListTheme.gold,
// //       onDark: onDark,
// //       onPressed: () {
// //         widget.onEditTap?.call(widget.index);
// //       },
// //     );
// //   }
// //
// //   // ===========================================================================
// //   // DESIGN 2: STRIP (gold-to-teal accent strip, 2-column chips)
// //   // ===========================================================================
// //   Widget _stripCard(
// //       List<MapEntry<String, String>> details,
// //       List<Widget> statuses,
// //       List<Widget> actions,
// //       ) {
// //     final dateText = _dateText();
// //
// //     return Container(
// //       decoration: _cardDeco(radius: 22),
// //       child: ClipRRect(
// //         borderRadius: BorderRadius.circular(21),
// //         child: Material(
// //           color: Colors.transparent,
// //           child: InkWell(
// //             onTap: _handleTap,
// //             child: Stack(
// //               children: [
// //                 const Positioned(
// //                   left: 0,
// //                   top: 0,
// //                   bottom: 0,
// //                   width: 6,
// //                   child: DecoratedBox(
// //                     decoration: BoxDecoration(
// //                       gradient: LinearGradient(
// //                         colors: [_ListTheme.gold, _ListTheme.teal],
// //                         begin: Alignment.topCenter,
// //                         end: Alignment.bottomCenter,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 Padding(
// //                   padding: const EdgeInsets.fromLTRB(22, 16, 16, 14),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Row(
// //                         children: [
// //                           _goldTile(size: 46, radius: 14),
// //                           const SizedBox(width: 12),
// //                           Expanded(
// //                             child: Column(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 const Text(
// //                                   'ID',
// //                                   style: TextStyle(
// //                                     color: _ListTheme.gold,
// //                                     fontSize: 10.5,
// //                                     fontWeight: FontWeight.w800,
// //                                     letterSpacing: 2,
// //                                   ),
// //                                 ),
// //                                 Text(
// //                                   '${widget.id ?? '-'}',
// //                                   maxLines: 1,
// //                                   overflow: TextOverflow.ellipsis,
// //                                   style: const TextStyle(
// //                                     color: _ListTheme.navy,
// //                                     fontSize: 22,
// //                                     fontWeight: FontWeight.w900,
// //                                     height: 1.1,
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                           if (dateText != null) _datePill(dateText),
// //                         ],
// //                       ),
// //                       if (details.isNotEmpty) ...[
// //                         const SizedBox(height: 14),
// //                         LayoutBuilder(
// //                           builder: (context, c) {
// //                             final half = (c.maxWidth - 10) / 2;
// //                             return Wrap(
// //                               spacing: 10,
// //                               runSpacing: 10,
// //                               children: details
// //                                   .map((e) => SizedBox(
// //                                 width: details.length == 1
// //                                     ? c.maxWidth
// //                                     : half,
// //                                 child: _detailChip(e.key, e.value),
// //                               ))
// //                                   .toList(),
// //                             );
// //                           },
// //                         ),
// //                       ],
// //                       if (statuses.isNotEmpty) ...[
// //                         const SizedBox(height: 14),
// //                         _statusBand(statuses, radius: 16),
// //                       ],
// //                       if (actions.isNotEmpty) ...[
// //                         const SizedBox(height: 12),
// //                         Align(
// //                           alignment: Alignment.centerRight,
// //                           child: Wrap(
// //                             spacing: 10,
// //                             runSpacing: 10,
// //                             alignment: WrapAlignment.end,
// //                             children: actions,
// //                           ),
// //                         ),
// //                       ],
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _detailChip(String label, String value) {
// //     final cleanLabel = _clean(label);
// //     final accent = _accentForLabel(cleanLabel);
// //     return Container(
// //       padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
// //       decoration: BoxDecoration(
// //         color: accent.tint.withValues(alpha: 0.55),
// //         borderRadius: BorderRadius.circular(16),
// //       ),
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Container(
// //             height: 30,
// //             width: 30,
// //             decoration: const BoxDecoration(
// //               color: Colors.white,
// //               shape: BoxShape.circle,
// //             ),
// //             child: Icon(accent.icon, size: 16, color: accent.color),
// //           ),
// //           const SizedBox(width: 8),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   cleanLabel,
// //                   style: const TextStyle(
// //                     color: _ListTheme.labelGrey,
// //                     fontSize: 11,
// //                     fontWeight: FontWeight.w600,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 2),
// //                 Text(
// //                   value.isEmpty ? '-' : value,
// //                   style: const TextStyle(
// //                     color: _ListTheme.navy,
// //                     fontSize: 13.5,
// //                     fontWeight: FontWeight.w800,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   // ===========================================================================
// //   // DESIGN 3: EXPANDABLE (collapsed summary, chevron opens the details)
// //   // ===========================================================================
// //   Widget _expandableCard(
// //       List<MapEntry<String, String>> details,
// //       List<Widget> statuses,
// //       List<Widget> actions,
// //       ) {
// //     final hasDetails = details.isNotEmpty;
// //     final chipText = widget.locationRegion?.name ??
// //         (hasDetails ? '${details.length} details' : null);
// //
// //     return AnimatedContainer(
// //       duration: const Duration(milliseconds: 250),
// //       curve: Curves.easeOut,
// //       decoration: _cardDeco(radius: 26, open: _expanded),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.stretch,
// //         children: [
// //           InkWell(
// //             borderRadius: BorderRadius.circular(26),
// //             onTap: () {
// //               HapticFeedback.lightImpact();
// //               if (widget.onTap != null) {
// //                 widget.onTap!(widget.index);
// //               } else if (hasDetails) {
// //                 setState(() => _expanded = !_expanded);
// //               }
// //             },
// //             child: Padding(
// //               padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
// //               child: Row(
// //                 children: [
// //                   _goldTile(size: 58, radius: 18, glow: _expanded),
// //                   const SizedBox(width: 16),
// //                   Expanded(
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           'ID : ${widget.id ?? '-'}',
// //                           maxLines: 1,
// //                           overflow: TextOverflow.ellipsis,
// //                           style: const TextStyle(
// //                             color: _ListTheme.navy,
// //                             fontSize: 20,
// //                             fontWeight: FontWeight.w800,
// //                           ),
// //                         ),
// //                         if (chipText != null && chipText.isNotEmpty) ...[
// //                           const SizedBox(height: 6),
// //                           Container(
// //                             padding: const EdgeInsets.symmetric(
// //                                 horizontal: 10, vertical: 3),
// //                             decoration: BoxDecoration(
// //                               color: _ListTheme.chipBg,
// //                               borderRadius: BorderRadius.circular(20),
// //                             ),
// //                             child: Text(
// //                               chipText,
// //                               maxLines: 1,
// //                               overflow: TextOverflow.ellipsis,
// //                               style: const TextStyle(
// //                                 color: _ListTheme.gold,
// //                                 fontSize: 12,
// //                                 fontWeight: FontWeight.w700,
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ],
// //                     ),
// //                   ),
// //                   if (hasDetails) ...[
// //                     const SizedBox(width: 10),
// //                     GestureDetector(
// //                       behavior: HitTestBehavior.opaque,
// //                       onTap: () {
// //                         HapticFeedback.selectionClick();
// //                         setState(() => _expanded = !_expanded);
// //                       },
// //                       child: AnimatedContainer(
// //                         duration: const Duration(milliseconds: 250),
// //                         height: 40,
// //                         width: 40,
// //                         decoration: BoxDecoration(
// //                           shape: BoxShape.circle,
// //                           color: _expanded
// //                               ? _ListTheme.gold
// //                               : _ListTheme.actionBg,
// //                         ),
// //                         child: Icon(
// //                           _expanded
// //                               ? Icons.keyboard_arrow_up_rounded
// //                               : Icons.keyboard_arrow_down_rounded,
// //                           size: 24,
// //                           color: _expanded ? Colors.white : _ListTheme.gold,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ],
// //               ),
// //             ),
// //           ),
// //           AnimatedSize(
// //             duration: const Duration(milliseconds: 250),
// //             curve: Curves.easeOut,
// //             alignment: Alignment.topCenter,
// //             child: (_expanded && hasDetails)
// //                 ? Padding(
// //               padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
// //               child: Column(
// //                 children: details
// //                     .map((e) => _detailPill(e.key, e.value))
// //                     .toList(),
// //               ),
// //             )
// //                 : const SizedBox(width: double.infinity),
// //           ),
// //           if (statuses.isNotEmpty)
// //             Padding(
// //               padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
// //               child: _statusBand(statuses, radius: 20),
// //             ),
// //           if (actions.isNotEmpty)
// //             _actionsRow(actions,
// //                 padding: const EdgeInsets.fromLTRB(16, 12, 16, 14))
// //           else
// //             const SizedBox(height: 14),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _detailPill(String label, String value) {
// //     final cleanLabel = _clean(label);
// //     final accent = _accentForLabel(cleanLabel);
// //     return Container(
// //       margin: const EdgeInsets.only(top: 10),
// //       padding: const EdgeInsets.fromLTRB(12, 10, 16, 10),
// //       decoration: BoxDecoration(
// //         color: _ListTheme.pageBg,
// //         borderRadius: BorderRadius.circular(20),
// //         border: Border.all(color: _ListTheme.cardBorder, width: 1),
// //       ),
// //       child: Row(
// //         children: [
// //           Container(
// //             height: 42,
// //             width: 42,
// //             decoration: BoxDecoration(
// //               shape: BoxShape.circle,
// //               color: accent.tint,
// //             ),
// //             child: Icon(accent.icon, size: 20, color: accent.color),
// //           ),
// //           const SizedBox(width: 14),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   cleanLabel,
// //                   style: const TextStyle(
// //                     color: _ListTheme.labelGrey,
// //                     fontSize: 12,
// //                     fontWeight: FontWeight.w600,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 2),
// //                 Text(
// //                   value.isEmpty ? '-' : value,
// //                   style: const TextStyle(
// //                     color: _ListTheme.navy,
// //                     fontSize: 15.5,
// //                     fontWeight: FontWeight.w700,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   // ===========================================================================
// //   // DESIGN 4: DARK (navy card, gold border, glass detail rows)
// //   // ===========================================================================
// //   Widget _darkCard(
// //       List<MapEntry<String, String>> details,
// //       List<Widget> statuses,
// //       List<Widget> actions,
// //       ) {
// //     final dateText = _dateText();
// //
// //     return Container(
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(24),
// //         gradient: const LinearGradient(
// //           colors: [_ListTheme.navyMid, _ListTheme.navyDark],
// //           begin: Alignment.topLeft,
// //           end: Alignment.bottomRight,
// //         ),
// //         border: Border.all(
// //           color: _ListTheme.goldBorder.withValues(alpha: 0.65),
// //           width: 1.2,
// //         ),
// //         boxShadow: [
// //           BoxShadow(
// //             color: _ListTheme.navy.withValues(alpha: 0.35),
// //             blurRadius: 24,
// //             offset: const Offset(0, 12),
// //           ),
// //         ],
// //       ),
// //       child: ClipRRect(
// //         borderRadius: BorderRadius.circular(23),
// //         child: Material(
// //           color: Colors.transparent,
// //           child: InkWell(
// //             onTap: _handleTap,
// //             child: Padding(
// //               padding: const EdgeInsets.all(16),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.stretch,
// //                 children: [
// //                   Row(
// //                     children: [
// //                       _goldTile(size: 50, radius: 15),
// //                       const SizedBox(width: 14),
// //                       Expanded(
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             const Text(
// //                               'ID',
// //                               style: TextStyle(
// //                                 color: _ListTheme.goldLight,
// //                                 fontSize: 11,
// //                                 fontWeight: FontWeight.w800,
// //                                 letterSpacing: 2.2,
// //                               ),
// //                             ),
// //                             Text(
// //                               '${widget.id ?? '-'}',
// //                               maxLines: 1,
// //                               overflow: TextOverflow.ellipsis,
// //                               style: const TextStyle(
// //                                 color: Colors.white,
// //                                 fontSize: 24,
// //                                 fontWeight: FontWeight.w900,
// //                                 height: 1.1,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       if (dateText != null)
// //                         _datePill(dateText, onDark: true),
// //                     ],
// //                   ),
// //                   if (details.isNotEmpty) ...[
// //                     const SizedBox(height: 6),
// //                     ...details.map((e) => _darkDetail(e.key, e.value)),
// //                   ],
// //                   if (statuses.isNotEmpty) ...[
// //                     const SizedBox(height: 14),
// //                     Divider(
// //                       height: 1,
// //                       thickness: 1,
// //                       color: _ListTheme.goldLight.withValues(alpha: 0.25),
// //                     ),
// //                     const SizedBox(height: 12),
// //                     Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: statuses,
// //                     ),
// //                   ],
// //                   if (actions.isNotEmpty) ...[
// //                     const SizedBox(height: 4),
// //                     Align(
// //                       alignment: Alignment.centerRight,
// //                       child: Wrap(
// //                         spacing: 10,
// //                         runSpacing: 10,
// //                         alignment: WrapAlignment.end,
// //                         children: actions,
// //                       ),
// //                     ),
// //                   ],
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _darkDetail(String label, String value) {
// //     final cleanLabel = _clean(label);
// //     final accent = _accentForLabel(cleanLabel);
// //     final light = Color.lerp(accent.color, Colors.white, 0.35)!;
// //     return Container(
// //       margin: const EdgeInsets.only(top: 10),
// //       padding: const EdgeInsets.fromLTRB(10, 10, 14, 10),
// //       decoration: BoxDecoration(
// //         color: Colors.white.withValues(alpha: 0.07),
// //         borderRadius: BorderRadius.circular(18),
// //         border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
// //       ),
// //       child: Row(
// //         children: [
// //           Container(
// //             height: 38,
// //             width: 38,
// //             decoration: BoxDecoration(
// //               shape: BoxShape.circle,
// //               color: accent.color.withValues(alpha: 0.2),
// //             ),
// //             child: Icon(accent.icon, size: 19, color: light),
// //           ),
// //           const SizedBox(width: 12),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   cleanLabel,
// //                   style: const TextStyle(
// //                     color: Color(0xFFB9B4E0),
// //                     fontSize: 11.5,
// //                     fontWeight: FontWeight.w600,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 2),
// //                 Text(
// //                   value.isEmpty ? '-' : value,
// //                   style: const TextStyle(
// //                     color: Colors.white,
// //                     fontSize: 15,
// //                     fontWeight: FontWeight.w700,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   // ===========================================================================
// //   // SHARED PIECES
// //   // ===========================================================================
// //   String _clean(String label) =>
// //       label.replaceAll(RegExp(r'\s*:\s*$'), '').trim();
// //
// //   String? _dateText() {
// //     final ts = int.tryParse(widget.inputDate ?? '');
// //     if (ts == null) return null;
// //     final t = Utils.timestampToDateConversion(ts, Constants.dateFormat);
// //     return (t.isEmpty) ? null : t;
// //   }
// //
// //   Widget _goldTile({
// //     required double size,
// //     required double radius,
// //     bool glow = true,
// //   }) {
// //     return Container(
// //       height: size,
// //       width: size,
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(radius),
// //         gradient: const LinearGradient(
// //           colors: [_ListTheme.goldLight, _ListTheme.gold],
// //           begin: Alignment.topLeft,
// //           end: Alignment.bottomRight,
// //         ),
// //         border: Border.all(
// //           color: Colors.white.withValues(alpha: 0.8),
// //           width: 1.2,
// //         ),
// //         boxShadow: glow
// //             ? [
// //           BoxShadow(
// //             color: _ListTheme.gold.withValues(alpha: 0.45),
// //             blurRadius: 14,
// //             offset: const Offset(0, 6),
// //           ),
// //         ]
// //             : null,
// //       ),
// //       child: Icon(Icons.assignment_rounded,
// //           color: Colors.white, size: size * 0.48),
// //     );
// //   }
// //
// //   Widget _regionChip() {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
// //       decoration: BoxDecoration(
// //         color: _ListTheme.chipBg,
// //         borderRadius: BorderRadius.circular(20),
// //       ),
// //       child: Row(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           const Icon(Icons.public_rounded, size: 13, color: _ListTheme.gold),
// //           const SizedBox(width: 5),
// //           Flexible(
// //             child: Text(
// //               widget.locationRegion?.name ?? '',
// //               maxLines: 1,
// //               overflow: TextOverflow.ellipsis,
// //               style: const TextStyle(
// //                 color: _ListTheme.gold,
// //                 fontSize: 12,
// //                 fontWeight: FontWeight.w700,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _datePill(String text, {bool onDark = false}) {
// //     final fg = onDark ? _ListTheme.goldLight : _ListTheme.labelGrey;
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
// //       decoration: BoxDecoration(
// //         color: onDark ? Colors.white.withValues(alpha: 0.1) : Colors.white,
// //         borderRadius: BorderRadius.circular(20),
// //         border: Border.all(
// //           color: onDark
// //               ? Colors.white.withValues(alpha: 0.25)
// //               : _ListTheme.cardBorder,
// //           width: 1,
// //         ),
// //       ),
// //       child: Row(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           Icon(Icons.calendar_today_rounded, size: 12, color: fg),
// //           const SizedBox(width: 5),
// //           Text(
// //             text,
// //             style: TextStyle(
// //               color: fg,
// //               fontSize: 11.5,
// //               fontWeight: FontWeight.w700,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _statusBand(List<Widget> statuses, {double radius = 16}) {
// //     return Container(
// //       padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(radius),
// //         gradient: const LinearGradient(
// //           colors: [_ListTheme.navyMid, _ListTheme.navyDark],
// //           begin: Alignment.topLeft,
// //           end: Alignment.bottomRight,
// //         ),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: statuses,
// //       ),
// //     );
// //   }
// //
// //   Widget _statusItem(Widget child, {bool expand = false}) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 8),
// //       child: expand
// //           ? Row(children: [Expanded(child: child)])
// //           : Align(alignment: Alignment.centerLeft, child: child),
// //     );
// //   }
// //
// //   Widget _actionsRow(List<Widget> actions, {required EdgeInsets padding}) {
// //     return Padding(
// //       padding: padding,
// //       child: Wrap(
// //         spacing: 10,
// //         runSpacing: 10,
// //         alignment: WrapAlignment.end,
// //         children: actions,
// //       ),
// //     );
// //   }
// //
// //   ({IconData icon, Color color, Color tint}) _accentForLabel(String label) {
// //     final l = label.toLowerCase();
// //     if (l.contains('date') || l.contains('time') || l.contains('valid')) {
// //       return (
// //       icon: Icons.calendar_month_rounded,
// //       color: _ListTheme.amber,
// //       tint: _ListTheme.amberTint
// //       );
// //     }
// //     if (l.contains('location') || l.contains('region') || l.contains('area')) {
// //       return (
// //       icon: Icons.location_on_rounded,
// //       color: _ListTheme.teal,
// //       tint: _ListTheme.tealTint
// //       );
// //     }
// //     if (l.contains('created') ||
// //         l.contains('by') ||
// //         l.contains('name') ||
// //         l.contains('manager') ||
// //         l.contains('guard')) {
// //       return (
// //       icon: Icons.person_rounded,
// //       color: _ListTheme.violet,
// //       tint: _ListTheme.violetTint
// //       );
// //     }
// //     if (l.contains('vendor') || l.contains('company') || l.contains('dept')) {
// //       return (
// //       icon: Icons.business_rounded,
// //       color: _ListTheme.blue,
// //       tint: _ListTheme.blueTint
// //       );
// //     }
// //     return (
// //     icon: Icons.tag_rounded,
// //     color: _ListTheme.gold,
// //     tint: _ListTheme.chipBg
// //     );
// //   }
// //
// //   // ---------------------------------------------------------------------------
// //   // ACTION BUTTONS (pill with label for classic, round icon for the others)
// //   // ---------------------------------------------------------------------------
// //   Widget _actionPill({
// //     required IconData icon,
// //     required String label,
// //     required VoidCallback onPressed,
// //     Color? color,
// //     bool primary = false,
// //     bool iconOnly = false,
// //     bool onDark = false,
// //   }) {
// //     final Color fg = primary
// //         ? Colors.white
// //         : (color ?? (onDark ? Colors.white : _ListTheme.navy));
// //
// //     final decoration = BoxDecoration(
// //       shape: iconOnly ? BoxShape.circle : BoxShape.rectangle,
// //       borderRadius: iconOnly ? null : BorderRadius.circular(30),
// //       gradient: primary
// //           ? LinearGradient(
// //         colors: onDark
// //             ? const [_ListTheme.goldLight, _ListTheme.gold]
// //             : const [_ListTheme.navyMid, _ListTheme.navyDark],
// //       )
// //           : null,
// //       color: primary
// //           ? null
// //           : (onDark
// //           ? Colors.white.withValues(alpha: 0.1)
// //           : _ListTheme.actionBg),
// //       border: primary
// //           ? null
// //           : Border.all(
// //         color: onDark
// //             ? Colors.white.withValues(alpha: 0.25)
// //             : _ListTheme.cardBorder,
// //         width: 1,
// //       ),
// //       boxShadow: primary
// //           ? [
// //         BoxShadow(
// //           color: (onDark ? _ListTheme.gold : _ListTheme.navy)
// //               .withValues(alpha: 0.3),
// //           blurRadius: 10,
// //           offset: const Offset(0, 4),
// //         ),
// //       ]
// //           : null,
// //     );
// //
// //     final button = Material(
// //       color: Colors.transparent,
// //       child: InkWell(
// //         onTap: onPressed,
// //         customBorder: iconOnly ? const CircleBorder() : null,
// //         borderRadius: iconOnly ? null : BorderRadius.circular(30),
// //         child: Ink(
// //           decoration: decoration,
// //           child: iconOnly
// //               ? SizedBox(
// //             height: 40,
// //             width: 40,
// //             child: Icon(icon, size: 19, color: fg),
// //           )
// //               : Padding(
// //             padding:
// //             const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
// //             child: Row(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Icon(icon, size: 17, color: fg),
// //                 const SizedBox(width: 6),
// //                 Text(
// //                   label,
// //                   style: TextStyle(
// //                     color: fg,
// //                     fontSize: 13,
// //                     fontWeight: FontWeight.w700,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //
// //     return iconOnly ? Tooltip(message: label, child: button) : button;
// //   }
// //
// //   List<Widget> _buildActions({
// //     bool iconOnly = false,
// //     bool onDark = false,
// //     bool includeEdit = true,
// //     bool includeView = true,
// //   }) {
// //     final a = <Widget>[];
// //
// //     void add(
// //         IconData icon,
// //         String label,
// //         Function? cb, {
// //           Color? color,
// //           bool primary = false,
// //         }) {
// //       a.add(_actionPill(
// //         icon: icon,
// //         label: label,
// //         color: color,
// //         primary: primary,
// //         iconOnly: iconOnly,
// //         onDark: onDark,
// //         onPressed: () {
// //           cb != null ? cb(widget.index) : null;
// //         },
// //       ));
// //     }
// //
// //     if (includeEdit) {
// //       add(
// //         (widget.showEditButton ?? true)
// //             ? Icons.edit_rounded
// //             : Icons.edit_off_outlined,
// //         'Edit',
// //         widget.onEditTap,
// //         color: onDark ? _ListTheme.goldLight : _ListTheme.gold,
// //       );
// //     }
// //
// //     if (includeView && (widget.showViewButton ?? true)) {
// //       add(
// //         iconOnly ? Icons.arrow_forward_rounded : Icons.visibility_rounded,
// //         'View',
// //         widget.onViewTap,
// //         primary: true,
// //       );
// //     }
// //
// //     if (widget.isSecuritySystemSLA == true && widget.status == 2 ||
// //         widget.status == 3 ||
// //         widget.status == 4 ||
// //         widget.status == 5 ||
// //         widget.status == 8 ||
// //         widget.status == 10 ||
// //         widget.status == 12) {
// //       if (widget.showEmailButton ?? true) {
// //         add(Icons.email_rounded, 'Email', widget.onEmailTap,
// //             color: onDark ? const Color(0xFF8EC3FF) : const Color(0xFF0C4C99));
// //       }
// //     }
// //
// //     if (widget.showLinkOffButton ?? true) {
// //       add(Icons.link_off_rounded, 'Unlink', widget.onLinkOffTap);
// //     }
// //
// //     if (widget.showLaunchButton ?? true) {
// //       add(Icons.rocket_launch_rounded, 'Launch', widget.onLaunchTap,
// //           color: onDark ? _ListTheme.goldLight : _ListTheme.gold);
// //     }
// //
// //     if ((widget.showDeleteButton ?? true) && widget.onDeleteTap != null) {
// //       add(Icons.delete_rounded, 'Delete', widget.onDeleteTap,
// //           color: onDark ? const Color(0xFFFF8E8E) : const Color(0xFFD64545));
// //     }
// //
// //     if (widget.showApproveButton ?? true) {
// //       add(Icons.approval_rounded, 'Approve', widget.onApproveTap);
// //     }
// //
// //     return a;
// //   }
// //
// //   // ---------------------------------------------------------------------------
// //   // DATA: label / value rows
// //   // ---------------------------------------------------------------------------
// //   List<MapEntry<String, String>> _buildDetails() {
// //     final d = <MapEntry<String, String>>[];
// //
// //     void add(String label, Object? value) {
// //       if (value == null) return;
// //       d.add(MapEntry(label, value.toString()));
// //     }
// //
// //     if (widget.location != null) {
// //       add('Location : ', widget.location?.name ?? '');
// //     }
// //     if (widget.locationStr != null) add('Location : ', widget.locationStr);
// //     if (widget.vendors != null) add('Vendor : ', widget.vendors?.name ?? '');
// //     if (widget.guardCount != null) add('Guard Count : ', widget.guardCount);
// //     if (widget.pvcExpired != null) {
// //       add('Staff PVC Expired : ', widget.pvcExpired);
// //     }
// //     if (widget.vendor != null) add('Vendor : ', widget.vendor);
// //
// //     for (Label label in widget.labels ?? []) {
// //       if (label.value == 'null' || label.value.isEmpty) continue;
// //       d.add(MapEntry('${label.key} : ', label.value));
// //     }
// //     return d;
// //   }
// //
// //   // ---------------------------------------------------------------------------
// //   // DATA: status widgets (built by Utils())
// //   // ---------------------------------------------------------------------------
// //   List<Widget> _buildStatusWidgets() {
// //     final w = <Widget>[];
// //     final s = widget.status;
// //
// //     if (widget.guardRank != -1 && widget.isMasterGuardRank == true) {
// //       w.add(_statusItem(
// //           Utils().buildGuardRank(guardRank: widget.guardRank ?? 0)));
// //     }
// //     if (widget.workShift != -1 && widget.isWorkShift == true) {
// //       w.add(_statusItem(
// //           Utils().buildWorkShift(workShift: widget.workShift ?? 0)));
// //     }
// //     if (widget.incidentType != null) {
// //       w.add(_statusItem(Utils().incidentType(widget.incidentType ?? 0)));
// //     }
// //     if (widget.transportIncidentType != null) {
// //       w.add(_statusItem(
// //           Utils().transportIncidentType(widget.transportIncidentType ?? 0)));
// //     }
// //     if (s != null &&
// //         widget.isArticleFoundStatus == true &&
// //         !widget.isShiftScheduleStatus) {
// //       w.add(_statusItem(Utils().buildFoundStatusRow(s)));
// //     }
// //     if (s != null && widget.isEventProtectionStatus && !widget.isMasterGuard) {
// //       w.add(_statusItem(Utils().buildEventProtectionStatusRow(s)));
// //     }
// //     if (s != null &&
// //         widget.isCSREventProtectionStatus &&
// //         !widget.isMasterGuard) {
// //       w.add(_statusItem(Utils().buildCSRProtectionStatusRow(s)));
// //     }
// //     if (s != null && widget.isIncident == true) {
// //       w.add(_statusItem(Utils().buildIncidentStatus(s)));
// //     }
// //     if (s != null &&
// //         widget.isLawEnforcementStatus == true &&
// //         !widget.isShiftScheduleStatus) {
// //       w.add(_statusItem(Utils().buildLeoStatusRow(s)));
// //     }
// //     if (s != null &&
// //         widget.isMaterialMovementStatus == true &&
// //         !widget.isMasterGuard) {
// //       w.add(_statusItem(Utils().buildMaterialMovementStatusRow(s),
// //           expand: true));
// //     }
// //     if (s != 0 && widget.isMasterGuard) {
// //       w.add(_statusItem(Utils().buildMasterDataStatusRow(s ?? 0)));
// //     }
// //     if (s != null && widget.isKeyManagementIssuanceStatus) {
// //       w.add(_statusItem(Utils().keyManagementIssuanceStatus(s),
// //           expand: true));
// //     }
// //     if (s != null && widget.isPatrollingStatus) {
// //       w.add(_statusItem(Utils().patrollingStatus(s), expand: true));
// //     }
// //     if (s != null && widget.isParkingStatus) {
// //       w.add(_statusItem(Utils().parkingStatus(s), expand: true));
// //     }
// //     if (s != null && widget.isAttendanceStatus == true) {
// //       w.add(_statusItem(Utils().buildAttendanceStatusRow(s)));
// //     }
// //     if (s != null && widget.isKeyManagementStatus) {
// //       w.add(_statusItem(Utils().keyManagementStatus(s)));
// //     }
// //     if (s != null && widget.isKeyManagementHistoryStatus) {
// //       w.add(_statusItem(Utils().keyManagementMasterHistoryStatus(s)));
// //     }
// //     if (s != null && widget.isOccurrenceStatus == true) {
// //       w.add(_statusItem(Utils().buildOccurrenceStatus(s)));
// //     }
// //     if (s != null && widget.isKeyLossStatus == true) {
// //       w.add(_statusItem(Utils().keyLossDestructionStatus(s)));
// //     }
// //     if (s != null && widget.isSLAViolationStatus == true) {
// //       w.add(_statusItem(Utils().buildSLAViolationStatus(s)));
// //     }
// //     if (s != null &&
// //         widget.isContactDetailsStatus == true &&
// //         widget.isEventProtectionStatus == false) {
// //       w.add(_statusItem(Utils().contactDetailsStatus(s)));
// //     }
// //     if (s != null &&
// //         widget.isEventProtectionStatus == false &&
// //         widget.isSecuritySystemSLA == true) {
// //       w.add(_statusItem(Utils().buildSecuritySystemStatusRow(s)));
// //     }
// //     if (widget.isVipStatus == true) {
// //       w.add(_statusItem(Utils().vIPVisitorStatusRow(s ?? 0)));
// //     }
// //     if (s != null && widget.isShiftScheduleStatus == true) {
// //       w.add(_statusItem(Utils().shiftScheduleStatusRow(s)));
// //     }
// //     if (s != null && widget.isTransportStatus == true) {
// //       w.add(_statusItem(Utils().transportMedicalStatus(s)));
// //     }
// //     if (s != null && widget.isDutyPostNameMasterStatus == true) {
// //       w.add(_statusItem(Utils().dutyPostNameMasterStatus(s)));
// //     }
// //     if (s != null && widget.isDutyPostMasterStatus == true) {
// //       w.add(_statusItem(Utils().dutyPostMasterStatus(s)));
// //     }
// //     if (s != null &&
// //         widget.isPassManagementStatus == true &&
// //         !widget.isShiftScheduleStatus) {
// //       w.add(_statusItem(Utils().buildPassManagementStatusRow(s)));
// //     }
// //     if (s != null && widget.isTicketStatus) {
// //       w.add(_statusItem(Utils().buildTicketStatusRow(s)));
// //     }
// //
// //     return w;
// //   }
// // }
// //
// // class Label {
// //   final String key;
// //   final String value;
// //
// //   const Label({
// //     required this.key,
// //     required this.value,
// //   });
// // }
import 'package:db_atom/index.dart';

/// Card designs. Pick one per screen with `variant:`.
enum BaseTileVariant {
  classic, // header + detail rows + status footer (with Edit beside status)
  strip, // accent strip, 2-column detail chips
  expandable, // collapsed summary, tap chevron to open
  dark, // navy card with gold accents
}

class _ListTheme {
  static const Color navy = Color(0xFF14086B);
  static const Color navyDark = Color(0xFF0B0450);
  static const Color navyMid = Color(0xFF1E0F8A);
  static const Color gold = Color(0xFFB8895A);
  static const Color goldLight = Color(0xFFE6CFB0);
  static const Color goldBorder = Color(0xFFC9A98A);
  static const Color pageBg = Color(0xFFFBF7F0);
  static const Color cardBorder = Color(0xFFE8DFD0);
  static const Color divider = Color(0xFFF1EBE0);
  static const Color chipBg = Color(0xFFF5EEE7);
  static const Color labelGrey = Color(0xFF8A8499);
  static const Color actionBg = Color(0xFFFBF3E6);
  static const Color iconTint = Color(0xFFEEEBFA);

  // Accent colours for detail icons
  static const Color amber = Color(0xFFD98E2B);
  static const Color amberTint = Color(0xFFFDF0DA);
  static const Color teal = Color(0xFF1F9488);
  static const Color tealTint = Color(0xFFE0F3F0);
  static const Color violet = Color(0xFF7D5BB5);
  static const Color violetTint = Color(0xFFEFE8F8);
  static const Color blue = Color(0xFF2F6DB5);
  static const Color blueTint = Color(0xFFE3EEF9);
}

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
  final Function? onApproveTap;
  final int? incidentType;
  final bool isIncident;
  final Organisation? vendors;
  final int? workShift;
  final bool isWorkShift;
  final int? transportIncidentType;
  final Function? onLaunchTap;

  // final Item userItem;
  final int? index;

  final bool? showViewButton;
  final bool? showDeleteButton;
  final bool? showEmailButton;
  final bool? showLinkOffButton;
  final bool? showApproveButton;
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
  final bool isTicketStatus;
  final bool isTransportStatus;
  final bool isCSREventProtectionStatus;
  final bool isPatrollingStatus;
  final bool isDutyPostMasterStatus;
  final bool? showLaunchButton;
  final bool isParkingStatus;

  /// NEW (optional): which card design to use.
  final BaseTileVariant variant;

  /// NEW (optional): only used by `BaseTileVariant.expandable`.
  final bool initiallyExpanded;

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
    this.onApproveTap,
    this.showApproveButton = false,
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
    this.isMasterGuardRank = false,
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
    this.workShift,
    this.isWorkShift = false,
    this.isTicketStatus = false,
    this.isTransportStatus = false,
    this.isCSREventProtectionStatus = false,
    this.isPatrollingStatus = false,
    this.isDutyPostMasterStatus = false,
    this.transportIncidentType,
    this.showLaunchButton = false,
    this.isParkingStatus = false,
    this.onLaunchTap,
    this.variant = BaseTileVariant.classic,
    this.initiallyExpanded = false,
  });

  @override
  State<BaseListTileItem> createState() => _BaseListTileItemState();
}

class _BaseListTileItemState extends State<BaseListTileItem> {
  bool isHovered = true;
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final details = _buildDetails();
    final statuses = _buildStatusWidgets();
    final isClassic = widget.variant == BaseTileVariant.classic;
    final iconOnly = !isClassic;
    final onDark = widget.variant == BaseTileVariant.dark;

    // Classic: Edit moves beside the status, View is removed.
    final actions = _buildActions(
      iconOnly: iconOnly,
      onDark: onDark,
      includeEdit: !isClassic,
      includeView: !isClassic,
    );

    Widget card;
    switch (widget.variant) {
      case BaseTileVariant.classic:
        card = _classicCard(details, statuses, actions);
        break;
      case BaseTileVariant.strip:
        card = _stripCard(details, statuses, actions);
        break;
      case BaseTileVariant.expandable:
        card = _expandableCard(details, statuses, actions);
        break;
      case BaseTileVariant.dark:
        card = _darkCard(details, statuses, actions);
        break;
    }

    // Soft fade + slide-up when the card first appears
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 380),
      curve: Curves.easeOutCubic,
      builder: (context, t, child) => Opacity(
        opacity: t,
        child:
        Transform.translate(offset: Offset(0, 14 * (1 - t)), child: child),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: card,
      ),
    );
  }

  void _handleTap() {
    HapticFeedback.lightImpact();
    widget.onTap?.call(widget.index);
  }

  BoxDecoration _cardDeco({double radius = 24, bool open = false}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: open ? _ListTheme.goldBorder : _ListTheme.cardBorder,
        width: open ? 2.5 : 1,
      ),
      boxShadow: [
        BoxShadow(
          color: _ListTheme.navy.withValues(alpha: 0.09),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
        BoxShadow(
          color: _ListTheme.gold.withValues(alpha: 0.08),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  // ===========================================================================
  // DESIGN 1: CLASSIC
  // ===========================================================================
  Widget _classicCard(
      List<MapEntry<String, String>> details,
      List<Widget> statuses,
      List<Widget> actions,
      ) {
    return Container(
      decoration: _cardDeco(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(23),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _handleTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                if (details.isNotEmpty) _buildDetailsBlock(details),
                if (actions.isNotEmpty)
                  _actionsRow(actions,
                      padding: const EdgeInsets.fromLTRB(16, 6, 16, 14)),
                // Footer always shows: status on the left, Edit on the right
                _buildStatusFooter(statuses),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final dateText = _dateText();

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, _ListTheme.pageBg],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          _goldTile(size: 35, radius: 16),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ID',
                  style: TextStyle(
                    color: _ListTheme.gold,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${widget.id ?? '-'}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _ListTheme.navy,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    height: 0.8,
                  ),
                ),
                if (widget.locationRegion != null) ...[
                  const SizedBox(height: 6),
                  _regionChip(),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (dateText != null) ...[
                _datePill(dateText),
              ],
              if (widget.showViewButton ?? true)
                Tooltip(
                  message: 'View',
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      HapticFeedback.lightImpact();
                      widget.onViewTap?.call(widget.index);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _ListTheme.actionBg,
                        border:
                        Border.all(color: _ListTheme.cardBorder, width: 1),
                      ),
                      child: const Icon(Icons.visibility_rounded,
                          size: 17, color: _ListTheme.gold),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsBlock(List<MapEntry<String, String>> details) {
    final rows = <Widget>[];
    for (int i = 0; i < details.length; i++) {
      rows.add(_detailRow(details[i].key, details[i].value));
      if (i != details.length - 1) {
        rows.add(const Padding(
          padding: EdgeInsets.only(left: 46),
          child: Divider(height: 1, thickness: 1, color: _ListTheme.divider),
        ));
      }
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Column(children: rows),
    );
  }

  /// Classic detail row: icon | label ........ value  (label and value sit
  /// side by side in one row instead of stacked).
  Widget _detailRow(String label, String value) {
    final cleanLabel = _clean(label);
    final accent = _accentForLabel(cleanLabel);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
              color: accent.tint,
              shape: BoxShape.circle,
            ),
            child: Icon(accent.icon, size: 19, color: accent.color),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 5,
            child: Text(
              cleanLabel,
              softWrap: true,
              style: const TextStyle(
                color: _ListTheme.labelGrey,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 6,
            child: Text(
              value.isEmpty ? '-' : value,
              softWrap: true,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: _ListTheme.navy,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Status on the left, Edit button beside it on the right.
  Widget _buildStatusFooter(List<Widget> statuses) {
    final showEdit = widget.onEditTap != null || (widget.showEditButton ?? false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 3,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _ListTheme.gold,
                _ListTheme.goldLight,
                _ListTheme.gold,
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(18, 14, 14, 6),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [_ListTheme.navyMid, _ListTheme.navyDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: statuses,
                ),
              ),
              if (showEdit)
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 8),
                  child: _editButton(onDark: true),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _editButton({bool onDark = false}) {
    final icon = (widget.showEditButton ?? true)
        ? Icons.edit_rounded
        : Icons.edit_off_outlined;

    // Solid gold pill with navy text: clear contrast on the navy footer.
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          HapticFeedback.lightImpact();
          widget.onEditTap?.call(widget.index);
        },
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [_ListTheme.goldLight, _ListTheme.gold],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: _ListTheme.gold.withValues(alpha: 0.35),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 17, color: _ListTheme.navyDark),
              const SizedBox(width: 6),
              const Text(
                'Edit',
                style: TextStyle(
                  color: _ListTheme.navyDark,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // DESIGN 2: STRIP (gold-to-teal accent strip, 2-column chips)
  // ===========================================================================
  Widget _stripCard(
      List<MapEntry<String, String>> details,
      List<Widget> statuses,
      List<Widget> actions,
      ) {
    final dateText = _dateText();

    return Container(
      decoration: _cardDeco(radius: 22),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(21),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _handleTap,
            child: Stack(
              children: [
                const Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  width: 6,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [_ListTheme.gold, _ListTheme.teal],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 16, 16, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _goldTile(size: 46, radius: 14),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'ID',
                                  style: TextStyle(
                                    color: _ListTheme.gold,
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 2,
                                  ),
                                ),
                                Text(
                                  '${widget.id ?? '-'}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: _ListTheme.navy,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    height: 1.1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (dateText != null) _datePill(dateText),
                        ],
                      ),
                      if (details.isNotEmpty) ...[
                        const SizedBox(height: 14),
                        LayoutBuilder(
                          builder: (context, c) {
                            final half = (c.maxWidth - 10) / 2;
                            return Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: details
                                  .map((e) => SizedBox(
                                width: details.length == 1
                                    ? c.maxWidth
                                    : half,
                                child: _detailChip(e.key, e.value),
                              ))
                                  .toList(),
                            );
                          },
                        ),
                      ],
                      if (statuses.isNotEmpty) ...[
                        const SizedBox(height: 14),
                        _statusBand(statuses, radius: 16),
                      ],
                      if (actions.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            alignment: WrapAlignment.end,
                            children: actions,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailChip(String label, String value) {
    final cleanLabel = _clean(label);
    final accent = _accentForLabel(cleanLabel);
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: accent.tint.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(accent.icon, size: 16, color: accent.color),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cleanLabel,
                  style: const TextStyle(
                    color: _ListTheme.labelGrey,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value.isEmpty ? '-' : value,
                  style: const TextStyle(
                    color: _ListTheme.navy,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // DESIGN 3: EXPANDABLE (collapsed summary, chevron opens the details)
  // ===========================================================================
  Widget _expandableCard(
      List<MapEntry<String, String>> details,
      List<Widget> statuses,
      List<Widget> actions,
      ) {
    final hasDetails = details.isNotEmpty;
    final chipText = widget.locationRegion?.name ??
        (hasDetails ? '${details.length} details' : null);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      decoration: _cardDeco(radius: 26, open: _expanded),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(26),
            onTap: () {
              HapticFeedback.lightImpact();
              if (widget.onTap != null) {
                widget.onTap!(widget.index);
              } else if (hasDetails) {
                setState(() => _expanded = !_expanded);
              }
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Row(
                children: [
                  _goldTile(size: 58, radius: 18, glow: _expanded),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ID : ${widget.id ?? '-'}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: _ListTheme.navy,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (chipText != null && chipText.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: _ListTheme.chipBg,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              chipText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: _ListTheme.gold,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (hasDetails) ...[
                    const SizedBox(width: 10),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        HapticFeedback.selectionClick();
                        setState(() => _expanded = !_expanded);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _expanded
                              ? _ListTheme.gold
                              : _ListTheme.actionBg,
                        ),
                        child: Icon(
                          _expanded
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 24,
                          color: _expanded ? Colors.white : _ListTheme.gold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            alignment: Alignment.topCenter,
            child: (_expanded && hasDetails)
                ? Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
              child: Column(
                children: details
                    .map((e) => _detailPill(e.key, e.value))
                    .toList(),
              ),
            )
                : const SizedBox(width: double.infinity),
          ),
          if (statuses.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
              child: _statusBand(statuses, radius: 20),
            ),
          if (actions.isNotEmpty)
            _actionsRow(actions,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 14))
          else
            const SizedBox(height: 14),
        ],
      ),
    );
  }

  Widget _detailPill(String label, String value) {
    final cleanLabel = _clean(label);
    final accent = _accentForLabel(cleanLabel);
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.fromLTRB(12, 10, 16, 10),
      decoration: BoxDecoration(
        color: _ListTheme.pageBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _ListTheme.cardBorder, width: 1),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent.tint,
            ),
            child: Icon(accent.icon, size: 20, color: accent.color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cleanLabel,
                  style: const TextStyle(
                    color: _ListTheme.labelGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value.isEmpty ? '-' : value,
                  style: const TextStyle(
                    color: _ListTheme.navy,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // DESIGN 4: DARK (navy card, gold border, glass detail rows)
  // ===========================================================================
  Widget _darkCard(
      List<MapEntry<String, String>> details,
      List<Widget> statuses,
      List<Widget> actions,
      ) {
    final dateText = _dateText();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [_ListTheme.navyMid, _ListTheme.navyDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: _ListTheme.goldBorder.withValues(alpha: 0.65),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: _ListTheme.navy.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(23),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _handleTap,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      _goldTile(size: 50, radius: 15),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ID',
                              style: TextStyle(
                                color: _ListTheme.goldLight,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 2.2,
                              ),
                            ),
                            Text(
                              '${widget.id ?? '-'}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (dateText != null)
                        _datePill(dateText, onDark: true),
                    ],
                  ),
                  if (details.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    ...details.map((e) => _darkDetail(e.key, e.value)),
                  ],
                  if (statuses.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: _ListTheme.goldLight.withValues(alpha: 0.25),
                    ),
                    const SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: statuses,
                    ),
                  ],
                  if (actions.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.end,
                        children: actions,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _darkDetail(String label, String value) {
    final cleanLabel = _clean(label);
    final accent = _accentForLabel(cleanLabel);
    final light = Color.lerp(accent.color, Colors.white, 0.35)!;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.fromLTRB(10, 10, 14, 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        children: [
          Container(
            height: 38,
            width: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent.color.withValues(alpha: 0.2),
            ),
            child: Icon(accent.icon, size: 19, color: light),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cleanLabel,
                  style: const TextStyle(
                    color: Color(0xFFB9B4E0),
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value.isEmpty ? '-' : value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SHARED PIECES
  // ===========================================================================
  String _clean(String label) =>
      label.replaceAll(RegExp(r'\s*:\s*$'), '').trim();

  String? _dateText() {
    final ts = int.tryParse(widget.inputDate ?? '');
    if (ts == null) return null;
    final t = Utils.timestampToDateConversion(ts, Constants.dateFormat);
    return (t.isEmpty) ? null : t;
  }

  Widget _goldTile({
    required double size,
    required double radius,
    bool glow = true,
  }) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: const LinearGradient(
          colors: [_ListTheme.goldLight, _ListTheme.gold],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.8),
          width: 1.2,
        ),
        boxShadow: glow
            ? [
          BoxShadow(
            color: _ListTheme.gold.withValues(alpha: 0.45),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ]
            : null,
      ),
      child: Icon(Icons.assignment_rounded,
          color: Colors.white, size: size * 0.48),
    );
  }

  Widget _regionChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: _ListTheme.chipBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.public_rounded, size: 13, color: _ListTheme.gold),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              widget.locationRegion?.name ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: _ListTheme.gold,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _datePill(String text, {bool onDark = false}) {
    final fg = onDark ? _ListTheme.goldLight : _ListTheme.labelGrey;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: onDark ? Colors.white.withValues(alpha: 0.1) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: onDark
              ? Colors.white.withValues(alpha: 0.25)
              : _ListTheme.cardBorder,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.calendar_today_rounded, size: 12, color: fg),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              color: fg,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBand(List<Widget> statuses, {double radius = 16}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: const LinearGradient(
          colors: [_ListTheme.navyMid, _ListTheme.navyDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: statuses,
      ),
    );
  }

  Widget _statusItem(Widget child, {bool expand = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: expand
          ? Row(children: [Expanded(child: child)])
          : Align(alignment: Alignment.centerLeft, child: child),
    );
  }

  Widget _actionsRow(List<Widget> actions, {required EdgeInsets padding}) {
    return Padding(
      padding: padding,
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.end,
        children: actions,
      ),
    );
  }

  ({IconData icon, Color color, Color tint}) _accentForLabel(String label) {
    final l = label.toLowerCase();
    if (l.contains('date') || l.contains('time') || l.contains('valid')) {
      return (
      icon: Icons.calendar_month_rounded,
      color: _ListTheme.amber,
      tint: _ListTheme.amberTint
      );
    }
    if (l.contains('location') || l.contains('region') || l.contains('area')) {
      return (
      icon: Icons.location_on_rounded,
      color: _ListTheme.teal,
      tint: _ListTheme.tealTint
      );
    }
    if (l.contains('created') ||
        l.contains('by') ||
        l.contains('name') ||
        l.contains('manager') ||
        l.contains('guard')) {
      return (
      icon: Icons.person_rounded,
      color: _ListTheme.violet,
      tint: _ListTheme.violetTint
      );
    }
    if (l.contains('vendor') || l.contains('company') || l.contains('dept')) {
      return (
      icon: Icons.business_rounded,
      color: _ListTheme.blue,
      tint: _ListTheme.blueTint
      );
    }
    return (
    icon: Icons.tag_rounded,
    color: _ListTheme.gold,
    tint: _ListTheme.chipBg
    );
  }

  // ---------------------------------------------------------------------------
  // ACTION BUTTONS (pill with label for classic, round icon for the others)
  // ---------------------------------------------------------------------------
  Widget _actionPill({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    Color? color,
    bool primary = false,
    bool iconOnly = false,
    bool onDark = false,
  }) {
    final Color fg = primary
        ? Colors.white
        : (color ?? (onDark ? Colors.white : _ListTheme.navy));

    final decoration = BoxDecoration(
      shape: iconOnly ? BoxShape.circle : BoxShape.rectangle,
      borderRadius: iconOnly ? null : BorderRadius.circular(30),
      gradient: primary
          ? LinearGradient(
        colors: onDark
            ? const [_ListTheme.goldLight, _ListTheme.gold]
            : const [_ListTheme.navyMid, _ListTheme.navyDark],
      )
          : null,
      color: primary
          ? null
          : (onDark
          ? Colors.white.withValues(alpha: 0.1)
          : _ListTheme.actionBg),
      border: primary
          ? null
          : Border.all(
        color: onDark
            ? Colors.white.withValues(alpha: 0.25)
            : _ListTheme.cardBorder,
        width: 1,
      ),
      boxShadow: primary
          ? [
        BoxShadow(
          color: (onDark ? _ListTheme.gold : _ListTheme.navy)
              .withValues(alpha: 0.3),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ]
          : null,
    );

    final button = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        customBorder: iconOnly ? const CircleBorder() : null,
        borderRadius: iconOnly ? null : BorderRadius.circular(30),
        child: Ink(
          decoration: decoration,
          child: iconOnly
              ? SizedBox(
            height: 40,
            width: 40,
            child: Icon(icon, size: 19, color: fg),
          )
              : Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 17, color: fg),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    color: fg,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return iconOnly ? Tooltip(message: label, child: button) : button;
  }

  List<Widget> _buildActions({
    bool iconOnly = false,
    bool onDark = false,
    bool includeEdit = true,
    bool includeView = true,
  }) {
    final a = <Widget>[];

    void add(
        IconData icon,
        String label,
        Function? cb, {
          Color? color,
          bool primary = false,
        }) {
      a.add(_actionPill(
        icon: icon,
        label: label,
        color: color,
        primary: primary,
        iconOnly: iconOnly,
        onDark: onDark,
        onPressed: () {
          cb != null ? cb(widget.index) : null;
        },
      ));
    }

    if (includeEdit) {
      add(
        (widget.showEditButton ?? true)
            ? Icons.edit_rounded
            : Icons.edit_off_outlined,
        'Edit',
        widget.onEditTap,
        color: onDark ? _ListTheme.goldLight : _ListTheme.gold,
      );
    }

    if (includeView && (widget.showViewButton ?? true)) {
      add(
        iconOnly ? Icons.arrow_forward_rounded : Icons.visibility_rounded,
        'View',
        widget.onViewTap,
        primary: true,
      );
    }

    if (widget.isSecuritySystemSLA == true && widget.status == 2 ||
        widget.status == 3 ||
        widget.status == 4 ||
        widget.status == 5 ||
        widget.status == 8 ||
        widget.status == 10 ||
        widget.status == 12) {
      if (widget.showEmailButton ?? true) {
        add(Icons.email_rounded, 'Email', widget.onEmailTap,
            color: onDark ? const Color(0xFF8EC3FF) : const Color(0xFF0C4C99));
      }
    }

    if (widget.showLinkOffButton ?? true) {
      add(Icons.link_off_rounded, 'Unlink', widget.onLinkOffTap);
    }

    if (widget.showLaunchButton ?? true) {
      add(Icons.rocket_launch_rounded, 'Launch', widget.onLaunchTap,
          color: onDark ? _ListTheme.goldLight : _ListTheme.gold);
    }

    if ((widget.showDeleteButton ?? true) && widget.onDeleteTap != null) {
      add(Icons.delete_rounded, 'Delete', widget.onDeleteTap,
          color: onDark ? const Color(0xFFFF8E8E) : const Color(0xFFD64545));
    }

    if (widget.showApproveButton ?? true) {
      add(Icons.approval_rounded, 'Approve', widget.onApproveTap);
    }

    return a;
  }

  // ---------------------------------------------------------------------------
  // DATA: label / value rows
  // ---------------------------------------------------------------------------
  List<MapEntry<String, String>> _buildDetails() {
    final d = <MapEntry<String, String>>[];

    void add(String label, Object? value) {
      if (value == null) return;
      d.add(MapEntry(label, value.toString()));
    }

    if (widget.location != null) {
      add('Location : ', widget.location?.name ?? '');
    }
    if (widget.locationStr != null) add('Location : ', widget.locationStr);
    if (widget.vendors != null) add('Vendor : ', widget.vendors?.name ?? '');
    if (widget.guardCount != null) add('Guard Count : ', widget.guardCount);
    if (widget.pvcExpired != null) {
      add('Staff PVC Expired : ', widget.pvcExpired);
    }
    if (widget.vendor != null) add('Vendor : ', widget.vendor);

    for (Label label in widget.labels ?? []) {
      if (label.value == 'null' || label.value.isEmpty) continue;
      d.add(MapEntry('${label.key} : ', label.value));
    }
    return d;
  }

  // ---------------------------------------------------------------------------
  // DATA: status widgets (built by Utils())
  // ---------------------------------------------------------------------------
  List<Widget> _buildStatusWidgets() {
    final w = <Widget>[];
    final s = widget.status;

    if (widget.guardRank != -1 && widget.isMasterGuardRank == true) {
      w.add(_statusItem(
          Utils().buildGuardRank(guardRank: widget.guardRank ?? 0)));
    }
    if (widget.workShift != -1 && widget.isWorkShift == true) {
      w.add(_statusItem(
          Utils().buildWorkShift(workShift: widget.workShift ?? 0)));
    }
    if (widget.incidentType != null) {
      w.add(_statusItem(Utils().incidentType(widget.incidentType ?? 0)));
    }
    if (widget.transportIncidentType != null) {
      w.add(_statusItem(
          Utils().transportIncidentType(widget.transportIncidentType ?? 0)));
    }
    if (s != null &&
        widget.isArticleFoundStatus == true &&
        !widget.isShiftScheduleStatus) {
      w.add(_statusItem(Utils().buildFoundStatusRow(s)));
    }
    if (s != null && widget.isEventProtectionStatus && !widget.isMasterGuard) {
      w.add(_statusItem(Utils().buildEventProtectionStatusRow(s)));
    }
    if (s != null &&
        widget.isCSREventProtectionStatus &&
        !widget.isMasterGuard) {
      w.add(_statusItem(Utils().buildCSRProtectionStatusRow(s)));
    }
    if (s != null && widget.isIncident == true) {
      w.add(_statusItem(Utils().buildIncidentStatus(s)));
    }
    if (s != null &&
        widget.isLawEnforcementStatus == true &&
        !widget.isShiftScheduleStatus) {
      w.add(_statusItem(Utils().buildLeoStatusRow(s)));
    }
    if (s != null &&
        widget.isMaterialMovementStatus == true &&
        !widget.isMasterGuard) {
      w.add(_statusItem(Utils().buildMaterialMovementStatusRow(s),
          expand: true));
    }
    if (s != 0 && widget.isMasterGuard) {
      w.add(_statusItem(Utils().buildMasterDataStatusRow(s ?? 0)));
    }
    if (s != null && widget.isKeyManagementIssuanceStatus) {
      w.add(_statusItem(Utils().keyManagementIssuanceStatus(s),
          expand: true));
    }
    if (s != null && widget.isPatrollingStatus) {
      w.add(_statusItem(Utils().patrollingStatus(s), expand: true));
    }
    if (s != null && widget.isParkingStatus) {
      w.add(_statusItem(Utils().parkingStatus(s), expand: true));
    }
    if (s != null && widget.isAttendanceStatus == true) {
      w.add(_statusItem(Utils().buildAttendanceStatusRow(s)));
    }
    if (s != null && widget.isKeyManagementStatus) {
      w.add(_statusItem(Utils().keyManagementStatus(s)));
    }
    if (s != null && widget.isKeyManagementHistoryStatus) {
      w.add(_statusItem(Utils().keyManagementMasterHistoryStatus(s)));
    }
    if (s != null && widget.isOccurrenceStatus == true) {
      w.add(_statusItem(Utils().buildOccurrenceStatus(s)));
    }
    if (s != null && widget.isKeyLossStatus == true) {
      w.add(_statusItem(Utils().keyLossDestructionStatus(s)));
    }
    if (s != null && widget.isSLAViolationStatus == true) {
      w.add(_statusItem(Utils().buildSLAViolationStatus(s)));
    }
    if (s != null &&
        widget.isContactDetailsStatus == true &&
        widget.isEventProtectionStatus == false) {
      w.add(_statusItem(Utils().contactDetailsStatus(s)));
    }
    if (s != null &&
        widget.isEventProtectionStatus == false &&
        widget.isSecuritySystemSLA == true) {
      w.add(_statusItem(Utils().buildSecuritySystemStatusRow(s)));
    }
    if (widget.isVipStatus == true) {
      w.add(_statusItem(Utils().vIPVisitorStatusRow(s ?? 0)));
    }
    if (s != null && widget.isShiftScheduleStatus == true) {
      w.add(_statusItem(Utils().shiftScheduleStatusRow(s)));
    }
    if (s != null && widget.isTransportStatus == true) {
      w.add(_statusItem(Utils().transportMedicalStatus(s)));
    }
    if (s != null && widget.isDutyPostNameMasterStatus == true) {
      w.add(_statusItem(Utils().dutyPostNameMasterStatus(s)));
    }
    if (s != null && widget.isDutyPostMasterStatus == true) {
      w.add(_statusItem(Utils().dutyPostMasterStatus(s)));
    }
    if (s != null &&
        widget.isPassManagementStatus == true &&
        !widget.isShiftScheduleStatus) {
      w.add(_statusItem(Utils().buildPassManagementStatusRow(s)));
    }
    if (s != null && widget.isTicketStatus) {
      w.add(_statusItem(Utils().buildTicketStatusRow(s)));
    }

    return w;
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