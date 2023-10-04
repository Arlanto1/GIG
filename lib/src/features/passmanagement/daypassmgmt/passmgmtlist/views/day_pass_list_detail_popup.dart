import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/models/day_passlist_model.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';

class DayPassCustomPopUpList extends StatefulWidget {
  final DayPassListElement? userItem;
  String? passId = '0';

  DayPassCustomPopUpList(this.userItem, this.passId, {Key? key})
      : super(key: key);

  @override
  State<DayPassCustomPopUpList> createState() => _DayPassCustomPopUpListState();
}

class _DayPassCustomPopUpListState extends State<DayPassCustomPopUpList> {
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
          widget.userItem?.id != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textHandling(
                        'ID : ', widget.userItem?.id.toString() ?? " "),
                  ],
                )
              : Container(),
          widget.userItem?.id != null
              ? CommonWidgets.verticalSpacerWidget(8)
              : Container(),
          widget.userItem?.slNo != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textHandling(
                        'Sl No : ', widget.userItem?.slNo.toString() ?? " "),
                  ],
                )
              : Container(),
          widget.userItem?.slNo != null
              ? CommonWidgets.verticalSpacerWidget(8)
              : Container(),
          widget.userItem?.locationRegion?.name != null
              ? Row(
                  children: [
                    textHandling(
                        'Region : ',
                        widget.userItem?.locationRegion?.name.toString() ??
                            " "),
                  ],
                )
              : Container(),
          widget.userItem?.locationRegion?.name != null
              ? CommonWidgets.verticalSpacerWidget(8)
              : Container(),
          widget.userItem?.location?.name != null
              ? Row(
                  children: [
                    textHandling('Location : ',
                        widget.userItem?.location?.name.toString() ?? " "),
                  ],
                )
              : Container(),

          widget.userItem?.location?.name != null
              ? CommonWidgets.verticalSpacerWidget(8)
              : Container(),
          // Row(
          //   children: [
          //     textHandling('Entity : ',
          //        widget.userItem?.entities != null ? (widget.userItem?.entities?.length  ?? 0 ) > 0 ? (widget.userItem?.entities?[0].name.toString() ?? " " ) : "" : ""),
          //   ],
          // ),
          //  CommonWidgets.verticalSpacerWidget(8),
          widget.userItem?.inputDate != null
              ? Row(
                  children: [
                    textHandling(
                        'Date of creation : ',
                        widget.userItem?.inputDate != null
                            ? Utils.timestamptoDateConversion(
                                int.parse(widget.userItem?.inputDate ?? '0'),
                                Constants.dateFormat)
                            : ''),
                  ],
                )
              : Container(),
          widget.userItem?.inputDate != null
              ? CommonWidgets.verticalSpacerWidget(8)
              : Container(),
          widget.userItem?.entrySecurity?.userName != null
              ? Row(
                  children: [
                    textHandling(
                        'Created By : ',
                        widget.userItem?.entrySecurity?.userName.toString() ??
                            " "),
                  ],
                )
              : Container(),
          widget.userItem?.entrySecurity?.userName != null
              ? CommonWidgets.verticalSpacerWidget(8)
              : Container(),
          (widget.userItem?.employeeName != null &&
                  widget.userItem?.entrySecurity != null)
              ? Row(
                  children: [
                    textHandling(
                        'Name : ',
                        widget.userItem?.entrySecurity != null
                            ? widget.userItem?.entrySecurity?.name.toString() ??
                                " "
                            : widget.userItem?.employeeName.toString() ?? ''),
                  ],
                )
              : Container(),
          (widget.userItem?.employeeName != null &&
                  widget.userItem?.entrySecurity != null)
              ? CommonWidgets.verticalSpacerWidget(8)
              : Container(),
          widget.userItem?.passInfo?.passNo != null &&
                  (widget.userItem?.passInfo?.passNo ?? '').isNotEmpty
              ? Row(
                  children: [
                    textHandling(
                        widget.passId == '3'
                            ? 'SEZ Pass No  : '
                            : widget.passId == '2'
                                ? 'Vendor Pass No  : '
                                : widget.passId == '1'
                                    ? 'Visitor Pass No  : '
                                    : 'Day Pass No : ',
                        widget.userItem?.passInfo?.passNo?.toString() ?? " "),
                  ],
                )
              : Container(),
          widget.userItem?.passInfo?.passNo != null &&
                  (widget.userItem?.passInfo?.passNo ?? '').isNotEmpty
              ? CommonWidgets.verticalSpacerWidget(8)
              : Container(),
          widget.userItem?.passType != null
              ? Row(
                  children: [
                    textHandling('Pass Type: ',
                        widget.userItem?.passType.toString() ?? " "),
                  ],
                )
              : Container(),
          widget.userItem?.passType != null
              ? CommonWidgets.verticalSpacerWidget(8)
              : Container(),
          widget.userItem?.companyType?.name != null
              ? Row(
                  children: [
                    textHandling('Company Type : ',
                        widget.userItem?.companyType?.name.toString() ?? " "),
                  ],
                )
              : Container(),
          widget.userItem?.companyType?.name != null
              ? CommonWidgets.verticalSpacerWidget(8)
              : Container(),
          widget.userItem?.companyName != null &&
                  (widget.userItem?.companyName ?? '').isNotEmpty
              ? Row(
                  children: [
                    textHandling('Company Name  : ',
                        widget.userItem?.companyName.toString() ?? " "),
                  ],
                )
              : Container(),
          widget.userItem?.companyName != null &&
                  (widget.userItem?.companyName ?? '').isNotEmpty
              ? CommonWidgets.verticalSpacerWidget(8)
              : Container(),
          widget.userItem?.startTime != null
              ? Row(
                  children: [
                    textHandling(
                        'Pass Valid From : ',
                        widget.userItem?.startTime != null
                            ? Utils.timestamptoDateConversion(
                                int.parse(widget.userItem?.startTime ?? '0'),
                                Constants.fulldateFormat)
                            : ''),
                  ],
                )
              : Container(),
          widget.userItem?.startTime != null
              ? CommonWidgets.verticalSpacerWidget(8)
              : Container(),
          widget.userItem?.endTime != null
              ? Row(
                  children: [
                    textHandling(
                        'Pass Valid Until : ',
                        widget.userItem?.endTime != null
                            ? Utils.timestamptoDateConversion(
                                int.parse(widget.userItem?.endTime ?? '0'),
                                Constants.dateFormat)
                            : ''),
                  ],
                )
              : Container(),
          widget.userItem?.endTime != null
              ? CommonWidgets.verticalSpacerWidget(8)
              : Container(),
          widget.userItem?.handoverSecurity?.userName != null
              ? Row(
                  children: [
                    textHandling(
                        'Pass Collected By : ',
                        widget.userItem?.handoverSecurity?.userName
                                .toString() ??
                            " "),
                  ],
                )
              : Container(),
          widget.userItem?.handoverSecurity?.userName != null
              ? CommonWidgets.verticalSpacerWidget(8)
              : Container(),
          widget.userItem?.returnedTime != null
              ? Row(
                  children: [
                    textHandling(
                        'Pass Returened on: ',
                        widget.userItem?.returnedTime != null
                            ? Utils.timestamptoDateConversion(
                                int.parse(widget.userItem?.returnedTime ?? '0'),
                                Constants.dateFormat)
                            : ''),
                  ],
                )
              : Container(),
          widget.userItem?.returnedTime != null
              ? CommonWidgets.verticalSpacerWidget(8)
              : Container(),
          widget.userItem?.status != null
              ? Row(
                  children: [
                    textHandling(
                        'Status : ', widget.userItem?.status.toString() ?? " "),
                  ],
                )
              : Container(),
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
