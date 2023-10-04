
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomPopUpList extends StatefulWidget {
  FoundModel? userItem;

  CustomPopUpList(this.userItem, {Key? key}) : super(key: key);

  @override
  State<CustomPopUpList> createState() => _CustomPopUpListState();
}

class _CustomPopUpListState extends State<CustomPopUpList> {
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
              textHandling('Sl No : ', widget.userItem?.slNo.toString() ?? " "),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling('Location : ',
                  widget.userItem?.locationName.toString() ?? " "),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling(
                  'Found Date : ',
                  widget.userItem?.foundDate != null
                      ? Utils.timestamptoDateConversion(
                          int.parse(widget.userItem?.foundDate ?? '0'),
                          Constants.dateFormat)
                      : ''),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling(
                  'Created By : ',
                  widget.userItem?.inputDate != null
                      ? Utils.timestamptoDateConversion(
                          int.parse(widget.userItem?.inputDate ?? '0'),
                          Constants.dateFormat)
                      : ''),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              Utils().buildAssetType(widget.userItem?.typeOfAsset ?? 0),
            ],
          ),
          if (widget.userItem?.quantity != null) ...[
            CommonWidgets.verticalSpacerWidget(8),
            Row(
              children: [
                textHandling(
                    'Quantity : ', widget.userItem?.quantity.toString() ?? " "),
              ],
            ),
          ],
          if (widget.userItem?.color != null) ...[
            CommonWidgets.verticalSpacerWidget(8),
            Row(
              children: [
                textHandling(
                    'Colour : ', widget.userItem?.color.toString() ?? " "),
              ],
            ),
          ],
          if (widget.userItem?.depositorName != null) ...[
            CommonWidgets.verticalSpacerWidget(8),
            Row(
              children: [
                textHandling('Depositor : ',
                    widget.userItem?.depositorName.toString() ?? " "),
              ],
            ),
          ],
          if (widget.userItem?.claimantName != null) ...[
            CommonWidgets.verticalSpacerWidget(8),
            Row(
              children: [
                textHandling(
                    'Claimant : ', widget.userItem?.claimant.toString() ?? ""),
              ],
            ),
          ],
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling(
                  'Handed Over Date : ',
                  widget.userItem?.handoverDate != null
                      ? Utils.timestamptoDateConversion(
                          int.parse(widget.userItem?.handoverDate ?? '0'),
                          Constants.dateFormat)
                      : ''),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling('item Hand Over By : ',
                  widget.userItem?.handOverSecurityName.toString() ?? " "),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(children: [
            Utils().buildFoundStatusRow(widget.userItem?.status ?? 0),
          ]),
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
// Widget build(BuildContext context) {
//   final size = MediaQuery.of(context).size;
//   final height = size.height;
//   final width = size.width;
//   return AlertDialog(
//     icon: Align(
//         alignment: Alignment.topRight,
//         child: GestureDetector(
//             onTap: () {
//               Navigator.of(context).pop();
//             },
//             child: SvgPicture.asset(AppIcon.closeicon) //Icon(Icons.cancel)
//             )),
//     backgroundColor: AppColors.backgroundWhitecolor,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//     content: Builder(builder: (context) {
//       // Get available height and width of the build area of this widget. Make a choice depending on the size.
//       var height = MediaQuery.of(context).size.height;
//       var width = MediaQuery.of(context).size.width;
//       return
//       Container(
//         height: height,
//         width: width - 30,
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             setupAlertDialoadContainer(height, width),
//           ],
//         ),
//       );
//     }),
//   );
// }

// Widget setupAlertDialoadContainer(double height, double width) {
//   return Container(
//     //padding: const EdgeInsets.all(20),
//     height: height / 1.4, // Change as per your requirement
//     // width: width- 50, // Change as per your requirement
//     width: double.maxFinite,
//     child: ListView.builder(
//       shrinkWrap: true,
//       itemCount: 15,
//       itemBuilder: (BuildContext context, int index) {
//         return ListTile(
//           dense: true,
//           visualDensity: VisualDensity(vertical: -4),
//           title: Row(
//             children: [
//               textHandling(
//                   'Status : ', widget.userItem?.status.toString() ?? " "),
//             ],
//           ),
//         );
//       },
//     ),
//   );
// }
