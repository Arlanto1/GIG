import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../features/material_movement/models/material_movements_model.dart';

class BaseListTileItem extends StatefulWidget {
  final int? id;
  final Location? location;
  final LocationRegion? locationRegion;
  final String? inputDate;
  final int? status;

  final Function? onTap;
  final Function? onEditTap;
  final Function? onViewTap;

  // final Item userItem;
  final int? index;

  const BaseListTileItem(
      {super.key,
      this.id,
      this.location,
      this.locationRegion,
      this.inputDate,
      this.status,
      this.onTap,
      this.onEditTap,
      this.onViewTap,
      this.index});

  // const BaseListTileItem({
  //   Key? key,
  //   this.onTap,
  //   this.onEditTap,
  //   this.onViewTap,
  //   // required this.userItem,
  //   this.index,
  // }) : super(key: key);

  @override
  State<BaseListTileItem> createState() => _BaseListTileItemState();
}

class _BaseListTileItemState extends State<BaseListTileItem> {
  Widget textHandling(String title, String desc) {
    return Expanded(
      child: RichText(
        text: TextSpan(
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
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textHandling('ID : ', widget.id.toString()),
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
                            icon: SvgPicture.asset(AppIcon.editIcon),
                          ),
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
                Row(
                  children: [
                    textHandling(
                        'Region : ', widget.locationRegion?.name ?? ''),
                  ],
                ),
                CommonWidgets.verticalSpacerWidget(5),
                Row(
                  children: [
                    textHandling('Location : ', widget.location?.name ?? ''),
                  ],
                ),
                CommonWidgets.verticalSpacerWidget(5),
                Row(
                  children: [
                    textHandling(
                        'Date: ',
                        widget.inputDate != null
                            ? Utils.timestamptoDateConversion(
                                int.parse(widget.inputDate ?? '0'),
                                Constants.dateFormat)
                            : ''),
                  ],
                ),
                CommonWidgets.verticalSpacerWidget(5),
                if(widget.status != null)...[
                Row(
                  children: [
                    Text(
                      'Status : ${widget.status}',
                      style: Styles.textStyleSemiBoldGrey14,
                    )
                  ],
                ),
                ],
              ]),
            ),
          ),
        ),
        CommonWidgets.verticalSpacerWidget(5),
      ],
    );
  }
}
