import 'package:flutter/material.dart';

import '../../utils/app_themes/colors/app_color.dart';

class LanguageCheckBox extends StatelessWidget {
  const LanguageCheckBox({
    super.key,
    required this.context,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  final BuildContext context;
  final String label;
  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: AppColors.geryLightBackground,
          focusColor: AppColors.geryLightBackground,
          value: value,
          onChanged: onChanged,
        ),
        Text(label, style: TextStyle(color: AppColors.white)),
      ],
    );
  }
}
