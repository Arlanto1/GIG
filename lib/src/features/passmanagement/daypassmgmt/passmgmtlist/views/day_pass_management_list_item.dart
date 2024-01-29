import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/models/day_passlist_model.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DayPassManagementListItem extends StatefulWidget {
  final Function? onTap;
  final Function? onEditTap;
  final Function? onViewTap;
  final DayPassListElement userItem;
  final int? index;

  const DayPassManagementListItem({
    super.key,
    this.onTap,
    this.onEditTap,
    this.onViewTap,
    required this.userItem,
    this.index,
  });

  @override
  State<DayPassManagementListItem> createState() =>
      _DayPassManagementListItemState();
}

class _DayPassManagementListItemState extends State<DayPassManagementListItem> {
  Widget textHandling(String title, String desc) {
    return Expanded(
      child: RichText(
        text: TextSpan(
          // Note: Styles for TextSpans must be explicitly defined.
          // Child text spans will inherit styles from parent
          style: Styles.textStyleRegularNormalGrey14,
          children: <TextSpan>[
            TextSpan(text: title),
            TextSpan(
              text: desc,
              style: Styles.textStyleBoldGrey14,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              side:
                  const BorderSide(color: AppColors.searchBarBorder, width: 1),
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
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textHandling('ID : ', widget.userItem.id.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          textHandling(
                              'Region : ',
                              (widget.userItem.locationRegion?.name ?? '')
                                  .toString()),
                        ],
                      ),
                      CommonWidgets.verticalSpacerWidget(5),
                      Row(
                        children: [
                          textHandling(
                              'Location : ',
                              (widget.userItem.location?.name ?? '')
                                  .toString()),
                        ],
                      ),
                      CommonWidgets.verticalSpacerWidget(5),
                      Row(
                        children: [
                          textHandling(
                              'Date of creation : ',
                              widget.userItem.inputDate != null
                                  ? Utils.timestamptoDateConversion(
                                      int.parse(
                                          widget.userItem.inputDate ?? '0'),
                                      Constants.dateFormat)
                                  : ''),
                        ],
                      ),
                      CommonWidgets.verticalSpacerWidget(5),
                      Row(
                        children: [
                          Utils().buildPassManagementStatusRow(
                              widget.userItem.status ?? 0),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                //do action on view
                                widget.onEditTap != null
                                    ? widget.onEditTap!(widget.index)
                                    : null;
                              },
                              icon: widget.userItem.status == 0 ||
                                      widget.userItem.status == 1 ||
                                      widget.userItem.status == 3
                                  ? const Icon(Icons.edit)
                                  : const Icon(Icons.edit_off_outlined),
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
                    ])))),
        CommonWidgets.verticalSpacerWidget(5),
      ],
    );
  }
}
