import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';

import '../../features/material_movement/models/material_movements_model.dart';

class BasePopUpItems extends StatefulWidget {
  final String? id;
  final String? slNo;
  final Location? location;
  final LocationRegion? locationRegion;
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
  });
}

class _BasePopUpItemsState extends State<BasePopUpItems> {
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
        height: height / 1.7,
        width: width - 40,
        child:
            // Row(
            //  children: [
            SingleChildScrollView(
                child: Column(children: [
          Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child:
                      SvgPicture.asset(AppIcon.closeicon) //Icon(Icons.cancel)
                  )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Utils().textHandling('ID : ', widget.id.toString()),
            ],
          ),
          if (widget.slNo != null) ...[
            CommonWidgets.verticalSpacerWidget(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Utils().textHandling('Sl No : ', widget.slNo.toString()),
              ],
            ),
          ],
          if (widget.locationRegion != null) ...[
            CommonWidgets.verticalSpacerWidget(8),
            Row(
              children: [
                Utils().textHandling(
                    'Region : ', widget.locationRegion?.name ?? " "),
              ],
            ),
          ],
          if (widget.locationRegion != null) ...[
            CommonWidgets.verticalSpacerWidget(8),
            Row(
              children: [
                Utils()
                    .textHandling('Location : ', widget.location?.name ?? " "),
              ],
            ),
          ],
          if (widget.returnable != null) ...[
            CommonWidgets.verticalSpacerWidget(8),
            Row(
              children: [
                Utils().textHandling(
                    'Material Movement Type : ',
                    widget.returnable == true
                        ? 'Returnable'
                        : 'Not Returnable'),
              ],
            ),
          ],
          if (widget.challanNo != null) ...[
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
          if (widget.status != null) ...[
            CommonWidgets.verticalSpacerWidget(5),
            Utils().buildStatusRow(widget.status ?? 0),
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
          if (widget.guardCount != null) ...[
            CommonWidgets.verticalSpacerWidget(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Utils().textHandling(
                    'Guard Count : ', widget.guardCount.toString()),
              ],
            ),
          ],
          if (widget.mcNotSubmitted != null) ...[
            CommonWidgets.verticalSpacerWidget(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Utils().textHandling(
                    'Total No of Staff MedicalCertificate Not Submitted : ',
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
                    'Total No of Staff MedicalCertificate Expired : ',
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
                    'Total No of Staff Photograph Not Submitted : ',
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
                    'Total No of Staff DeplyomentOrder Not Submitted : ',
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
        ])),
      ),
    );
  }
}
