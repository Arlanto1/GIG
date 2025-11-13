import 'package:db_atom/src/common_widgets/base_widget/add_button_widget.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:flutter/material.dart';

class TextFieldAddButton extends StatelessWidget {
  final Function? onTap;
  final String? title;
  final double? height;
  final bool? isDisableColor;

  const TextFieldAddButton({
    super.key,
    this.onTap,
    this.title,
    this.height,
    this.isDisableColor,

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
          width: 8,
        ),
        Expanded(
          child: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: (isDisableColor ?? false) ?
              const LinearGradient(colors: [Colors.transparent, Colors.transparent])
              :LinearGradient(
                colors: [
                  // Colors.white.withValues(alpha: 0.2),
                  // Colors.white.withValues(alpha: 0.28),
                  const Color(0xFF6474C6).withValues(alpha: 0.4),
                  // const Color(0xFF6474C6).withValues(alpha: 0),
                  Colors.white.withValues(alpha: 0.35),

                ],
                // stops: [0.02, 0.35, 0.9,],
                begin: Alignment.topRight,
                end: Alignment.bottomCenter,
              ) ,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.white.withValues(alpha: 90),
                width: 0.7,
              ),
              boxShadow: [
                // BoxShadow(
                //   color: Colors.white.withValues(alpha: 10),
                //   blurRadius: 90,
                //   offset: const Offset(1, 3), // white glow on top-left
                // ),
                BoxShadow(
                  color: AppColors.lavender.withValues(alpha: 2),
                  blurRadius: 30,
                  offset: const Offset(1, 0), // soft shadow bottom-right
                ),
              ],
            ),
                // color: (isDisableColor ?? false)
                //     ? Colors.transparent
                //     : Colors.white12,
                // border: Border.all(
                //   color: (isDisableColor ?? false)
                //       ? Colors.white12
                //       : Colors.white,
                //   width: 1.0,
                // ),
                // borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  title ?? '',
                  style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),

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
