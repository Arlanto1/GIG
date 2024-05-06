import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_list_response.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';

class LawEnforcementCustomPopUpList extends StatefulWidget {
  LawEnforcementListElement? userItem;

  LawEnforcementCustomPopUpList(this.userItem, {super.key});

  @override
  State<LawEnforcementCustomPopUpList> createState() =>
      _LawEnforcementCustomPopUpListState();
}

class _LawEnforcementCustomPopUpListState
    extends State<LawEnforcementCustomPopUpList> {
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
            color: AppColors.backgroundWhiteColor,
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
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textHandling('Sl No : ', widget.userItem?.slNo.toString() ?? ""),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling(
                  'Region : ', widget.userItem?.locationRegion?.name ?? " "),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling(
                  'Location : ', widget.userItem?.location?.name ?? " "),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling(
                  'TimeOfVisit : ',
                  widget.userItem?.timeOfVisit != null
                      ? Utils.timestampToDateConversion(
                          int.parse(widget.userItem?.timeOfVisit ?? '0'),
                          Constants.dateFormat)
                      : ''),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling(
                  'Created By : ', '${widget.userItem?.entrySecurityName}'),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling('DBOfficialName : ',
                  widget.userItem?.dbOfficialEmail.toString() ?? " "),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling(
                  'Date Of Creation : ',
                  widget.userItem?.inputDate != null
                      ? Utils.timestampToDateConversion(
                          int.parse(widget.userItem?.inputDate ?? '0'),
                          Constants.dateFormat)
                      : ''),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling('Purpose of Visit : ',
                  widget.userItem?.visitPurpose?.name ?? " "),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [Utils().buildLeoStatusRow(widget.userItem?.status ?? 0)],
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
