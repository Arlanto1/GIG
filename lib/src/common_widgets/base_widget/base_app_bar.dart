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
    Function? onTapSubmit,
    Function? onTapSave,
    Function? onTapLikeButton,
    Function? onTapDislikeButton,
    void Function()? popAndReplace,
    bool? showCustomIcon,
    Function? onTapCustomIcon,
    String? excelAPIName,
    String? pdfAPIName,
    IconData? customIcon,
  }) {
    return AppHeader(
      isTitleCenter: false,
      title: title,
      backBtn: IconButton(
        onPressed: popAndReplace ??
            () {
              Navigator.pop(context);
            },
        icon:
            const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
      ),
      action: [
        if (showPopUp) ...[
          CustomPopmenu(
            itemList: const [
              PopMenuItems("Export Excel", AppIcon.exportexcel),
              PopMenuItems("Export PDF", AppIcon.exportpdf),
              // PopMenuItems("Export XML", AppIcon.exportxml),
              //PopMenuItems("Close", AppIcon.close),
            ],
            itemTap: (value) async {
              String userid = await SharedPrefs.getUserId();

              log('value--$value');
              if (value == 0) {
                DownloadImage().exportExcel(context, int.parse(userid),
                    'export.xslx', '/$excelAPIName');
              } else if (value == 1) {
                DownloadImage().exportPdf(
                    context, int.parse(userid), 'export.pdf', '/$pdfAPIName');
              }
              // else if(value == 2){
              //   Navigator.pop(context);
              // }
            },
            popupimagename: AppIcon.morewhiteicon,
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
                AppIcon.createfoundsaveicon,
              ),
            ),
          )
        ],
        if (showSubmitButton) ...[
          GestureDetector(
            onTap: () {
              onTapSubmit!();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.send,
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
              child: Icon(customIcon ?? Icons.add, color: Colors.white),
            ),
          )
        ],
      ],
    );
  }
}
