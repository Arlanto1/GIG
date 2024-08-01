import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';

class CustomPopUpList extends StatefulWidget {
  FoundModel? userItem;

  CustomPopUpList(this.userItem, {super.key});

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textHandling('Sl No : ', widget.userItem?.slNo.toString() ?? " "),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(8),
          Row(
            children: [
              textHandling(
                  'Location : ', widget.userItem?.location?.name ?? " "),
            ],
          ),
          if (widget.userItem?.foundDate != null) ...[
            CommonWidgets.verticalSpacerWidget(8),
            Row(
              children: [
                textHandling(
                    'Found Date : ',
                    widget.userItem?.foundDate != null
                        ? Utils.timestampToDateConversion(
                            int.tryParse(widget.userItem?.foundDate ?? '0'),
                            Constants.dateFormat)
                        : ''),
              ],
            ),
          ],
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
          if (widget.userItem?.typeOfArticle != null) ...[
            CommonWidgets.verticalSpacerWidget(8),
            Row(
              children: [
                textHandling('Article Type : ',
                    widget.userItem?.typeOfArticle?.name ?? " "),
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
          if (widget.userItem?.claimantName != null &&
              widget.userItem?.status != 0) ...[
            CommonWidgets.verticalSpacerWidget(8),
            Row(
              children: [
                textHandling('Claimant : ',
                    widget.userItem?.claimantName.toString() ?? ""),
              ],
            ),
          ],
          if (widget.userItem?.handoverDate != null &&
              widget.userItem?.status == 2) ...[
            CommonWidgets.verticalSpacerWidget(8),
            Row(
              children: [
                textHandling(
                    'Handed Over Date : ',
                    widget.userItem?.handoverDate != null
                        ? Utils.timestampToDateConversion(
                            int.tryParse(widget.userItem?.handoverDate ?? '0'),
                            Constants.fulldateFormat)
                        : ''),
              ],
            ),
          ],
          if (widget.userItem?.handOverSecurityName != null &&
              !widget.userItem!.handOverSecurityName.isEmptyOrNull) ...[
            CommonWidgets.verticalSpacerWidget(8),
            Row(
              children: [
                textHandling('Item Hand Over By : ',
                    widget.userItem?.handOverSecurityName.toString() ?? " "),
              ],
            ),
          ],
          CommonWidgets.verticalSpacerWidget(8),
          Row(children: [
            Utils().buildFoundStatusRow(widget.userItem?.status ?? 0),
          ]),
        ])),
      ),
    );
  }
}
