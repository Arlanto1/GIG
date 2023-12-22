import 'dart:developer';

import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_icon.dart';
import '../app_bar.dart';
import '../custom_pop_menu.dart';
import '../image_download.dart';

class BaseAppBar {
  AppHeader buildAppHeader({
    required BuildContext context,
    required String title,
    required bool showPopUp,
    required bool showSaveButton,
    Function? onTapSave,
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
                    'export.xslx', 0, 20, '/$excelAPIName');
              } else if (value == 1) {
                DownloadImage().exportPdf(context, int.parse(userid),
                    'export.pdf', 0, 20, '/$pdfAPIName');
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
        if (showCustomIcon ?? false) ...[
          GestureDetector(
            onTap: () {
              onTapCustomIcon!();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(customIcon ??Icons.add, color: Colors.white),
            ),
          )
        ],
      ],
    );
  }
}
