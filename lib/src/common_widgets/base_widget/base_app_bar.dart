import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_icon.dart';
import '../../utils/app_themes/colors/app_color.dart';
import '../app_bar.dart';
import '../custom_pop_menu.dart';

class BaseAppBar {
  AppHeader buildAppHeader() {
    return AppHeader(
      isTitleCenter: false,
      title: 'Inward Material Movement List',
      backBtn: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(AppIcon.backIcon,
            color: AppColors.backgroundWhitecolor),
      ),
      action: [
        CustomPopmenu(
          itemList: const[
            PopMenuItems("Export Excel", AppIcon.exportexcel),
            PopMenuItems("Export PDF", AppIcon.exportpdf),
            PopMenuItems("Export XML", AppIcon.exportxml),
            PopMenuItems("Close", AppIcon.close),
          ],
          itemTap: (value) async {
            String userid = await SharedPrefs.getUserId();
          },
          popupimagename: AppIcon.morewhiteicon,
        ),
      ],
    );
  }
}