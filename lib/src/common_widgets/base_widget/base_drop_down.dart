import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_icon.dart';
import '../../utils/helpers/keys/keys.dart';
import '../custom_simple_list_texts.dart';
import '../new_search_textfield.dart';
import 'base_list_tile_item.dart';

class BaseDropDown {
  GestureDetector getDropDown({
    required bool isDisabled,
    required TextEditingController textController,
    List<Label>? items,
    String? initialValue,
    required void Function()? onTap,
  }) {
    if (initialValue != null && items != null) {
      final selectedLabel = items.firstWhere(
        (label) => label.value == initialValue,
        orElse: () => const Label(key: '', value: ''),
      );
      textController.text = selectedLabel.key;
    }
    return GestureDetector(
      onTap: onTap,
      child: FlutterInputField(
        textFieldController: textController,
        textFormKey: Keys.returnableKey,
        hintText: '',
        isEnable: false,
        suffixIcon: Icons.arrow_drop_down,
        isDisableColor: !isDisabled,
        onChange: (String value) {},
        validateTextField: (String? user) {},
        suffixWidget: IconButton(
            icon: SvgPicture.asset(
                width: 10,
                height: 10,
                AppIcon.dropdownicon,
                key: const Key('closed_eye')),
            onPressed: () {}),

      ),
    );
  }

  assetTypeDialog({
    required BuildContext context,
    List<String>? dropDownValues,
    List<Label>? labelDropDownValue,
    required Function onTap,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return CustomSimpleListTexts(
          texts: dropDownValues ??
              labelDropDownValue?.map((label) => label.key).toList(),
          onTap: onTap,
        );
      },
    );
  }
}
