
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../utils/app_themes/colors/app_color.dart';

class CheckBoxRow extends StatefulWidget {
   const CheckBoxRow({super.key});

  @override
  _CheckBoxRowState createState() => _CheckBoxRowState();
}

class _CheckBoxRowState extends State<CheckBoxRow> {
  bool isReadSelected = false;
  bool isWriteSelected = false;
  bool isSpeakSelected = false;

  get status => null;

  @override
  Widget build(BuildContext context) {
    return
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              activeColor: status == 6
                  ? AppColors.disabletextfieldBackground
                  : AppColors.navigationSkybluecolor,
              focusColor: AppColors.navigationSkybluecolor,
              value: isReadSelected,
              onChanged: (bool? value) {
                setState(() {
                  isReadSelected=value!;
                });
              },
            ),
            const Text(Constants.read),
            Checkbox(
              activeColor: status == 6
                  ? AppColors.disabletextfieldBackground
                  : AppColors.navigationSkybluecolor,
              focusColor: AppColors.navigationSkybluecolor,
              value: isWriteSelected,
              onChanged: (bool? value) {
                setState(() {
                  isWriteSelected=value!;
                });
              },
            ),
            const Text(Constants.write),
            Checkbox(
              activeColor: status == 6
                  ? AppColors.disabletextfieldBackground
                  : AppColors.navigationSkybluecolor,
              focusColor: AppColors.navigationSkybluecolor,
              value: isSpeakSelected,
              onChanged: (bool? value) {
                setState(() {
                  isSpeakSelected=value!;
                });
              },
            ),
            const Text(Constants.speak),
          ],
        );
  }
}
