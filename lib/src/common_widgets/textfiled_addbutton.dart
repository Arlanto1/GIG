import 'package:db_atom/src/common_widgets/base_widget/add_button_widget.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:flutter/material.dart';

class TextfieldAddButton extends StatelessWidget {
  final Function? onTap;
  final String? title;
  final double? height;
  final bool? isDisableColor;

  const TextfieldAddButton(
      {super.key, this.onTap, this.title, this.height, this.isDisableColor

      // required this.textfield,
      });

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
          child: AddButtonWidget(isDisableColor: isDisableColor),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Container(
            height: height,
            decoration: BoxDecoration(
                color: (isDisableColor ?? false)
                    ? AppColors.disabletextfieldBackground
                    : AppColors.enabletextfieldBackground,
                border: Border.all(
                  color: const Color(0xFFCACACA),
                  width: 1.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  title ?? '',
                  style: Styles.textStyleRegularGrey16,
                  textAlign: TextAlign.left, //Icon(Icons.cancel)
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
