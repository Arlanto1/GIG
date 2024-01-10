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
  final bool isContactDetailsStatus;
  final bool isSecuritySystemSLA;
  final bool isKeyLossStatus;
  final bool isKeyManagementStatus;
  final bool isKeyManagementIssuanceStatus;
  final bool isVipStatus;
  final bool isMaterialMovementStatus;

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
    this.isContactDetailsStatus = false,
    this.isSecuritySystemSLA = false,
    this.isKeyLossStatus = false,
    this.isKeyManagementStatus = false,
    this.isKeyManagementIssuanceStatus = false,
    this.isVipStatus = false,
    this.isMaterialMovementStatus = false,
    this.onDeleteTap,
  });

  @override
  State<BaseListTileItem> createState() => _BaseListTileItemState();
}

class _BaseListTileItemState extends State<BaseListTileItem> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
      Wrap(
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.spaceBetween,
        children: [
          SizedBox(
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
                            Utils().textHandling(
                                'Region : ', widget.locationRegion?.name ?? ''),
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
                      if ((widget.status != null || widget.isMaterialMovementStatus == true) &&
                          !widget.isMasterGuard
                          ) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Utils()
                            .buildMaterialMovementStatusRow(widget.status ?? 0),
                      ],
                      if (widget.guardRank != 0 && widget.isMasterGuard) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Utils().buildGuardrank(widget.guardRank ?? 0),
                      ],
                      if (widget.status != 0 && widget.isMasterGuard) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Utils().buildMasterDataStatusRow(widget.status ?? 0),
                      ],
                      if (widget.status != null &&
                          widget.isEventProtectionStatus &&
                          !widget.isMasterGuard) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Utils()
                            .buildEventProtectionStatusRow(widget.status ?? 0),
                      ],
                      if (widget.status != null &&
                          widget.isKeyManagementIssuanceStatus) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Utils().keyManagementIssuanceStatus(widget.status ?? 0),
                      ],
                      if (widget.status != null &&
                          widget.isKeyManagementStatus) ...[
                        CommonWidgets.horizontalSpacerWidget(5),
                        Utils().keyManagementStatus(widget.status ?? 0),
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
                    ],
                  ),
                ),
                getLabelWidgets(labels),
              ],
            ),
          ),
          IntrinsicWidth(
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
                    icon: const Icon(Icons.edit),
                  ),
                ],
                IconButton(
                  onPressed: () {
                    //do action on view
                    widget.onViewTap != null
                        ? widget.onViewTap!(widget.index)
                        : null;
                  },
                  icon: const Icon(Icons.remove_red_eye),
                ),
                if (widget.onDeleteTap != null) ...[
                  IconButton(
                    onPressed: () {
                      //do action on view
                      widget.onDeleteTap != null
                          ? widget.onDeleteTap!(widget.index)
                          : null;
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ],
            ),
          ),
        ],
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
