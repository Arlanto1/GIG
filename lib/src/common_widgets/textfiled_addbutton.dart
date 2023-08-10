import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:flutter/material.dart';

class TextfieldAddButton extends StatelessWidget {
  //final FlutterInputField textfield;
  final Function? onTap;
  final String? title;
  final double? height;
  final bool? isDisableColor;
  const TextfieldAddButton({Key? key, this.onTap, this.title,this.height,this.isDisableColor

      // required this.textfield,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: <Widget>[
        GestureDetector(
          onTap: () {
                  //  datePickerselection(context);
                  onTap!();
                },
          child: Container(
            //color: AppColors.navigationSkybluecolor,
            height: 60,
            width: 50,
            decoration: BoxDecoration(
                color:(isDisableColor ?? false) ? AppColors.disabletextfieldBackground:AppColors.navigationSkybluecolor, 
                border: Border.all(
                  color: (isDisableColor ?? false) ? AppColors.disabletextfieldBackground:AppColors.navigationSkybluecolor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child:
                // IconButton(
                //icon: const Icon(Icons.add,color: AppColors.backgroundWhitecolor,),
                // iconSize: 40,
                // onPressed: ()
                // {
        
                // },
                Center(
              // child: GestureDetector(
              //   onTap: () {
              //     //  datePickerselection(context);
              //     onTap!();
              //   },
                child: SvgPicture.asset(
                  //AppIcon.dropdownicon,
                  AppIcon.addicon,
                  //fit: BoxFit.,
                  //color: AppColors.textColor,
                  width: 20,
                  height: 20,
                  key: const Key(Keys.userIcon),
                ), //Icon(Icons.add,color: AppColors.backgroundWhitecolor,size: 60,)
                //onPressed: onPressed!(),
             // ),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
            child: Container(
          child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  title ?? '',
                  style: Styles.textStyleRegularGrey16,
                  textAlign: TextAlign.left, //Icon(Icons.cancel)
                ),
              )), //
          height: height,
          decoration: BoxDecoration(
            color: (isDisableColor ?? false) ? AppColors.disabletextfieldBackground:AppColors.enabletextfieldBackground,
              border: Border.all(
                color: Color(0xFFCACACA),
                width: 1.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))),
        )),
      ],
    );
  }
}
