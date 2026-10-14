// import 'dart:ui';
//
// import 'package:db_atom/index.dart';
//
// class BasePopUpItems extends StatefulWidget {
//   final String? id;
//   final String? slNo;
//   final Organisation? location;
//   final Organisation? locationRegion;
//   final int? status;
//   final String? inputDate;
//   final String? entrySecurityName;
//   final bool? returnable;
//   final String? quantity;
//   final String? challanNo;
//   final String? vendor;
//   final String? region;
//   final int? guardCount;
//   final int? mcNotSubmitted;
//   final int? mcExpired;
//   final int? photoNotSubmitted;
//   final int? deploymentOrderPending;
//   final int? pvcExpired;
//   final int? msgbExempted;
//   final int? msgbNotExempted;
//   final int? msgbFormBNotSubmitted;
//   final int? msgbFormBUnderProcess;
//   final int? systemAccess;
//   final int? trainingCertPending;
//   final int? precPending;
//   final int? precDoseCount;
//   final int? ertCertified;
//   final int? ertPending;
//   final int? esicPending;
//   final int? uanNoPending;
//   final int? firstAidCertified;
//   final int? firstAidNotCertified;
//   final String? locationStr;
//   final Organisation? locationEntity;
//   final Organisation? locationRegionEntity;
//   final int? dutyType;
//   final List<Label>? labels;
//   final bool? isMaterGuard;
//   final int? guardRank;
//   final int? dutyGuardRank;
//   final int? gender;
//   final int? maritalStatus;
//   final bool isMasterGuard;
//   final bool isAttendance;
//   final bool? eventType;
//   final bool isOccurrenceStatus;
//   final bool isEventProtectionStatus;
//   final String? epManager1Name;
//   final bool isSLAViolationStatus;
//   final bool? shiftBrfngAttnded;
//   final bool? materialMovement;
//   final bool? leoVisit;
//   final User? handOverSecurity;
//   final int? incidentType;
//   final bool isIncident;
//   final bool isContactDetailsStatus;
//   final bool isSecuritySystemSLAStatus;
//   final bool isKeyLossStatus;
//   final bool isKeyManagementIssuanceStatus;
//   final bool isKeyManagementStatus;
//   final bool isVipStatus;
//   final bool isMaterialMovementStatus;
//   final bool isKeyManagementHistoryStatus;
//   final bool isShiftScheduleStatus;
//   final bool isDutyPostNameMasterStatus;
//   final User? srh;
//   final User? securityManager;
//   final int? keyType;
//   final int? type;
//   final int? keyTagging;
//   final String? keyNo;
//   final String? doorName;
//   final int? employeeType;
//   final User? dbSponsorCWRT2;
//   final User? handedOver;
//   final String? returnedByName;
//   final Organisation? department;
//   final Organisation? vendors;
//   final bool isPassManagementStatus;
//   final String? passValidFrom;
//   final String? passValidUntil;
//   final String? companyName;
//   final bool? sez;
//   final bool isLawEnforcementStatus;
//   final String? dbOfficialWantToMeet;
//   final Organisation? visitPurpose;
//   final Organisation? dbOfficialDep;
//   final bool isArticleFoundStatus;
//   final bool isWorkShift;
//   final int? workShift;
//   final bool isTicketStatus;
//   final bool isTransportStatus;
//   final bool isCSREventProtectionStatus;
//   final bool isPatrollingStatus;
//   final bool isDutyPostMasterStatus;
//   final int? transportIncidentType;
//   final bool isAttendanceStatus;
//   final bool parkingStatus;
//
//   @override
//   State<BasePopUpItems> createState() => _BasePopUpItemsState();
//
//   const BasePopUpItems({
//     super.key,
//     required this.id,
//     this.slNo,
//     this.location,
//     this.locationRegion,
//     this.quantity,
//     this.status,
//     this.inputDate,
//     this.entrySecurityName,
//     this.returnable,
//     this.challanNo,
//     this.region,
//     this.vendor,
//     this.guardCount,
//     this.mcNotSubmitted,
//     this.mcExpired,
//     this.photoNotSubmitted,
//     this.deploymentOrderPending,
//     this.pvcExpired,
//     this.msgbExempted,
//     this.msgbNotExempted,
//     this.msgbFormBNotSubmitted,
//     this.msgbFormBUnderProcess,
//     this.systemAccess,
//     this.trainingCertPending,
//     this.precPending,
//     this.precDoseCount,
//     this.ertCertified,
//     this.ertPending,
//     this.esicPending,
//     this.uanNoPending,
//     this.firstAidCertified,
//     this.firstAidNotCertified,
//     this.locationStr,
//     this.dutyType,
//     this.labels,
//     this.isMaterGuard,
//     this.guardRank,
//     this.dutyGuardRank,
//     this.gender,
//     this.maritalStatus,
//     this.locationEntity,
//     this.locationRegionEntity,
//     this.isMasterGuard = true,
//     this.isAttendance = false,
//     this.isIncident = false,
//     this.eventType,
//     this.isEventProtectionStatus = true,
//     this.isOccurrenceStatus = false,
//     this.epManager1Name,
//     this.isSLAViolationStatus = false,
//     this.shiftBrfngAttnded = false,
//     this.materialMovement = false,
//     this.isMaterialMovementStatus = false,
//     this.leoVisit = false,
//     this.isContactDetailsStatus = false,
//     this.isSecuritySystemSLAStatus = false,
//     this.isKeyLossStatus = false,
//     this.isKeyManagementIssuanceStatus = false,
//     this.isKeyManagementStatus = false,
//     this.isVipStatus = false,
//     this.isKeyManagementHistoryStatus = false,
//     this.isDutyPostNameMasterStatus = false,
//     this.isShiftScheduleStatus = false,
//     this.handOverSecurity,
//     this.incidentType,
//     this.transportIncidentType,
//     this.srh,
//     this.keyType,
//     this.type,
//     this.securityManager,
//     this.keyNo,
//     this.keyTagging,
//     this.doorName,
//     this.employeeType,
//     this.dbSponsorCWRT2,
//     this.handedOver,
//     this.department,
//     this.returnedByName,
//     this.vendors,
//     this.isPassManagementStatus = false,
//     this.passValidFrom,
//     this.passValidUntil,
//     this.companyName,
//     this.sez,
//     this.isLawEnforcementStatus = false,
//     this.dbOfficialWantToMeet,
//     this.visitPurpose,
//     this.dbOfficialDep,
//     this.isArticleFoundStatus = false,
//     this.isWorkShift = false,
//     this.workShift,
//     this.isTicketStatus = false,
//     this.isTransportStatus = false,
//     this.isCSREventProtectionStatus = false,
//     this.isPatrollingStatus = false,
//     this.isDutyPostMasterStatus = false,
//     this.isAttendanceStatus = false,
//     this.parkingStatus = false,
//   });
// }
//
// class _BasePopUpItemsState extends State<BasePopUpItems> {
//   final bool isBasePopUpField = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final height = size.height;
//     final width = size.width;
//     return Center(
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(18),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
//           // Frosted glass blur
//           child: Container(
//             padding: const EdgeInsets.all(20.0),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.white.withValues(alpha: 0.3),
//                   Colors.transparent,
//                   Colors.white.withValues(alpha: 0.3),
//                   // Color(0xFF6474C6).withOpacity(0.14)
//                 ],
//                 stops: const [0.02, 0.35, 1],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//               borderRadius: BorderRadius.circular(27),
//               border: Border.all(
//                 color: Colors.white.withValues(alpha: 0.80),
//                 width: 0.8,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.newColor.withValues(alpha: 0.1),
//                   blurRadius: 12,
//                   offset: const Offset(8, 0),
//                 ),
//               ],
//             ),
//             height: height / 1.8,
//             width: width - 18,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: getChildren(context, widget.labels),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   List<Widget> getChildren(BuildContext context, List<Label>? labels) {
//     List<Widget> widgets = [];
//
//     widgets = [
//       Align(
//         alignment: Alignment.topRight,
//         child: GestureDetector(
//             onTap: () {
//               Navigator.of(context).pop();
//             },
//             child: SvgPicture.asset(
//               AppIcon.closeIcon,
//               colorFilter: const ColorFilter.mode(
//                 AppColors.white,
//                 BlendMode.srcIn,
//               ),
//             ) //Icon(Icons.cancel)
//             ),
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Utils().textHandling('ID : ', widget.id.toString()),
//           CommonWidgets.verticalSpacerWidget(5),
//         ],
//       ),
//       CommonWidgets.verticalSpacerWidget(8),
//       if (widget.slNo != null && widget.slNo!.isNotEmpty) ...[
//         Row(
//           children: [
//             Expanded(
//               //  REQUIRED to avoid overflow
//               child: Utils().textHandling(
//                 'Sl No : ',
//                 widget.slNo.toString(),
//               ),
//             ),
//           ],
//         ),
//       ],
//       if (widget.locationRegion != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           children: [
//             Utils()
//                 .textHandling('Region : ', widget.locationRegion?.name ?? " "),
//           ],
//         ),
//       ],
//       if (widget.location != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           children: [
//             Utils().textHandling('Location : ', widget.location?.name ?? " "),
//           ],
//         ),
//       ],
//       if (widget.locationRegionEntity != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           children: [
//             Utils().textHandling(
//                 'Region : ', widget.locationRegionEntity?.name ?? " "),
//           ],
//         ),
//       ],
//       if (widget.locationEntity != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling(
//                 'Building Loaction : ', widget.locationEntity?.name ?? ''),
//           ],
//         ),
//       ],
//       if (widget.keyType != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().buildKeyType(widget.keyType ?? 0),
//           ],
//         ),
//       ],
//       if (widget.type != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().buildType(widget.type ?? 0),
//           ],
//         ),
//       ],
//       if (widget.srh != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling('Srh : ', widget.srh?.name ?? ''),
//           ],
//         ),
//       ],
//       if (widget.securityManager != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling(
//                 'Security Manager : ', widget.securityManager?.name ?? ''),
//           ],
//         ),
//       ],
//       if (widget.keyNo != null && !widget.keyNo.isEmptyOrNull) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling('Key No : ', widget.keyNo.toString()),
//           ],
//         ),
//       ],
//       if (widget.keyTagging != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling(
//                 'Key Tagging Done : ', widget.keyTagging.toString()),
//           ],
//         ),
//       ],
//       if (widget.doorName != null && !widget.doorName.isEmptyOrNull) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils()
//                 .textHandling('Key Description : ', widget.doorName.toString()),
//           ],
//         ),
//       ],
//       if (widget.inputDate != null) ...[
//         Row(
//           children: [
//             Utils().textHandling(
//                 'Date Of Creation : ',
//                 widget.inputDate != null
//                     ? Utils.timestampToDateConversion(
//                         int.tryParse(widget.inputDate ?? '0'),
//                         Constants.dateFormat)
//                     : ''),
//           ],
//         ),
//       ],
//       if (widget.vendors != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           children: [
//             Utils().textHandling('Vendor : ', widget.vendors?.name ?? ''),
//           ],
//         ),
//       ],
//       if (widget.status != null && widget.isMaterialMovementStatus == true) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           children: [
//             Utils().buildMaterialMovementStatusRow(widget.status ?? 0),
//           ],
//         ),
//       ],
//       if (widget.status != 0 &&
//           widget.status != null &&
//           widget.isMasterGuard) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           children: [
//             CommonWidgets.verticalSpacerWidget(5),
//             Utils().buildMasterDataStatusRow(widget.status ?? 0),
//           ],
//         ),
//         CommonWidgets.verticalSpacerWidget(7),
//       ],
//       if (widget.maritalStatus != 0 &&
//           widget.maritalStatus != null &&
//           widget.isMasterGuard) ...[
//         Row(
//           children: [
//             CommonWidgets.verticalSpacerWidget(5),
//             Utils().buildMaritalStatus(widget.maritalStatus ?? 0),
//           ],
//         ),
//       ],
//       if (widget.guardRank != 0 &&
//           widget.guardRank != null &&
//           widget.isMasterGuard) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           children: [
//             Utils().buildGuardRank(guardRank: widget.guardRank ?? 0),
//           ],
//         ),
//       ],
//       if (widget.dutyGuardRank != 0 &&
//           widget.dutyGuardRank != null &&
//           widget.isMasterGuard) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           children: [
//             Utils().dutyGuardRank(dutyGuardRank: widget.dutyGuardRank ?? 0),
//           ],
//         ),
//       ],
//       if (widget.gender != 0 &&
//           widget.gender != null &&
//           widget.isMasterGuard) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           children: [
//             Utils().buildGender(widget.gender ?? 0),
//           ],
//         ),
//       ],
//       if (widget.dutyType != 0 &&
//           widget.dutyType != null &&
//           widget.isMasterGuard) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Utils().buildDutyTypeRow(widget.dutyType ?? 0),
//       ],
//       if (widget.status != null &&
//           widget.isKeyManagementIssuanceStatus == true) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().keyManagementIssuanceStatus(widget.status ?? 0),
//           ],
//         ),
//       ],
//       if (widget.status != null &&
//           widget.isKeyManagementHistoryStatus == true) ...[
//         Row(
//           children: [
//             CommonWidgets.verticalSpacerWidget(5),
//             Utils().keyManagementMasterHistoryStatus(widget.status ?? 0),
//           ],
//         ),
//       ],
//       if (widget.status != null && widget.isKeyManagementStatus == true) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().keyManagementStatus(widget.status ?? 0),
//           ],
//         ),
//       ],
//       if (widget.locationStr != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling('Location : ', widget.locationStr.toString()),
//           ],
//         ),
//       ],
//       if (widget.vendor != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           children: [
//             Utils().textHandling('Vendor : ', widget.vendor.toString()),
//           ],
//         ),
//       ],
//       if (widget.region != null) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           children: [
//             Utils().textHandling('Region : ', widget.region.toString()),
//           ],
//         ),
//       ],
//       if (widget.dutyType != 0 &&
//           widget.dutyType != null &&
//           widget.isAttendance == true) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Utils().buildAttendanceDutyTypeRow(widget.dutyType ?? 0),
//       ],
//       if (widget.epManager1Name != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           children: [
//             Utils().textHandling('Event protection Manager 1 : ',
//                 widget.epManager1Name.toString()),
//           ],
//         ),
//       ],
//       if (widget.eventType != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           children: [
//             Utils().textHandling('Event Type : ',
//                 widget.eventType == true ? 'Internal' : 'External'),
//           ],
//         )
//       ],
//       if (widget.employeeType != null) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           children: [
//             Utils().employeeTypeValues(widget.employeeType ?? 0),
//           ],
//         ),
//       ],
//       if (widget.status != null &&
//           widget.isEventProtectionStatus &&
//           !widget.isMasterGuard) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           children: [
//             Utils().buildEventProtectionStatusRow(widget.status ?? 0),
//           ],
//         ),
//       ],
//       if (widget.status != null &&
//           widget.isCSREventProtectionStatus &&
//           !widget.isMasterGuard) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           children: [
//             Utils().buildCSRProtectionStatusRow(widget.status ?? 0),
//           ],
//         ),
//       ],
//       if (widget.status != null &&
//           widget.isAttendanceStatus &&
//           !widget.isMasterGuard) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           children: [
//             Utils().buildAttendanceStatusRow(widget.status ?? 0),
//           ],
//         ),
//       ],
//       if (widget.status != null &&
//           !widget.isEventProtectionStatus &&
//           widget.isSecuritySystemSLAStatus == true) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           children: [
//             Utils().buildSecuritySystemStatusRow(widget.status ?? 0),
//           ],
//         ),
//       ],
//       if (widget.status != null && widget.isKeyLossStatus == true) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           children: [
//             Utils().keyLossDestructionStatus(widget.status ?? 0),
//           ],
//         )
//       ],
//       if (widget.maritalStatus != null &&
//           widget.isDutyPostNameMasterStatus == true) ...[
//         Row(
//           children: [
//             CommonWidgets.verticalSpacerWidget(5),
//             Utils().dutyPostNameMasterStatus(widget.maritalStatus ?? 0),
//           ],
//         ),
//       ],
//       if (widget.status != null && widget.isDutyPostMasterStatus == true) ...[
//         Row(
//           children: [
//             CommonWidgets.verticalSpacerWidget(5),
//             Utils().dutyPostMasterStatus(widget.status ?? 0),
//           ],
//         ),
//       ],
//       if (widget.isTicketStatus == true && widget.status != null) ...[
//         Row(
//           children: [
//             CommonWidgets.verticalSpacerWidget(5),
//             Utils().buildTicketStatusRow(widget.status ?? 0),
//           ],
//         ),
//       ],
//       if (widget.parkingStatus == true && widget.status != null) ...[
//         Row(
//           children: [
//             CommonWidgets.verticalSpacerWidget(5),
//             Utils().parkingStatus(widget.status ?? 0),
//           ],
//         ),
//       ],
//       if (widget.guardCount != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils()
//                 .textHandling('Guard Count : ', widget.guardCount.toString()),
//           ],
//         ),
//       ],
//       if (widget.mcNotSubmitted != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Text(
//                 'Total No of Staff MedicalCertificate Not Submitted:\n${widget.mcNotSubmitted}',
//                 style: Styles.textStyleWhite14,
//               ),
//             )
//           ],
//         ),
//       ],
//       if (widget.mcExpired != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling(
//                 'Total No of Staff MedicalCertificate Expired:',
//                 widget.mcExpired.toString()),
//           ],
//         ),
//       ],
//       if (widget.photoNotSubmitted != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling('Total No of Staff Photograph Not Submitted :',
//                 widget.photoNotSubmitted.toString()),
//           ],
//         ),
//       ],
//       if (widget.deploymentOrderPending != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling(
//                 'Total No of Staff DeplyomentOrder Not Submitted:',
//                 widget.deploymentOrderPending.toString()),
//           ],
//         ),
//       ],
//       if (widget.pvcExpired != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling('Total No of Staff PVC Expired : ',
//                 widget.pvcExpired.toString()),
//           ],
//         ),
//       ],
//       if (widget.msgbExempted != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling('Total No of Staff MSGB Exempted : ',
//                 widget.msgbExempted.toString()),
//           ],
//         ),
//       ],
//       if (widget.msgbNotExempted != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling('Total No of Staff MSGB Not Exempted : ',
//                 widget.msgbNotExempted.toString()),
//           ],
//         ),
//       ],
//       if (widget.msgbFormBNotSubmitted != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling(
//                 'Total No of Staff MSGB Form B Not Exempted : ',
//                 widget.msgbFormBNotSubmitted.toString()),
//           ],
//         ),
//       ],
//       if (widget.msgbFormBUnderProcess != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling(
//                 'Total No of Staff MSGB Form B Under Process : ',
//                 widget.msgbFormBUnderProcess.toString()),
//           ],
//         ),
//       ],
//       if (widget.systemAccess != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling('Total No of Staff With System Access : ',
//                 widget.systemAccess.toString()),
//           ],
//         ),
//       ],
//       if (widget.trainingCertPending != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling(
//                 'Total No of Staff Training Certificate Pending : ',
//                 widget.trainingCertPending.toString()),
//           ],
//         ),
//       ],
//       if (widget.precPending != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling(
//                 'Total No of Staff Precaution Covid Dose Pending : ',
//                 widget.precPending.toString()),
//           ],
//         ),
//       ],
//       if (widget.precDoseCount != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling(
//                 'Total No of Staff Precaution Covid Dose Taken  : ',
//                 widget.precDoseCount.toString()),
//           ],
//         ),
//       ],
//       if (widget.ertCertified != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling('Total No of Staff ERT Certified  : ',
//                 widget.ertCertified.toString()),
//           ],
//         ),
//       ],
//       if (widget.ertPending != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling('Total No of Staff ERT Pending  : ',
//                 widget.ertPending.toString()),
//           ],
//         ),
//       ],
//       if (widget.esicPending != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling('Total No of Staff ESIC Pending  : ',
//                 widget.esicPending.toString()),
//           ],
//         ),
//       ],
//       if (widget.uanNoPending != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling('Total No of Staff UAN Pending  : ',
//                 widget.uanNoPending.toString()),
//           ],
//         ),
//       ],
//       if (widget.firstAidCertified != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling(
//                 'Total No of Staff FirstAid Training Certified  : ',
//                 widget.firstAidCertified.toString()),
//           ],
//         ),
//       ],
//       if (widget.status != null && widget.isSLAViolationStatus == true) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().buildSLAViolationStatus(widget.status ?? 0),
//           ],
//         ),
//       ],
//       if (widget.firstAidNotCertified != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling(
//                 'Total No of Staff FirstAid Training Pending  : ',
//                 widget.firstAidNotCertified.toString()),
//           ],
//         ),
//       ],
//       if (widget.status != null && widget.isOccurrenceStatus == true) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().buildOccurrenceStatus(widget.status ?? 0),
//           ],
//         ),
//       ],
//       if (widget.shiftBrfngAttnded != null &&
//           widget.shiftBrfngAttnded == true) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().shiftBrfngAttnded(widget.shiftBrfngAttnded ?? true),
//           ],
//         ),
//       ],
//       if (widget.materialMovement != null &&
//           widget.materialMovement == true) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().materialMovement(widget.materialMovement ?? true),
//           ],
//         ),
//       ],
//       if (widget.leoVisit != null && widget.leoVisit == true) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().leoVisit(widget.leoVisit ?? true),
//           ],
//         ),
//       ],
//       if (widget.handOverSecurity != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling('Shift Taken By : ',
//                 '${widget.handOverSecurity?.firstName ?? ''}  ${widget.handOverSecurity?.lastName ?? ''}'),
//           ],
//         ),
//       ],
//       if (widget.status != null && widget.isIncident) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().buildIncidentStatus(widget.status ?? 0),
//           ],
//         ),
//       ],
//       if (widget.status != null && widget.isTransportStatus) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().transportMedicalStatus(widget.status ?? 0),
//           ],
//         ),
//       ],
//       if (widget.status != null && widget.isPatrollingStatus) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().patrollingStatus(widget.status ?? 0),
//           ],
//         ),
//       ],
//       CommonWidgets.verticalSpacerWidget(5),
//       if (widget.status != null &&
//           widget.isContactDetailsStatus == true &&
//           widget.isEventProtectionStatus == false) ...[
//         CommonWidgets.horizontalSpacerWidget(5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().contactDetailsStatus(widget.status ?? 0),
//           ],
//         ),
//       ],
//       if (widget.status != null &&
//           widget.isPassManagementStatus == true &&
//           widget.isEventProtectionStatus == false) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().buildPassManagementStatusRow(widget.status ?? 0),
//           ],
//         ),
//         CommonWidgets.verticalSpacerWidget(5),
//       ],
//       if (widget.status != null && widget.isLawEnforcementStatus == true) ...[
//         CommonWidgets.horizontalSpacerWidget(5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().buildLeoStatusRow(widget.status ?? 0),
//           ],
//         ),
//       ],
//       if (widget.status != null && widget.isArticleFoundStatus == true) ...[
//         CommonWidgets.horizontalSpacerWidget(5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().buildFoundStatusRow(widget.status ?? 0),
//           ],
//         ),
//       ],
//       if (widget.status != null && widget.isShiftScheduleStatus == true) ...[
//         CommonWidgets.horizontalSpacerWidget(5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().shiftScheduleStatusRow(widget.status ?? 0),
//           ],
//         ),
//       ],
//       if (widget.incidentType != null) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().incidentType(widget.incidentType ?? 0),
//           ],
//         ),
//       ],
//       if (widget.transportIncidentType != null) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().transportIncidentType(widget.transportIncidentType ?? 0),
//           ],
//         ),
//       ],
//       if (widget.dbSponsorCWRT2 != null &&
//           !widget.dbSponsorCWRT2!.name.isEmptyOrNull) ...[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling(
//                 'Db Sponsor CWR T2 : ', widget.dbSponsorCWRT2?.name ?? ''),
//           ],
//         ),
//       ],
//       if (widget.handedOver != null) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling(
//                 'Handed Over To : ', widget.handedOver?.name ?? ''),
//           ],
//         ),
//       ],
//       if (widget.department != null) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling('Department: ', widget.department?.name ?? ''),
//           ],
//         ),
//       ],
//       if (widget.returnedByName != null &&
//           !widget.returnedByName.isEmptyOrNull) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling(
//                 'Returned By: ', widget.returnedByName.toString()),
//           ],
//         ),
//       ],
//       if (widget.status != null && widget.isVipStatus == true) ...[
//         Row(
//           children: [
//             CommonWidgets.verticalSpacerWidget(5),
//             Utils().vIPVisitorStatusRow(widget.status ?? 0),
//           ],
//         ),
//       ],
//       if (widget.passValidFrom != null) ...[
//         CommonWidgets.verticalSpacerWidget(10),
//         Row(
//           children: [
//             Utils().textHandling(
//                 widget.sez == true ? 'Pass Issued On: ' : 'Pass Valid From: ',
//                 widget.passValidFrom != null
//                     ? Utils.timestampToDateConversion(
//                         int.tryParse(widget.passValidFrom ?? '0'),
//                         Constants.fulldateFormat)
//                     : ''),
//           ],
//         ),
//       ],
//       CommonWidgets.verticalSpacerWidget(8),
//       if (widget.passValidUntil != null) ...[
//         Row(
//           children: [
//             Utils().textHandling(
//                 'Pass Valid Until: ',
//                 widget.passValidUntil != null
//                     ? Utils.timestampToDateConversion(
//                         int.tryParse(widget.passValidUntil ?? '0'),
//                         Constants.fulldateFormat)
//                     : ''),
//           ],
//         ),
//       ],
//       CommonWidgets.verticalSpacerWidget(8),
//       if (widget.companyName != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           children: [
//             Utils()
//                 .textHandling('Company Name : ', widget.companyName.toString()),
//           ],
//         ),
//       ],
//       if (widget.dbOfficialWantToMeet != null) ...[
//         // CommonWidgets.verticalSpacerWidget(8),
//         Row(
//           children: [
//             Utils().textHandling('DB official want to meet : ',
//                 widget.dbOfficialWantToMeet.toString()),
//           ],
//         ),
//       ],
//       if (widget.visitPurpose != null) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling(
//                 'Purpose of visit: ', widget.visitPurpose?.name ?? ''),
//           ],
//         ),
//       ],
//       if (widget.dbOfficialDep != null) ...[
//         CommonWidgets.verticalSpacerWidget(5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Utils().textHandling(
//                 'DB Official Department: ', widget.dbOfficialDep?.name ?? ''),
//           ],
//         ),
//       ],
//     ];
//
//     for (Label label in labels ?? []) {
//       if (label.value == 'null' ||
//           label.value.isEmpty ||
//           isBasePopUpField == true) {
//         continue;
//       }
//       widgets.add(CommonWidgets.verticalSpacerWidget(5));
//       // widgets.add(Row(
//       //     children: [
//       //       textHandling('${label.key} : ', label.value, this.context),
//       //     ],
//       //   ),
//       // );
//       widgets.add(
//         Row(
//           children: [
//             Expanded(
//               child: textHandling('${label.key} : ', label.value, this.context),
//             ),
//           ],
//         ),
//       );
//     }
//     return widgets;
//   }
//
//   Widget textHandling(String title, String desc, BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Flexible(
//           flex: 2,
//           child: Text(
//             title,
//             softWrap: true,
//             style: Styles.textStyleNavigator,
//           ),
//         ),
//         const SizedBox(width: 4),
//         Flexible(
//           flex: 3,
//           child: Text(
//             desc,
//             softWrap: true,
//             style: Styles.textStyleNavigator600,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:db_atom/index.dart';

