// Created by Ramesh

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/article_found_register_module/article_found_list/bloc/article_found_bloc.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';

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
    ArticleFoundState state = const ArticleFoundState();

    widgets = [
      SizedBox(
        width: width > 389 ? width * .78 : width * .55,
        child: Wrap(
          children: [
            IntrinsicWidth(
              stepWidth: width * .6,
              child: Wrap(
                children: [
                  Utils().textHandling('${Constants.id}: ', widget.userItem.id.toString()),
                  CommonWidgets.horizontalSpacerWidget(5),
                  Utils().buildFoundStatusRow(widget.userItem.status ?? 0),
                  Row(
                    children: [
                      if (widget.userItem.locationRegion?.name != null) ...[
                        Utils().textHandling('${Constants.region}: ',
                            widget.userItem.locationRegion?.name ?? ''),
                      ],
                    ],
                  ),
                  CommonWidgets.verticalSpacerWidget(5),
                  Row(
                    children: [
                      if (widget.userItem.location?.name != null) ...[
                        Utils().textHandling('${Constants.location}: ',
                            widget.userItem.location?.name ?? ''),
                      ],
                      CommonWidgets.horizontalSpacerWidget(5),
                      if (!(widget.userItem.foundDate.isEmptyOrNull)) ...[
                        Utils().textHandling(
                            '${Constants.founddate}: ',
                            widget.userItem.foundDate != null
                                ? Utils.timestampToDateConversion(
                                    int.tryParse(
                                        widget.userItem.foundDate ?? '0'),
                                    Constants.dateFormat)
                                : ''),
                      ],
                    ],
                  ),
                  Row(
                    children: [
                      if (widget.userItem.entrySecurity != null) ...[
                        Utils().textHandling('${Constants.createdby}: ',
                            ('${widget.userItem.entrySecurity?.firstName ?? ''} ${widget.userItem.entrySecurity?.lastName ?? ''}')),
                      ],
                    ],
                  ),
                  //],
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
