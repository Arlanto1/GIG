import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constant_int_values.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/models/day_passlist_model.dart';
import 'package:db_atom/src/features/passmanagement/pass_management_list/bloc/pass_management_list_bloc.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';

class DayPassCustomPopUpList extends StatefulWidget {
  final PassManagementModel? userItem;
  String? passId = '0';

  DayPassCustomPopUpList(this.userItem, this.passId, {super.key});

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
    PassManagementListState state = const PassManagementListState();
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
                        state.labels?.locale.slNo ??
                            state.labels?.defaultLocale.slNo ??
                            'Sl No : ',
                        widget.userItem?.slNo.toString() ?? " "),
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
                        state.labels?.locale.locationRegion ??
                            state.labels?.defaultLocale.locationRegion ??
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
                    textHandling(
                        state.labels?.locale.location ??
                            state.labels?.defaultLocale.location ??
                            'Location : ',
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
                    Utils().textHandling(
                        state.labels?.locale.inputDate ??
                            state.labels?.defaultLocale.inputDate ??
                            'DateOfCreation : ',
                        widget.userItem?.inputDate != null
                            ? Utils.timestampToDateConversion(
                                int.parse(widget.userItem?.inputDate ?? '0'),
                                Constants.fulldateFormat)
                            : ''),
                  ],
                )
              : Container(),
          // widget.userItem?.inputDate != null
          //     ? CommonWidgets.verticalSpacerWidget(8)
          //     : Container(),
          CommonWidgets.verticalSpacerWidget(5),
          widget.userItem?.entrySecurity?.userName != null
              ? Row(
                  children: [
                    textHandling(
                        state.labels?.locale.entrySecurity ??
                            state.labels?.defaultLocale.entrySecurity ??
                            'Created By : ',
                        '${widget.userItem?.entrySecurity?.firstName.toString() ?? " "} ${widget.userItem?.entrySecurity?.lastName.toString() ?? " "}'),
                  ],
                )
              : Container(),

                  // if(widget.userItem?.passType == ConstantsIntValue.passIdVisitor)...[
                  //   CommonWidgets.verticalSpacerWidget(5),
                  //   widget.userItem?.passInfo != null
                  //       ? Row(
                  //     children: [
                  //       textHandling(
                  //           state.labels?.locale.visitorPassInfo ??
                  //               state.labels?.defaultLocale.visitorPassInfo ??
                  //               'Visitor Pass Info : ',
                  //           widget.userItem?.passInfo?.toString() ?? " "),
                  //     ],
                  //   )
                  //       : Container(),
                  // ],
          CommonWidgets.verticalSpacerWidget(5),
          widget.userItem?.passInfo?.passNo != null &&
                  (widget.userItem?.passInfo?.passNo ?? '').isNotEmpty
              ? Row(
                  children: [
                    textHandling(
                        widget.passId == '3'
                            ? state.labels?.locale.sezPassInfo ??
                                state.labels?.defaultLocale.sezPassInfo ??
                                'SEZ Pass No  : '
                            : widget.passId == '2'
                                ? state.labels?.locale.vendorPassInfo ??
                                    state
                                        .labels?.defaultLocale.vendorPassInfo ??
                                    'Vendor Pass No  : '
                                : widget.passId == '1'
                                    ? state.labels?.locale.visitorPassInfo ??
                                        state.labels?.defaultLocale
                                            .visitorPassInfo ??
                                        'Visitor Pass No  : '
                                    : state.labels?.locale.dayPassInfo ??
                                        state.labels?.defaultLocale
                                            .dayPassInfo ??
                                        'Day Pass No : ',
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
                    Utils().passManagementPassTypeRow(
                        widget.userItem?.passType ?? 0),
                  ],
                )
              : Container(),
          widget.userItem?.passType != null
              ? CommonWidgets.verticalSpacerWidget(8)
              : Container(),
          widget.userItem?.companyType?.name != null
              ? Row(
                  children: [
                    textHandling(
                        state.labels?.locale.companyName ??
                            state.labels?.defaultLocale.companyName ??
                            'Company Type : ',
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
                    textHandling(
                        state.labels?.locale.companyName ??
                            state.labels?.defaultLocale.companyName ??
                            'Company Name  : ',
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
                        state.labels?.locale.startTime ??
                            state.labels?.defaultLocale.startTime ??
                            'Pass Valid From : ',
                        widget.userItem?.startTime != null
                            ? Utils.timestampToDateConversion(
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
                        state.labels?.locale.endTime ??
                            state.labels?.defaultLocale.endTime ??
                            'Pass Valid Until : ',
                        widget.userItem?.endTime != null
                            ? Utils.timestampToDateConversion(
                                int.parse(widget.userItem?.endTime ?? '0'),
                                widget.passId ==
                                        ConstantsIntValue.passIdSez.toString()
                                    ? Constants.dateFormat
                                    : Constants.fulldateFormat)
                            : ''),
                  ],
                )
              : Container(),
          widget.userItem?.endTime != null
              ? CommonWidgets.verticalSpacerWidget(8)
              : Container(),
          (widget.userItem?.status == ConstantsIntValue.passStatusReturned ||
                      widget.userItem?.status ==
                          ConstantsIntValue.passStatusReturnedDamaged ||
                      widget.userItem?.status ==
                          ConstantsIntValue.passStatusReturnedDefaced) &&
                  widget.userItem?.handoverSecurity?.userName != null
              ? Row(
                  children: [
                    textHandling(
                        state.labels?.locale.handoverSecurity ??
                            state.labels?.defaultLocale.handoverSecurity ??
                            'Pass Collected By : ',
                        widget.userItem?.handoverSecurity?.userName
                                .toString() ??
                            " "),
                  ],
                )
              : Container(),

          (widget.userItem?.status == ConstantsIntValue.passStatusReturned ||
                      widget.userItem?.status ==
                          ConstantsIntValue.passStatusReturnedDamaged ||
                      widget.userItem?.status ==
                          ConstantsIntValue.passStatusReturnedDefaced) &&
                  widget.userItem?.returnedTime != null
              ? Row(
                  children: [
                    textHandling(
                        state.labels?.locale.returnedTime ??
                            state.labels?.defaultLocale.returnedTime ??
                            'Pass Returned on: ',
                        widget.userItem?.returnedTime != null
                            ? Utils.timestampToDateConversion(
                                int.parse(widget.userItem?.returnedTime ?? '0'),
                                Constants.twentyFourHourDateTimeFormat)
                            : ''),
                  ],
                )
              : Container(),

          widget.userItem?.status != null
              ? Row(
                  children: [
                    Utils().buildPassManagementStatusRow(
                        widget.userItem?.status ?? 0),
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
