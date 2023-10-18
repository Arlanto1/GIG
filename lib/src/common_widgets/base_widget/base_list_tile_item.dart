import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/organisation.dart';

class BaseListTileItem extends StatefulWidget {
  final int? id;
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
  final int? incidentType;
  final bool isIncident;

  // final Item userItem;
  final int? index;
  final bool? showEditButton;
  final bool isMasterGuard;
  final bool? isMasterGuardRank;
  final bool isEventProtectionStatus;
  final bool isOccurrenceStatus;
  final bool isSLAViolationStatus;

  const BaseListTileItem({
    super.key,
    this.id,
    this.location,
    this.locationRegion,
    this.inputDate,
    this.status,
    this.onTap,
    this.onEditTap,
    this.onViewTap,
    this.index,
    this.region,
    this.vendor,
    this.guardCount,
    this.pvcExpired,
    this.msgbExempted,
    this.returnable,
    this.showEditButton = true,
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
  });

  @override
  State<BaseListTileItem> createState() => _BaseListTileItemState();
}

class _BaseListTileItemState extends State<BaseListTileItem> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.searchBarBorder, width: 1),
          borderRadius: circularBorderRadius10,
        ),
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            widget.onTap != null ? widget.onTap!(widget.index) : null;
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Wrap(children: getChildren(widget.labels, width)),
          ),
        ),
      ),
    );
  }

  List<Widget> getChildren(List<Label>? labels, width) {
    List<Widget> widgets = [];

    // log('--width------$width-------tab--${width * .78}---------------${width / 2}-');

    widgets = [
      Container(
        // color: Colors.blue,
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          runAlignment: WrapAlignment.spaceBetween,
          children: [
            Container(
              // color: Colors.purpleAccent,
              child: SizedBox(
                width: width > 389 ? width * .78 : width * .55,
                // height: 90,
                child: Wrap(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IntrinsicWidth(
                      stepWidth: width * .6,
                      child: Wrap(
                        children: [
                          Utils().textHandling('ID : ', widget.id.toString()),
                          if (widget.locationRegion != null) ...[
                            Row(
                              children: [
                                Utils().textHandling('Region : ',
                                    widget.locationRegion?.name ?? ''),
                              ],
                            ),
                          ],
                          if (widget.locationStr != null) ...[
                            CommonWidgets.horizontalSpacerWidget(5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Utils().textHandling('Location : ',
                                    widget.locationStr.toString()),
                              ],
                            ),
                          ],
                          if (widget.guardCount != null) ...[
                            CommonWidgets.horizontalSpacerWidget(5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Utils().textHandling('Guard Count : ',
                                    widget.guardCount.toString()),
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
                          if (widget.status != null &&
                              !widget.isMasterGuard &&
                              !widget.isOccurrenceStatus &&
                              !widget.isEventProtectionStatus &&
                              !widget.isSLAViolationStatus &&
                              !widget.isIncident) ...[
                            CommonWidgets.horizontalSpacerWidget(5),
                            Utils().buildStatusRow(widget.status ?? 0),
                          ],
                          if (widget.guardRank != 0 &&
                              widget.isMasterGuard) ...[
                            CommonWidgets.horizontalSpacerWidget(5),
                            Utils().buildGuardrank(widget.guardRank ?? 0),
                          ],
                          if (widget.status != 0 && widget.isMasterGuard) ...[
                            CommonWidgets.horizontalSpacerWidget(5),
                            Utils()
                                .buildMasterDataStatusRow(widget.status ?? 0),
                          ],
                          if (widget.status != null &&
                              widget.isEventProtectionStatus &&
                              !widget.isMasterGuard) ...[
                            CommonWidgets.horizontalSpacerWidget(5),
                            Utils().buildEventProtectionStatusRow(
                                widget.status ?? 0),
                          ],
                          if (widget.status != null &&
                              widget.isOccurrenceStatus == true) ...[
                            CommonWidgets.horizontalSpacerWidget(5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Utils()
                                    .buildOccurrenceStatus(widget.status ?? 0),
                              ],
                            ),
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
                        ],
                      ),
                    ),
                    getLabelWidgets(labels),
                  ],
                ),
              ),
            ),
            Container(
              // color: Colors.yellow,
              child: IntrinsicWidth(
                child: Row(
                  children: [
                    if (widget.showEditButton ?? true) ...[
                      IconButton(
                        onPressed: () {
                          //do action on view
                          widget.onEditTap != null
                              ? widget.onEditTap!(widget.index)
                              : null;
                        },
                        icon: SvgPicture.asset(AppIcon.editIcon),
                      ),
                    ],
                    IconButton(
                      onPressed: () {
                        //do action on view
                        widget.onViewTap != null
                            ? widget.onViewTap!(widget.index)
                            : null;
                      },
                      icon: SvgPicture.asset(AppIcon.viewIcon),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ];

    return widgets;
  }

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