/// Theme tokens (matched to the "Select Locations" screen)
class _PopTheme {
  static const Color navy = Color(0xFF14086B);
  static const Color navyDark = Color(0xFF0B0450);
  static const Color navyMid = Color(0xFF1E0F8A);
  static const Color gold = Color(0xFFC49A6C);
  static const Color goldLight = Color(0xFFE6CFB0);
  static const Color pageBg = Color(0xFFF4F3FA);
  static const Color cardBorder = Color(0xFFDDDAF0);
  static const Color divider = Color(0xFFEDEBF7);
  static const Color chipBg = Color(0xFFF5EEE7);
  static const Color labelGrey = Color(0xFF7A76A6);
}

class BasePopUpItems extends StatefulWidget {
  final String? id;
  final String? slNo;
  final Organisation? location;
  final Organisation? locationRegion;
  final int? status;
  final String? inputDate;
  final String? entrySecurityName;
  final bool? returnable;
  final String? quantity;
  final String? challanNo;
  final String? vendor;
  final String? region;
  final int? guardCount;
  final int? mcNotSubmitted;
  final int? mcExpired;
  final int? photoNotSubmitted;
  final int? deploymentOrderPending;
  final int? pvcExpired;
  final int? msgbExempted;
  final int? msgbNotExempted;
  final int? msgbFormBNotSubmitted;
  final int? msgbFormBUnderProcess;
  final int? systemAccess;
  final int? trainingCertPending;
  final int? precPending;
  final int? precDoseCount;
  final int? ertCertified;
  final int? ertPending;
  final int? esicPending;
  final int? uanNoPending;
  final int? firstAidCertified;
  final int? firstAidNotCertified;
  final String? locationStr;
  final Organisation? locationEntity;
  final Organisation? locationRegionEntity;
  final int? dutyType;
  final List<Label>? labels;
  final bool? isMaterGuard;
  final int? guardRank;
  final int? dutyGuardRank;
  final int? gender;
  final int? maritalStatus;
  final bool isMasterGuard;
  final bool isAttendance;
  final bool? eventType;
  final bool isOccurrenceStatus;
  final bool isEventProtectionStatus;
  final String? epManager1Name;
  final bool isSLAViolationStatus;
  final bool? shiftBrfngAttnded;
  final bool? materialMovement;
  final bool? leoVisit;
  final User? handOverSecurity;
  final int? incidentType;
  final bool isIncident;
  final bool isContactDetailsStatus;
  final bool isSecuritySystemSLAStatus;
  final bool isKeyLossStatus;
  final bool isKeyManagementIssuanceStatus;
  final bool isKeyManagementStatus;
  final bool isVipStatus;
  final bool isMaterialMovementStatus;
  final bool isKeyManagementHistoryStatus;
  final bool isShiftScheduleStatus;
  final bool isDutyPostNameMasterStatus;
  final User? srh;
  final User? securityManager;
  final int? keyType;
  final int? type;
  final int? keyTagging;
  final String? keyNo;
  final String? doorName;
  final int? employeeType;
  final User? dbSponsorCWRT2;
  final User? handedOver;
  final String? returnedByName;
  final Organisation? department;
  final Organisation? vendors;
  final bool isPassManagementStatus;
  final String? passValidFrom;
  final String? passValidUntil;
  final String? companyName;
  final bool? sez;
  final bool isLawEnforcementStatus;
  final String? dbOfficialWantToMeet;
  final Organisation? visitPurpose;
  final Organisation? dbOfficialDep;
  final bool isArticleFoundStatus;
  final bool isWorkShift;
  final int? workShift;
  final bool isTicketStatus;
  final bool isTransportStatus;
  final bool isCSREventProtectionStatus;
  final bool isPatrollingStatus;
  final bool isDutyPostMasterStatus;
  final int? transportIncidentType;
  final bool isAttendanceStatus;
  final bool parkingStatus;

