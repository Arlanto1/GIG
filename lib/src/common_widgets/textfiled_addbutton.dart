import 'package:db_atom/src/common_widgets/base_widget/add_button_widget.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
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
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: <Widget>[
        GestureDetector(
          onTap: () {
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
              gradient:
              (isDisableColor ?? false ) ?
               LinearGradient( colors: [
                AppColors.disableTextFieldBackground.withValues(alpha: 0.1),
                AppColors.disableTextFieldBackground.withValues(alpha: 0.1),
              ],)
              :
              LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.1),
                  Colors.transparent,
                  Colors.white.withValues(alpha: 0.1),

                ],
                stops: const [0.02, 0.35, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ) ,
              borderRadius: BorderRadius.circular(25),
              border:  (isDisableColor ?? false ) ? Border.all(
                color: Colors.white.withValues(alpha: 0.6),
                width: 0.7,
              ) : Border.all(
                color: Colors.white.withValues(alpha: 0.6),
                width: 0.7,
              ) ,
              boxShadow: [
                BoxShadow(
                  color: Colors.white
                      .withValues(alpha: 0.0),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
              child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  title ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),

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
