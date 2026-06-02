
import 'dart:developer';

import '../../../index.dart';

class BaseAppBar {
  AppHeader buildAppHeader({
    required BuildContext context,
    required String title,
    required bool showPopUp,
    required bool showSaveButton,
    required bool showSubmitButton,
    required bool showLikeButton,
    required bool showDisLikeButton,
    bool visitorPassId = false,
    Function? onTapSubmit,
    Function? onTapSave,
    Function? onTapLikeButton,
    Function? onTapDislikeButton,
    void Function()? popAndReplace,
    bool? showCustomIcon,
    Function? onTapCustomIcon,
    Function? onTapPDFIcon,
    String? excelAPIName,
    String? pdfAPIName,
    String? gatePassPdf, // used for Listing Page and Details Page
    IconData? customIcon,
    Color? color,
    Color? titleColor,
  }) {
    return AppHeader(
      isTitleCenter: false,
      backgroundColour: titleColor ?? Colors.transparent,
      title: title,
      titleColor: titleColor ?? Colors.white,  // ← pass it here
      backBtn: IconButton(
        onPressed: popAndReplace ??
            () {
              Navigator.pop(context);
              CommonServices().unlock();
            },
        icon:
            const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
      ),
      action: [
        if (showPopUp) ...[
          CustomPopMenu(
            itemList: const [
              PopMenuItems("Export Excel", AppIcon.exportExcel),
              PopMenuItems("Export PDF", AppIcon.exportPdf),
              // PopMenuItems("Export XML", AppIcon.exportxml),
              //PopMenuItems("Close", AppIcon.close),
            ],
            itemTap: (value) async {
              // String userid = await SharedPrefs.getUserId();

              log('value--$value');
              if (value == 0) {
                DownloadImage()
                    .exportExcel(context, 'export.xslx', '/$excelAPIName');
              } else if (value == 1) {
                DownloadImage()
                    .exportPdf(context, 'export.pdf', '/$pdfAPIName');
              }
              // else if(value == 2){
              //   Navigator.pop(context);
              // }
            },
            popupImageName: AppIcon.moreWhiteIcon,
          ),
        ],
        if (showSaveButton) ...[
          GestureDetector(
            onTap: () {
              onTapSave!();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgPicture.asset(
                AppIcon.createFoundSaveIcon,
              ),
            ),
          )
        ],
        if (showSubmitButton) ...[
          GestureDetector(
            onTap: () {
              onTapSubmit!();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(
                visitorPassId ? Icons.print : Icons.send,
                color: AppColors.white,
              ),
            ),
          )
        ],
        if (showLikeButton) ...[
          GestureDetector(
            onTap: () {
              onTapLikeButton!();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.thumb_up,
                color: AppColors.white,
              ),
            ),
          )
        ],
        if (showDisLikeButton) ...[
          GestureDetector(
            onTap: () {
              onTapDislikeButton!();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.thumb_down,
                color: AppColors.white,
              ),
            ),
          )
        ],
        if (showCustomIcon ?? false) ...[
          GestureDetector(
            onTap: () {
              onTapCustomIcon!();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              // child: Icon(customIcon ?? Icons.history, color: Colors.white),
              child: Icon(customIcon ?? Icons.history, color: color ?? Colors.white),
            ),
          )
        ],
        if (!pdfAPIName.isEmptyOrNull && checkIfUrlContainsId(pdfAPIName!)) ...[
          GestureDetector(
            onTap: () {
              DownloadImage().exportPdf(context, 'export.pdf', '/$pdfAPIName');
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(Icons.picture_as_pdf, color: Colors.white),
            ),
          )
        ],
        if (!gatePassPdf.isEmptyOrNull &&
            checkIfUrlContainsId(gatePassPdf!)) ...[
          GestureDetector(
            onTap: () {
              DownloadImage().exportPdf(context, 'export.pdf', '/$gatePassPdf');
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(Icons.card_membership_rounded, color: Colors.white),
            ),
          )
        ],
      ],
    );
  }

  bool containsInteger(String input) {
    // Regular expression to check if the string contains any digits
    RegExp regExp = RegExp(r'\d');
    return regExp.hasMatch(input);
  }

  bool checkIfUrlContainsId(String url) {
    Uri uri = Uri.parse(url);

    // Check if the query parameters contain "id" and Integer
    RegExp regExp = RegExp(r'\d');
    return uri.queryParameters.containsKey('id') && regExp.hasMatch(url);
  }
}