import 'dart:developer';

import 'package:flutter/material.dart';

import '../../constants/app_icon.dart';
import '../../constants/constants.dart';
import '../../models/entity.dart';
import '../create_fields.dart';
import '../textfiled_addbutton.dart';
import 'multiple_selection_pop_up.dart';

class BaseEntitiesSelection {
  Widget entityDropDownSelection({
    required BuildContext context,
    required List<Entity> selectedValues,
    required List<Entity> all,
    required dynamic Function(List<Entity>) onTap,
    bool enabled = true,
  }) {
    String title = '';
    if (selectedValues.isNotEmpty) {
      for (int i = 0; i < selectedValues.length; i++) {
        Entity entity = selectedValues[i];
        log('--entity name-${entity.name}--');

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
    required List<Entity> all,
    required List<Entity> selectedValues,
    required dynamic Function(List<Entity>) onTap,
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
          duplicateEntityList: all,
          mainSelectedEntityList: selectedValues,
          onTap: onTap,
          leftImageName: AppIcon.addicon, // Provide your left button icon
        );
      },
    );
  }
}
