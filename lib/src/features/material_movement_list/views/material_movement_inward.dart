import 'package:db_atom/src/common_widgets/app_bar.dart';
import 'package:db_atom/src/common_widgets/custom_pop_menu.dart';
import 'package:db_atom/src/common_widgets/floating_button.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../main_DEV.dart';
import '../../../constants/ui_geometry_constants.dart';
import '../../../utils/shared_preferences.dart';

class MaterialPage extends StatefulWidget {
  const MaterialPage({super.key});

  @override
  State<MaterialPage> createState() => _MaterialPageState();
}

class _MaterialPageState extends State<MaterialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBgColor,
      floatingActionButton: const Flutterfloatingbutton(
          backgroundColor: AppColors.navigationSkybluecolor,
        foregroundColor: AppColors.backgroundWhitecolor,
      ),

      appBar: AppHeader(
        isTitleCenter: false,
        title: 'Material_Movement List',
        backBtn: IconButton(
          onPressed: (){
            },
          icon: SvgPicture.asset(AppIcon.backIcon,
          color: AppColors.backgroundWhitecolor) ,
        ),
        action: [
          CustomPopmenu(
            itemList: const[
              PopMenuItems("Export Excel", AppIcon.exportexcel),
              PopMenuItems("Export PDF", AppIcon.exportpdf),
              PopMenuItems("Close", AppIcon.close),
            ],
            itemTap: (value) async {
            String userid = await SharedPrefs.getUserId();
            },
            popupimagename: AppIcon.morewhiteicon,
          ),
        ],
      ),
        body: Container(
           margin: allMargin16,
            decoration:const ShapeDecoration(
                color: AppColors.backgroundWhitecolor, shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(5))
            )
      ),
      )
    );
    }
}