  @override
  State<BasePopUpItems> createState() => _BasePopUpItemsState();

  const BasePopUpItems({
    super.key,
    required this.id,
    this.slNo,
    this.location,
    this.locationRegion,
    this.quantity,
    this.status,
    this.inputDate,
    this.entrySecurityName,
    this.returnable,
    this.challanNo,
    this.region,
    this.vendor,
    this.guardCount,
    this.mcNotSubmitted,
    this.mcExpired,
    this.photoNotSubmitted,
    this.deploymentOrderPending,
    this.pvcExpired,
    this.msgbExempted,
    this.msgbNotExempted,
    this.msgbFormBNotSubmitted,
    this.msgbFormBUnderProcess,
    this.systemAccess,
    this.trainingCertPending,
    this.precPending,
    this.precDoseCount,
    this.ertCertified,
    this.ertPending,
    this.esicPending,
    this.uanNoPending,
    this.firstAidCertified,
    this.firstAidNotCertified,
    this.locationStr,
    this.dutyType,
    this.labels,
    this.isMaterGuard,
    this.guardRank,
    this.dutyGuardRank,
    this.gender,
    this.maritalStatus,
    this.locationEntity,
    this.locationRegionEntity,
    this.isMasterGuard = true,
    this.isAttendance = false,
    this.isIncident = false,
    this.eventType,
    this.isEventProtectionStatus = true,
    this.isOccurrenceStatus = false,
    this.epManager1Name,
    this.isSLAViolationStatus = false,
    this.shiftBrfngAttnded = false,
    this.materialMovement = false,
    this.isMaterialMovementStatus = false,
    this.leoVisit = false,
    this.isContactDetailsStatus = false,
    this.isSecuritySystemSLAStatus = false,
    this.isKeyLossStatus = false,
    this.isKeyManagementIssuanceStatus = false,
    this.isKeyManagementStatus = false,
    this.isVipStatus = false,
    this.isKeyManagementHistoryStatus = false,
    this.isDutyPostNameMasterStatus = false,
    this.isShiftScheduleStatus = false,
    this.handOverSecurity,
    this.incidentType,
    this.transportIncidentType,
    this.srh,
    this.keyType,
    this.type,
    this.securityManager,
    this.keyNo,
    this.keyTagging,
    this.doorName,
    this.employeeType,
    this.dbSponsorCWRT2,
    this.handedOver,
    this.department,
    this.returnedByName,
    this.vendors,
    this.isPassManagementStatus = false,
    this.passValidFrom,
    this.passValidUntil,
    this.companyName,
    this.sez,
    this.isLawEnforcementStatus = false,
    this.dbOfficialWantToMeet,
    this.visitPurpose,
    this.dbOfficialDep,
    this.isArticleFoundStatus = false,
    this.isWorkShift = false,
    this.workShift,
    this.isTicketStatus = false,
    this.isTransportStatus = false,
    this.isCSREventProtectionStatus = false,
    this.isPatrollingStatus = false,
    this.isDutyPostMasterStatus = false,
    this.isAttendanceStatus = false,
    this.parkingStatus = false,
  });
}

