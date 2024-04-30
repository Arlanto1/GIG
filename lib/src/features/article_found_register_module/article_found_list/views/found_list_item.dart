// Created by Ramesh

import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FoundListItem extends StatefulWidget {
  final Function? onTap;
  final Function? onEditTap;
  final Function? onViewTap;
  final FoundModel userItem;
  final int? index;
  final List<Label>? labels;

  const FoundListItem({
    super.key,
    this.onTap,
    this.onEditTap,
    this.onViewTap,
    required this.userItem,
    this.index,
    this.labels,
  });

  @override
  State<FoundListItem> createState() => _FoundListItemState();
}

class _FoundListItemState extends State<FoundListItem> {
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

  List<Widget> getChildren(List<Label>? labels, double width) {
    List<Widget> widgets = [];

    widgets = [
      SizedBox(
        width: width > 389 ? width * .78 : width * .55,
        child: Wrap(
          children: [
            IntrinsicWidth(
              stepWidth: width * .6,
              child: Wrap(
                children: [
                  Utils().textHandling('ID : ', widget.userItem.id.toString()),
                  CommonWidgets.horizontalSpacerWidget(5),
                  Utils().buildFoundStatusRow(widget.userItem.status ?? 0),
                  Row(
                    children: [
                      Utils().textHandling(
                          'Region : ',
                          widget.userItem.locationRegion?.name ?? ''),
                    ],
                  ),
                  if (widget.userItem.inputDate != null) ...[
                    CommonWidgets.verticalSpacerWidget(5),
                    Row(
                      children: [
                        if (widget.userItem.foundLocation != null) ...[
                          Utils().textHandling(
                              'Location : ',
                              widget.userItem.location?.name ?? ''),
                        ],
                        CommonWidgets.horizontalSpacerWidget(5),
                        Utils().textHandling(
                            'Date : ',
                            widget.userItem.inputDate != null
                                ? Utils.timestampToDateConversion(
                                    int.tryParse(
                                        widget.userItem.inputDate ?? '0'),
                                    Constants.dateFormat)
                                : ''),
                      ],
                    ),
                  ],
                  // if (widget.userItem.foundDate != null) ...[
                  //   CommonWidgets.verticalSpacerWidget(5),
                  //   Row(
                  //     children: [
                  //       Utils().textHandling(
                  //           'Found Date : ',
                  //           widget.userItem.foundDate != null
                  //               ? Utils.timestamptoDateConversion(
                  //                   int.tryParse(
                  //                       widget.userItem.foundDate ?? '0'),
                  //                   Constants.dateFormat)
                  //               : ''),
                  //     ],
                  //   ),
                  // ],
                  // ],
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
            IconButton(
              onPressed: () {
                //do action on view
                widget.onEditTap != null
                    ? widget.onEditTap!(widget.index)
                    : null;
              },
              icon: widget.userItem.status == 2 || widget.userItem.status == -1
                  ? const Icon(Icons.edit_off_outlined)
                  : const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                //do action on view
                widget.onViewTap != null
                    ? widget.onViewTap!(widget.index)
                    : null;
              },
              icon: const Icon(Icons.remove_red_eye),
            ),
          ],
        ),
      ),
    ];

    return widgets;
  }
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

class Label {
  final String key;
  final String value;

  const Label({
    required this.key,
    required this.value,
  });
}
