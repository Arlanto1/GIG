import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSimpleListTexts extends StatefulWidget {
  const CustomSimpleListTexts({
    super.key,
    this.texts,
    this.onTap,
    this.pop,
  });

  final List<String>? texts;
  final Function? onTap;
  final bool? pop;

  @override
  State<CustomSimpleListTexts> createState() => CustomSimpleListTextsState();
}

class CustomSimpleListTextsState extends State<CustomSimpleListTexts> {
  @override
  Widget build(BuildContext context) {
    return setupAlertDialogContainer();
  }

  Widget setupAlertDialogContainer() {
    return AlertDialog(
      icon: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(AppIcon.closeicon) //Icon(Icons.cancel)
            ),
      ),
      backgroundColor: AppColors.backgroundWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        return SizedBox(
            //height: height/3,
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.texts?.length,
              itemBuilder: (BuildContext context, int index) {
                String? item = widget.texts?[index];
                return ListTile(
                  onTap: () {
                    widget.onTap!(item);
                    if (widget.pop ?? true) {
                      Navigator.of(context).pop();
                    }
                  },
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0), // to expand
                  title: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      item ?? '',
                      style: Styles.textStyleRegularGrey16,
                      textAlign: TextAlign.left,
                    ),
                  ),
                );
              },
            ));
      }),
    );
  }
}
