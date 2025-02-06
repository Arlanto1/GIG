import 'package:db_atom/src/models/organisation.dart';
import 'package:flutter/material.dart';

import '../../constants/app_icon.dart';
import '../textfiled_addbutton.dart';
import 'base_add_organisation_dialog.dart';
import 'multiple_selection_pop_up.dart';

class BaseEntitiesSelection {
  Widget entityDropDownSelection({
    required BuildContext context,
    required List<Organisation> selectedValues,
    required List<Organisation> all,
    required dynamic Function(List<Organisation>) onTap,
    bool enabled = true,

    // Add Organisation Fields
    String? addTitle,
    String? orgName =
        'ATOM_ENTITIES', // TODO: Need to make it required and non nullable
    bool? createEntity,
    Function? functionToCall,
  }) {
    String title = '';
    if (selectedValues.isNotEmpty) {
      for (int i = 0; i < selectedValues.length; i++) {
        Organisation entity = selectedValues[i];
        String value = entity.name ?? '';
        title = '$title  $value';
      }
    }
    return TextFieldAddButton(
      title: title,
      height: (selectedValues.length) > 2 ? 130 : 70,
      isDisableColor: !enabled,
      onTap: () {
        if (enabled) {
          _showEntitySelectionDialog(
            context: context,
            all: all,
            selectedValues: selectedValues,
            onTap: onTap,

            // Add Organisation Fields
            title: addTitle ?? 'Add Entity',
            orgName: orgName ?? '',
            createEntity: createEntity,
            functionToCall: functionToCall ?? () {},
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
    required String title,
    String? orgName, // TODO: Need to make it required and non nullable
    bool? createEntity,
    Function? functionToCall,
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
                  return BaseAddOrganisationDialog(
                    title: title,
                    orgName: orgName ?? '',
                    createEntity: createEntity,
                    functionToCall: functionToCall ?? () {},
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
