import 'package:flutter/material.dart';

import '../../utils/app_themes/colors/app_color.dart';
import '../../utils/app_themes/styles/app_styles.dart';

class SelectedTileValueWidget extends StatelessWidget {
  const SelectedTileValueWidget({
    super.key,
    required this.name,
    this.width,
  });

  final String name;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFCACACA),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child:
            name.isEmpty ? Container() : TileWidget(width: width, name: name));
  }
}

class TileWidget extends StatelessWidget {
  const TileWidget({
    super.key,
    required this.width,
    required this.name,
  });

  final double? width;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(
        height: 50,
        width: width ?? 150,
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: TextButton(
            style: const ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(AppColors.normaltextBackground),
            ),
            onPressed: () {},
            child: Text(
              name,
              style: Styles.textStyleBlack14,
            ),
          ),
        ),
      )
    ]);
  }
}
