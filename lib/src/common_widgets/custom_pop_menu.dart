import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomPopmenu extends StatelessWidget {
  final List<PopMenuItems> itemList;
  // final List<String> itemImageList;
  final Function itemTap;
  final String popupimagename;

  const CustomPopmenu(
      {Key? key,
      required this.itemList,
      required this.itemTap,
      required this.popupimagename})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appBarHeight = AppBar().preferredSize.height;

    return PopupMenuButton(
      color:AppColors.backgroundWhitecolor ,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      icon: SvgPicture.asset(
        popupimagename,
        color: AppColors.backgroundWhitecolor,
        width: 18,
        height: 18,
        //key: const Key(Keys.userIcon),
      ),
      offset: Offset(0.0, appBarHeight),
      onSelected: (value) {
        // your logic
        itemTap(value);
      },
      itemBuilder: (BuildContext bc) {
        return _buildPopupMenuItem();
      },
    );
  }

  List<PopupMenuItem> _buildPopupMenuItem() {
    List<PopupMenuItem> children = [];
    for (int i = 0; i < itemList.length; i++) {
      PopMenuItems popItem = itemList[i];
      children.add(PopupMenuItem(
        value: i,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
        popItem.imageName,
        color: AppColors.textgreyThemecolor,
        width: 15,
        height: 15,
        //key: const Key(Keys.userIcon),
     ),
      //CommonWidgets.horizontalSpacerWidget(width * 0.03),
      
    //  const Icon(
    //             Icons.logout_rounded,
    //             color: AppColors.textgreyThemecolor,
    //           ),
            SizedBox(width: 13,), 
           Align(
             alignment: Alignment.topLeft,
             child: Text(
                    popItem.title,
                    style: Styles.textStyleRegularNormalGrey14,
                  ),
           ),
          ],
        ),
      ));
    }

    return children;
  }
}

class PopMenuItems {
  final String title;
  final String imageName;

  const PopMenuItems(this.title, this.imageName);
}