class _BasePopUpItemsState extends State<BasePopUpItems> {
  final bool isBasePopUpField = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final details = _buildDetails();
    final statuses = _buildStatusWidgets();

    return Center(
      child: Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Container(
            width: size.width - 32,
            constraints: BoxConstraints(maxHeight: size.height * 0.78),
            decoration: BoxDecoration(
              color: _PopTheme.pageBg,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: _PopTheme.navy.withValues(alpha: 0.25),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(context),
                // Gold divider bar under the header
                Container(
                  height: 4,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _PopTheme.gold,
                        _PopTheme.goldLight,
                        _PopTheme.gold,
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (details.isNotEmpty) _buildDetailsCard(details),
                        if (details.isNotEmpty && statuses.isNotEmpty)
                          const SizedBox(height: 14),
                        if (statuses.isNotEmpty) _buildStatusCard(statuses),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HEADER
  // ---------------------------------------------------------------------------
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 22, 16, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_PopTheme.navy, _PopTheme.navyDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          // Gold icon tile
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [_PopTheme.goldLight, _PopTheme.gold],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: _PopTheme.gold.withValues(alpha: 0.45),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.info_rounded, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'DETAILS',
                  style: TextStyle(
                    color: _PopTheme.goldLight,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ID : ${widget.id ?? '-'}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Round close button
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.12),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.35),
                  width: 1,
                ),
              ),
              child: const Icon(Icons.close_rounded,
                  color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // DETAILS CARD (white, rounded, soft border)
  // ---------------------------------------------------------------------------
  Widget _buildDetailsCard(List<MapEntry<String, String>> details) {
    final rows = <Widget>[];
    for (int i = 0; i < details.length; i++) {
      rows.add(_detailRow(details[i].key, details[i].value));
      if (i != details.length - 1) {
        rows.add(const Divider(
          height: 1,
          thickness: 1,
          color: _PopTheme.divider,
        ));
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _PopTheme.cardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: _PopTheme.navy.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(children: rows),
    );
  }

  Widget _detailRow(String label, String value) {
    final cleanLabel = label.replaceAll(RegExp(r'\s*:\s*$'), '').trim();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              cleanLabel,
              softWrap: true,
              style: const TextStyle(
                color: _PopTheme.labelGrey,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 6,
            child: Text(
              value.isEmpty ? '-' : value,
              softWrap: true,
              style: const TextStyle(
                color: _PopTheme.navy,
                fontSize: 14.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // STATUS CARD (navy, so the existing white-text Utils() status widgets
  // stay readable)
  // ---------------------------------------------------------------------------
  Widget _buildStatusCard(List<Widget> statuses) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [_PopTheme.navyMid, _PopTheme.navyDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: _PopTheme.navy.withValues(alpha: 0.25),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            // decoration: BoxDecoration(
            //   color: _PopTheme.chipBg,
            //   borderRadius: BorderRadius.circular(20),
            // ),
            // child: const Text(
            //   'STATUS',
            //   style: TextStyle(
            //     color: _PopTheme.gold,
            //     fontSize: 11.5,
            //     fontWeight: FontWeight.w800,
            //     letterSpacing: 1.5,
            //   ),
            // ),
          ),
          const SizedBox(height: 12),
          ...statuses,
        ],
      ),
    );
  }

  Widget _statusRow(Widget child, {bool wrapInRow = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: wrapInRow ? Row(children: [child]) : child,
    );
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

    if (widget.slNo != null && widget.slNo!.isNotEmpty) {
      add('Sl No : ', widget.slNo);
    }
    if (widget.locationRegion != null) {
      add('Region : ', widget.locationRegion?.name ?? ' ');
    }
    if (widget.location != null) {
      add('Location : ', widget.location?.name ?? ' ');
    }
    if (widget.locationRegionEntity != null) {
      add('Region : ', widget.locationRegionEntity?.name ?? ' ');
    }
    if (widget.locationEntity != null) {
      add('Building Location : ', widget.locationEntity?.name ?? '');
    }
    if (widget.srh != null) add('Srh : ', widget.srh?.name ?? '');
    if (widget.securityManager != null) {
      add('Security Manager : ', widget.securityManager?.name ?? '');
    }
    if (widget.keyNo != null && !widget.keyNo.isEmptyOrNull) {
      add('Key No : ', widget.keyNo);
    }
    if (widget.keyTagging != null) {
      add('Key Tagging Done : ', widget.keyTagging);
    }
    if (widget.doorName != null && !widget.doorName.isEmptyOrNull) {
      add('Key Description : ', widget.doorName);
    }
    if (widget.inputDate != null) {
      add(
        'Date Of Creation : ',
        Utils.timestampToDateConversion(
          int.tryParse(widget.inputDate ?? '0'),
          Constants.dateFormat,
        ),
      );
    }
    if (widget.vendors != null) add('Vendor : ', widget.vendors?.name ?? '');
    if (widget.locationStr != null) add('Location : ', widget.locationStr);
    if (widget.vendor != null) add('Vendor : ', widget.vendor);
    if (widget.region != null) add('Region : ', widget.region);
    if (widget.epManager1Name != null) {
      add('Event protection Manager 1 : ', widget.epManager1Name);
    }
    if (widget.eventType != null) {
      add('Event Type : ', widget.eventType == true ? 'Internal' : 'External');
    }

    // Staff counts
    add('Guard Count : ', widget.guardCount);
    add('Staff Medical Certificate Not Submitted : ', widget.mcNotSubmitted);
    add('Staff Medical Certificate Expired : ', widget.mcExpired);
    add('Staff Photograph Not Submitted : ', widget.photoNotSubmitted);
    add('Staff Deployment Order Not Submitted : ',
        widget.deploymentOrderPending);
    add('Staff PVC Expired : ', widget.pvcExpired);
    add('Staff MSGB Exempted : ', widget.msgbExempted);
    add('Staff MSGB Not Exempted : ', widget.msgbNotExempted);
    add('Staff MSGB Form B Not Exempted : ', widget.msgbFormBNotSubmitted);
    add('Staff MSGB Form B Under Process : ', widget.msgbFormBUnderProcess);
    add('Staff With System Access : ', widget.systemAccess);
    add('Staff Training Certificate Pending : ', widget.trainingCertPending);
    add('Staff Precaution Covid Dose Pending : ', widget.precPending);
    add('Staff Precaution Covid Dose Taken : ', widget.precDoseCount);
    add('Staff ERT Certified : ', widget.ertCertified);
    add('Staff ERT Pending : ', widget.ertPending);
    add('Staff ESIC Pending : ', widget.esicPending);
    add('Staff UAN Pending : ', widget.uanNoPending);
    add('Staff FirstAid Training Certified : ', widget.firstAidCertified);
    add('Staff FirstAid Training Pending : ', widget.firstAidNotCertified);

    if (widget.handOverSecurity != null) {
      add(
        'Shift Taken By : ',
        '${widget.handOverSecurity?.firstName ?? ''} ${widget.handOverSecurity?.lastName ?? ''}'
            .trim(),
      );
    }
    if (widget.dbSponsorCWRT2 != null &&
        !widget.dbSponsorCWRT2!.name.isEmptyOrNull) {
      add('Db Sponsor CWR T2 : ', widget.dbSponsorCWRT2?.name ?? '');
    }
    if (widget.handedOver != null) {
      add('Handed Over To : ', widget.handedOver?.name ?? '');
    }
    if (widget.department != null) {
      add('Department : ', widget.department?.name ?? '');
    }
    if (widget.returnedByName != null &&
        !widget.returnedByName.isEmptyOrNull) {
      add('Returned By : ', widget.returnedByName);
    }
    if (widget.passValidFrom != null) {
      add(
        widget.sez == true ? 'Pass Issued On : ' : 'Pass Valid From : ',
        Utils.timestampToDateConversion(
          int.tryParse(widget.passValidFrom ?? '0'),
          Constants.fulldateFormat,
        ),
      );
    }
    if (widget.passValidUntil != null) {
      add(
        'Pass Valid Until : ',
        Utils.timestampToDateConversion(
          int.tryParse(widget.passValidUntil ?? '0'),
          Constants.fulldateFormat,
        ),
      );
    }
    if (widget.companyName != null) {
      add('Company Name : ', widget.companyName);
    }
    if (widget.dbOfficialWantToMeet != null) {
      add('DB official want to meet : ', widget.dbOfficialWantToMeet);
    }
    if (widget.visitPurpose != null) {
      add('Purpose of visit : ', widget.visitPurpose?.name ?? '');
    }
    if (widget.dbOfficialDep != null) {
      add('DB Official Department : ', widget.dbOfficialDep?.name ?? '');
    }

    // Dynamic labels
    for (Label label in widget.labels ?? []) {
      if (label.value == 'null' ||
          label.value.isEmpty ||
          isBasePopUpField == true) {
        continue;
      }
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

    if (widget.keyType != null) {
      w.add(_statusRow(Utils().buildKeyType(widget.keyType ?? 0)));
    }
    if (widget.type != null) {
      w.add(_statusRow(Utils().buildType(widget.type ?? 0)));
    }
    if (s != null && widget.isMaterialMovementStatus == true) {
      w.add(_statusRow(Utils().buildMaterialMovementStatusRow(s)));
    }
    if (s != 0 && s != null && widget.isMasterGuard) {
      w.add(_statusRow(Utils().buildMasterDataStatusRow(s)));
    }
    if (widget.maritalStatus != 0 &&
        widget.maritalStatus != null &&
        widget.isMasterGuard) {
      w.add(_statusRow(Utils().buildMaritalStatus(widget.maritalStatus ?? 0)));
    }
    if (widget.guardRank != 0 &&
        widget.guardRank != null &&
        widget.isMasterGuard) {
      w.add(_statusRow(
          Utils().buildGuardRank(guardRank: widget.guardRank ?? 0)));
    }
    if (widget.dutyGuardRank != 0 &&
        widget.dutyGuardRank != null &&
        widget.isMasterGuard) {
      w.add(_statusRow(
          Utils().dutyGuardRank(dutyGuardRank: widget.dutyGuardRank ?? 0)));
    }
    if (widget.gender != 0 &&
        widget.gender != null &&
        widget.isMasterGuard) {
      w.add(_statusRow(Utils().buildGender(widget.gender ?? 0)));
    }
    if (widget.dutyType != 0 &&
        widget.dutyType != null &&
        widget.isMasterGuard) {
      w.add(_statusRow(Utils().buildDutyTypeRow(widget.dutyType ?? 0),
          wrapInRow: false));
    }
    if (s != null && widget.isKeyManagementIssuanceStatus == true) {
      w.add(_statusRow(Utils().keyManagementIssuanceStatus(s)));
    }
    if (s != null && widget.isKeyManagementHistoryStatus == true) {
      w.add(_statusRow(Utils().keyManagementMasterHistoryStatus(s)));
    }
    if (s != null && widget.isKeyManagementStatus == true) {
      w.add(_statusRow(Utils().keyManagementStatus(s)));
    }
    if (widget.dutyType != 0 &&
        widget.dutyType != null &&
        widget.isAttendance == true) {
      w.add(_statusRow(Utils().buildAttendanceDutyTypeRow(widget.dutyType ?? 0),
          wrapInRow: false));
    }
    if (widget.employeeType != null) {
      w.add(_statusRow(Utils().employeeTypeValues(widget.employeeType ?? 0)));
    }
    if (s != null && widget.isEventProtectionStatus && !widget.isMasterGuard) {
      w.add(_statusRow(Utils().buildEventProtectionStatusRow(s)));
    }
    if (s != null &&
        widget.isCSREventProtectionStatus &&
        !widget.isMasterGuard) {
      w.add(_statusRow(Utils().buildCSRProtectionStatusRow(s)));
    }
    if (s != null && widget.isAttendanceStatus && !widget.isMasterGuard) {
      w.add(_statusRow(Utils().buildAttendanceStatusRow(s)));
    }
    if (s != null &&
        !widget.isEventProtectionStatus &&
        widget.isSecuritySystemSLAStatus == true) {
      w.add(_statusRow(Utils().buildSecuritySystemStatusRow(s)));
    }
    if (s != null && widget.isKeyLossStatus == true) {
      w.add(_statusRow(Utils().keyLossDestructionStatus(s)));
    }
    if (widget.maritalStatus != null &&
        widget.isDutyPostNameMasterStatus == true) {
      w.add(_statusRow(
          Utils().dutyPostNameMasterStatus(widget.maritalStatus ?? 0)));
    }
    if (s != null && widget.isDutyPostMasterStatus == true) {
      w.add(_statusRow(Utils().dutyPostMasterStatus(s)));
    }
    if (widget.isTicketStatus == true && s != null) {
      w.add(_statusRow(Utils().buildTicketStatusRow(s)));
    }
    if (widget.parkingStatus == true && s != null) {
      w.add(_statusRow(Utils().parkingStatus(s)));
    }
    if (s != null && widget.isSLAViolationStatus == true) {
      w.add(_statusRow(Utils().buildSLAViolationStatus(s)));
    }
    if (s != null && widget.isOccurrenceStatus == true) {
      w.add(_statusRow(Utils().buildOccurrenceStatus(s)));
    }
    if (widget.shiftBrfngAttnded != null && widget.shiftBrfngAttnded == true) {
      w.add(_statusRow(
          Utils().shiftBrfngAttnded(widget.shiftBrfngAttnded ?? true)));
    }
    if (widget.materialMovement != null && widget.materialMovement == true) {
      w.add(_statusRow(
          Utils().materialMovement(widget.materialMovement ?? true)));
    }
    if (widget.leoVisit != null && widget.leoVisit == true) {
      w.add(_statusRow(Utils().leoVisit(widget.leoVisit ?? true)));
    }
    if (s != null && widget.isIncident) {
      w.add(_statusRow(Utils().buildIncidentStatus(s)));
    }
    if (s != null && widget.isTransportStatus) {
      w.add(_statusRow(Utils().transportMedicalStatus(s)));
    }
    if (s != null && widget.isPatrollingStatus) {
      w.add(_statusRow(Utils().patrollingStatus(s)));
    }
    if (s != null &&
        widget.isContactDetailsStatus == true &&
        widget.isEventProtectionStatus == false) {
      w.add(_statusRow(Utils().contactDetailsStatus(s)));
    }
    if (s != null &&
        widget.isPassManagementStatus == true &&
        widget.isEventProtectionStatus == false) {
      w.add(_statusRow(Utils().buildPassManagementStatusRow(s)));
    }
    if (s != null && widget.isLawEnforcementStatus == true) {
      w.add(_statusRow(Utils().buildLeoStatusRow(s)));
    }
    if (s != null && widget.isArticleFoundStatus == true) {
      w.add(_statusRow(Utils().buildFoundStatusRow(s)));
    }
    if (s != null && widget.isShiftScheduleStatus == true) {
      w.add(_statusRow(Utils().shiftScheduleStatusRow(s)));
    }
    if (widget.incidentType != null) {
      w.add(_statusRow(Utils().incidentType(widget.incidentType ?? 0)));
    }
    if (widget.transportIncidentType != null) {
      w.add(_statusRow(
          Utils().transportIncidentType(widget.transportIncidentType ?? 0)));
    }
    if (s != null && widget.isVipStatus == true) {
      w.add(_statusRow(Utils().vIPVisitorStatusRow(s)));
    }

    return w;
  }
}