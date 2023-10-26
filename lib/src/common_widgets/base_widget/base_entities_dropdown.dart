import 'package:db_atom/src/models/organisation.dart';
import 'package:flutter/material.dart';

import '../../constants/app_icon.dart';
import '../../constants/constants.dart';
import '../create_fields.dart';
import '../textfiled_addbutton.dart';
import 'multiple_selection_pop_up.dart';

class BaseEntitiesSelection {
  Widget entityDropDownSelection({
    required BuildContext context,
    required List<Organisation> selectedValues,
    required List<Organisation> all,
    required dynamic Function(List<Organisation>) onTap,
    bool enabled = true,
  }) {
    String title = '';
    if (selectedValues.isNotEmpty) {
      for (int i = 0; i < selectedValues.length; i++) {
        Organisation entity = selectedValues[i];
        String value = entity.name ?? '';
        title = '$title  $value';
      }
    }

    return TextfieldAddButton(
      title: title,
      height: (selectedValues.length) > 4
          ? (selectedValues.length) > 9
              ? 140
              : 100
          : 60,
      isDisableColor: !enabled,
      onTap: () {
        if (enabled) {
          _showEntitySelectionDialog(
            context: context,
            all: all,
            selectedValues: selectedValues,
            onTap: onTap,
          );
        }
      },
    );
  }

  void _showEntitySelectionDialog({
    required BuildContext context,
    required List<Organisation> all,
    required List<Organisation> selectedValues,
    required dynamic Function(List<Organisation>) onTap,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomMultipleSelectionListTexts(
          onLeftButtonTap: () {
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AddNewFields(
                    title: Constants.addentitytype,
                    // TODO: Need to make it functional
                    // createpassmgmtstate: state,
                  );
                });
          },
          allItems: all,
          selectedValues: selectedValues,
          onTap: onTap,
          leftImageName: AppIcon.addicon, // Provide your left button icon
        );
      },
    );
  }
}
