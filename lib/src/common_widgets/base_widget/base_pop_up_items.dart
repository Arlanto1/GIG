import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/models/entity.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';

import '../../features/createfound/models/user.dart';
import '../../models/organisation.dart';
import 'base_list_tile_item.dart';

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
  final Entity? locationEntity;
  final Entity? locationRegionEntity;
  final int? dutyType;
  final List<Label>? labels;
  final bool? isMaterGuard;
  final int? guardRank;
  final int? gender;
  final int? maritalStatus;
  final bool isMasterGuard;
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
    this.gender,
    this.maritalStatus,
    this.locationEntity,
    this.locationRegionEntity,
    this.isMasterGuard = true,
    this.isIncident = false,
    this.eventType,
    this.isEventProtectionStatus = true,
    this.isOccurrenceStatus = false,
    this.epManager1Name,
    this.isSLAViolationStatus = false,
    this.shiftBrfngAttnded = false,
    this.materialMovement = false,
    this.leoVisit = false,
    this.handOverSecurity,
    this.incidentType,
  });
}

class _BasePopUpItemsState extends State<BasePopUpItems> {
  final bool isBasePopUpField = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const ShapeDecoration(
            color: AppColors.backgroundWhitecolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            )),
        // color: Colors.white,
        height: height / 1.8,
        width: width -10,
        child:
            // Row(
            //  children: [
            SingleChildScrollView(
          child: Column(
            children: getChildren(context, widget.labels),
          ),
        ),
      ),
    );
  }

  List<Widget> getChildren(BuildContext context, List<Label>? labels) {
    List<Widget> widgets = [];

    widgets = [
      Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(AppIcon.closeicon) //Icon(Icons.cancel)
            ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Utils().textHandling('ID : ', widget.id.toString()),
        ],
      ),
    if (widget.slNo != null && widget.slNo!.isNotEmpty) ...[
      Row(
    children: [
        CommonWidgets.verticalSpacerWidget(8),
        Utils().textHandling('Sl No : ', widget.slNo.toString()),
      ],
      ),
      ],
      if (widget.locationRegion != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          children: [
            Utils()
                .textHandling('Region : ', widget.locationRegion?.name ?? " "),
          ],
        ),
      ],
      if (widget.locationRegionEntity != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          children: [
            Utils().textHandling(
                'Region : ', widget.locationRegionEntity?.name ?? " "),
          ],
        ),
      ],
      if (widget.locationEntity != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling(
                'Building Loaction : ', widget.locationEntity?.name ?? ''),
          ],
        ),
      ],
      if (widget.challanNo != null && widget.challanNo!.isNotEmpty) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling('Challan/Invoice Nos/Gate Pass : ',
                widget.challanNo.toString()),
          ],
        ),
      ],
      if (widget.quantity != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling('Quantity : ', widget.quantity.toString()),
          ],
        ),
      ],
      if (widget.inputDate != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          children: [
            Utils().textHandling(
                'DateOfCreation : ',
                widget.inputDate != null
                    ? Utils.timestamptoDateConversion(
                        int.parse(widget.inputDate ?? '0'),
                        Constants.dateFormat)
                    : ''),
          ],
        ),
      ],
      if (widget.entrySecurityName != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          children: [
            Utils().textHandling(
                'Created By : ', widget.entrySecurityName.toString()),
          ],
        ),
      ],
      if (widget.status != null &&
          !widget.isMasterGuard &&
          !widget.isOccurrenceStatus &&
          !widget.isEventProtectionStatus &&
          !widget.isSLAViolationStatus && !widget.isIncident) ...[
        CommonWidgets.verticalSpacerWidget(5),
    Row(
    children: [
        Utils().buildStatusRow(widget.status ?? 0),
    ],),
      ],
      if (widget.status != 0 &&
          widget.status != null &&
          widget.isMasterGuard) ...[
        Row(
          children: [
            CommonWidgets.verticalSpacerWidget(5),
            Utils().buildMasterDataStatusRow(widget.status ?? 0),
          ],
        ),
      ],
      if (widget.maritalStatus != 0 &&
          widget.maritalStatus != null &&
          widget.isMasterGuard) ...[
        Row(
          children: [
            CommonWidgets.verticalSpacerWidget(5),
            Utils().buildMaritalStatus(widget.maritalStatus ?? 0),
          ],
        ),
      ],
      if (widget.guardRank != 0 &&
          widget.guardRank != null &&
          widget.isMasterGuard) ...[
        CommonWidgets.verticalSpacerWidget(5),
        Row(
          children: [
            Utils().buildGuardrank(widget.guardRank ?? 0),
          ],
        ),
      ],
      if (widget.gender != 0 &&
          widget.gender != null &&
          widget.isMasterGuard) ...[
        CommonWidgets.verticalSpacerWidget(5),
        Row(
          children: [
            Utils().buildGender(widget.gender ?? 0),
          ],
        ),
      ],
      if (widget.dutyType != 0 &&
          widget.dutyType != null &&
          widget.isMasterGuard) ...[
        CommonWidgets.verticalSpacerWidget(5),
        Utils().buildDutyTypeRow(widget.dutyType ?? 0),
      ],
      if (widget.locationStr != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling('Location : ', widget.locationStr.toString()),
          ],
        ),
      ],
      if (widget.vendor != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          children: [
            Utils().textHandling('Vendor : ', widget.vendor.toString()),
          ],
        ),
      ],
      if (widget.region != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          children: [
            Utils().textHandling('Region : ', widget.region.toString()),
          ],
        ),
      ],
      if (widget.epManager1Name != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          children: [
            Utils().textHandling('Event protection Manager 1 : ',
                widget.epManager1Name.toString()),
          ],
        ),
      ],
      if (widget.eventType != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          children: [
            Utils().textHandling('Event Type : ',
                widget.eventType == true ? 'Internal' : 'External'),
          ],
        )
      ],
      if (widget.status != null &&
          widget.isEventProtectionStatus &&
          !widget.isMasterGuard) ...[
        CommonWidgets.verticalSpacerWidget(5),
        Row(
          children: [
            Utils().buildEventProtectionStatusRow(widget.status ?? 0),
          ],
        ),
      ],
      if (widget.guardCount != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils()
                .textHandling('Guard Count : ', widget.guardCount.toString()),
          ],
        ),
      ],
      if (widget.mcNotSubmitted != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling(
                'Total No of Staff MedicalCertificate Not Submitted:',
                widget.mcNotSubmitted.toString()),
          ],
        ),
      ],
      if (widget.mcExpired != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling(
                'Total No of Staff MedicalCertificate Expired:',
                widget.mcExpired.toString()),
          ],
        ),
      ],
      if (widget.photoNotSubmitted != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling(
                'Total No of Staff Photograph Not Submitted :',
                widget.photoNotSubmitted.toString()),
          ],
        ),
      ],
      if (widget.deploymentOrderPending != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling(
                'Total No of Staff DeplyomentOrder Not Submitted:',
                widget.deploymentOrderPending.toString()),
          ],
        ),
      ],
      if (widget.pvcExpired != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling('Total No of Staff PVC Expired : ',
                widget.pvcExpired.toString()),
          ],
        ),
      ],
      if (widget.msgbExempted != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling('Total No of Staff MSGB Exempted : ',
                widget.msgbExempted.toString()),
          ],
        ),
      ],
      if (widget.msgbNotExempted != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling('Total No of Staff MSGB Not Exempted : ',
                widget.msgbNotExempted.toString()),
          ],
        ),
      ],
      if (widget.msgbFormBNotSubmitted != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling(
                'Total No of Staff MSGB Form B Not Exempted : ',
                widget.msgbFormBNotSubmitted.toString()),
          ],
        ),
      ],
      if (widget.msgbFormBUnderProcess != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling(
                'Total No of Staff MSGB Form B Under Process : ',
                widget.msgbFormBUnderProcess.toString()),
          ],
        ),
      ],
      if (widget.systemAccess != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling('Total No of Staff With System Access : ',
                widget.systemAccess.toString()),
          ],
        ),
      ],
      if (widget.trainingCertPending != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling(
                'Total No of Staff Training Certificate Pending : ',
                widget.trainingCertPending.toString()),
          ],
        ),
      ],
      if (widget.precPending != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling(
                'Total No of Staff Precaution Covid Dose Pending : ',
                widget.precPending.toString()),
          ],
        ),
      ],
      if (widget.precDoseCount != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling(
                'Total No of Staff Precaution Covid Dose Taken  : ',
                widget.precDoseCount.toString()),
          ],
        ),
      ],
      if (widget.ertCertified != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling('Total No of Staff ERT Certified  : ',
                widget.ertCertified.toString()),
          ],
        ),
      ],
      if (widget.ertPending != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling('Total No of Staff ERT Pending  : ',
                widget.ertPending.toString()),
          ],
        ),
      ],
      if (widget.esicPending != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling('Total No of Staff ESIC Pending  : ',
                widget.esicPending.toString()),
          ],
        ),
      ],
      if (widget.uanNoPending != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling('Total No of Staff UAN Pending  : ',
                widget.uanNoPending.toString()),
          ],
        ),
      ],
      if (widget.firstAidCertified != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling(
                'Total No of Staff FirstAid Training Certified  : ',
                widget.firstAidCertified.toString()),
          ],
        ),
      ],
      if (widget.status != null && widget.isSLAViolationStatus == true) ...[
        CommonWidgets.horizontalSpacerWidget(5),
        Utils().buildSLAViolationStatus(widget.status ?? 0),
      ],
      if (widget.firstAidNotCertified != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling(
                'Total No of Staff FirstAid Training Pending  : ',
                widget.firstAidNotCertified.toString()),
          ],
        ),
      ],
      if (widget.status != null && widget.isOccurrenceStatus == true) ...[
        CommonWidgets.horizontalSpacerWidget(28),
        Utils().buildOccurrenceStatus(widget.status ?? 0),
      ],

      if(widget.shiftBrfngAttnded !=null && widget.shiftBrfngAttnded == true)...[
      CommonWidgets.verticalSpacerWidget(5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Utils().shiftBrfngAttnded(widget.shiftBrfngAttnded ?? true),
        ],
      ),
    ],
    if(widget.materialMovement !=null && widget.materialMovement == true)...[
      CommonWidgets.verticalSpacerWidget(5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Utils().materialMovement(widget.materialMovement ?? true),
        ],
      ),
      ],
      if(widget.leoVisit !=null && widget.leoVisit == true)...[
      CommonWidgets.verticalSpacerWidget(5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Utils().leoVisit(widget.leoVisit ?? true),
        ],
      ),
    ],
      if (widget.handOverSecurity != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling(
                'Shift Taken By : ', widget.handOverSecurity.toString()),
          ],
        ),
      ],


      if(widget.status !=null && widget.isIncident ==true)...[
        CommonWidgets.verticalSpacerWidget(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().buildIncidentStatus(widget.status ?? 0),
          ],
        ),
      ],

      if(widget.incidentType !=null)...[
        CommonWidgets.verticalSpacerWidget(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().incidentType(widget.incidentType ?? 0),
          ],
        ),
      ],
    ];

    for (Label label in labels ?? []) {
      if (label.value == 'null' ||
          label.value.isEmpty ||
          isBasePopUpField == true) {
        continue;
      }
      widgets.add(CommonWidgets.verticalSpacerWidget(5));
      widgets.add(
        Row(
          children: [
            Utils().textHandling('${label.key} : ', label.value),
          ],
        ),
      );
    }
    return widgets;
  }
}
