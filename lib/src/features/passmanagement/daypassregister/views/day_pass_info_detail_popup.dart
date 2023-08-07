


import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/passmanagement/daypassregister/models/day_pass_info_model.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class DayPassInfoCustomPopUpList extends StatefulWidget {
  DaypassInfoListElement? userItem;
  DayPassInfoCustomPopUpList(this.userItem, {Key? key}) : super(key: key);

  @override
  State<DayPassInfoCustomPopUpList> createState() => _DayPassInfoCustomPopUpListState();
}

class _DayPassInfoCustomPopUpListState extends State<DayPassInfoCustomPopUpList> {
  //var firstStyle = Styles.textStyleSemiBoldGrey14;
//var secondStyle = Styles.textStyleSemiBoldheighGrey14;

//var mergedStyle = firstStyle.merge(secondStyle);
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
                // child: Card(
                //         elevation: 5,
                //         shape: RoundedRectangleBorder(
                // side: const BorderSide(color: AppColors.searchBarBorder, width: 1),
                // borderRadius: circularBorderRadius10,
                //         ),
                //         child: Padding(
                //   padding: EdgeInsets.all(20),
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
              textHandling('ID : ', widget.userItem?.id.toString() ?? " "),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textHandling('Pass No : ', widget.userItem?.passNo.toString() ?? " "),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textHandling('Type Of Pass : ', widget.userItem?.passType.toString() ?? " "),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling(
                  'Region : ', widget.userItem?.region?.name.toString() ?? " "),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling('Location : ',
                  widget.userItem?.location?.name.toString() ?? " "),
            ],
          ),
         
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling('Entity : ',
                  widget.userItem?.entity?.name.toString() ?? ""),
            ],
          ),
           CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling(
                  'Expiry Date : ',
                  widget.userItem?.expiryDate != null ?
                  Utils.timestamptoDateConversion(
                       int.parse(widget.userItem?.expiryDate ?? '0'),Constants.dateFormat): ''),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling('Is Dws Pass : ',
                  widget.userItem?.dws.toString() ?? " "),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling(
                  'Remarks : ',  " "),
            ],
          ),
           CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling(
                  'Day Pass No : ', widget.userItem?.passNo?.toString() ?? " "
                 ),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
               textHandling('Status : ',
                             (widget.userItem?.status ?? '').toString()),
            ],
          ),
        ])
                //),
                //    ),
                ),
        // ],
      ),
      // ),
    );
  }
}