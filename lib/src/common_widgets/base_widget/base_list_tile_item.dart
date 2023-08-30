import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/location.dart';
import '../../models/location_region.dart';

class BaseListTileItem extends StatefulWidget {
  final int? id;
  final Location? location;
  final bool? returnable;
  final LocationRegion? locationRegion;
  final String? inputDate;
  final int? status;
  final String? vendor;
  final String? region;
  final int? guardCount;
  final int? pvcExpired;
  final int? msgbExempted;
  final List<Label>? labels;
  final String? locationStr;
  final int? dutyType;
  final Function? onTap;
  final Function? onEditTap;
  final Function? onViewTap;
  final int? guardRank;

  // final Item userItem;
  final int? index;
  final bool? showEditButton;
  final bool? isMasterGuard;
  final bool? isStatus;

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
    this.locationStr,
    this.dutyType,
    this.labels,
    this.isMasterGuard,
    this.isStatus, this.guardRank,
  });

  @override
  State<BaseListTileItem> createState() => _BaseListTileItemState();
}

class _BaseListTileItemState extends State<BaseListTileItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
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
              padding: const EdgeInsets.all(20),
              child: Column(children: getChildren(widget.labels)),
            ),
          ),
        ),
        CommonWidgets.verticalSpacerWidget(5),
      ],
    );
  }

  List<Widget> getChildren(List<Label>? labels) {
    List<Widget> widgets = [];

    widgets = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Utils().textHandling('ID : ', widget.id.toString()),
          Container(
            alignment: Alignment.topCenter,
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
        ],
      ),
      if (widget.locationRegion != null) ...[
        Row(
          children: [
            Utils()
                .textHandling('Region : ', widget.locationRegion?.name ?? ''),
          ],
        ),
      ],
      if (widget.locationStr != null) ...[
        CommonWidgets.verticalSpacerWidget(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Utils().textHandling('Loaction : ', widget.locationStr.toString()),
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
      if (widget.guardRank != null) ...[
        CommonWidgets.verticalSpacerWidget(5),
        Utils().buildGuardrank(widget.guardRank ?? 0),
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
      if (widget.location != null) ...[
        CommonWidgets.verticalSpacerWidget(5),
        Row(
          children: [
            Utils().textHandling('Location : ', widget.location?.name ?? ''),
          ],
        ),
      ],
      if (widget.returnable != null) ...[
        CommonWidgets.verticalSpacerWidget(5),
        Row(
          children: [
            Utils().textHandling('Material Movement Type : ',
                widget.returnable == true ? 'Returnable' : 'Not Returnable'),
          ],
        ),
      ],
      if (widget.inputDate != null) ...[
        CommonWidgets.verticalSpacerWidget(5),
        Row(
          children: [
            Utils().textHandling(
                'Date: ',
                widget.inputDate != null
                    ? Utils.timestamptoDateConversion(
                        int.parse(widget.inputDate ?? '0'),
                        Constants.dateFormat)
                    : ''),
          ],
        ),
      ],
      if (widget.isStatus != null) ...[
        CommonWidgets.verticalSpacerWidget(5),
        Utils().buildStatusRow(widget.status ?? 0),
      ],
      if (widget.isMasterGuard != null) ...[
        CommonWidgets.verticalSpacerWidget(5),
        Utils().buildMasterDataStatusRow(widget.status ?? 0),
      ],
      if (widget.dutyType != null) ...[
        CommonWidgets.verticalSpacerWidget(5),
        Utils().buildDutyTypeRow(widget.dutyType ?? 0),
      ],
    ];

    for (Label label in labels ?? []) {
      if (label.value == "null") {
        continue;
      }
      widgets.add(CommonWidgets.verticalSpacerWidget(5));
      widgets.add(Row(
        children: [
          Utils().textHandling('${label.key} : ', label.value),
        ],
      ));
    }
    return widgets;
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
