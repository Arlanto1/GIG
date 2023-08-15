import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';

import '../../features/material_movement/models/material_movements_model.dart';

class BasePopUpItems extends StatefulWidget {
  final String? id;
  final String? slNo;
  final Location? location;
  final LocationRegion? locationRegion;
  final String? status;
  final String? inputDate;
  final String? entrySecurityName;
  final bool? returnable;
  final String? quantity;
  final String? challanNo;

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
    // this.securityName,
    this.entrySecurityName,
    //this.modifiedDate,
    this.returnable,
    this.challanNo,
  });
}

class _BasePopUpItemsState extends State<BasePopUpItems> {
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
              textHandling('ID : ', widget.id.toString()),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textHandling('Sl No : ', widget.slNo.toString()),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling('Region : ', widget.locationRegion?.name ?? " "),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling('Location : ', widget.location?.name ?? " "),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling('Material Movement Type : ',
                  widget.returnable == true ? 'Returnable' : 'Not Returnable'),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textHandling('Challan/Invoice Nos/Gate Pass : ',
                  widget.challanNo.toString()),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textHandling('Quantity : ', widget.quantity.toString()),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling(
                  'DateOfCreation : ',
                  widget.inputDate != null
                      ? Utils.timestamptoDateConversion(
                          int.parse(widget.inputDate ?? '0'),
                          Constants.dateFormat)
                      : ''),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling(
                  'Created By : ', widget.entrySecurityName.toString()),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling('Status : ', widget.status.toString()),
            ],
          ),
        ])),
      ),
    );
  }
}
