import 'package:db_atom/src/common_widgets/base_widget/multiple_selection_distribution_group_pop_up.dart';
import 'package:db_atom/src/features/lawenforcement/models/law_enforement_request.dart';
import 'package:flutter/material.dart';

import '../../constants/app_icon.dart';
import '../../constants/constants.dart';
import '../create_fields.dart';
import '../textfiled_addbutton.dart';

class BaseDistributionGroupSelection {
  Widget entityDropDownSelection({
    required BuildContext context,
    required List<MailList> selectedValues,
    required List<MailList> all,
    required dynamic Function(List<MailList>) onTap,
    bool enabled = true,
  }) {
    String title = '';
    if (selectedValues.isNotEmpty) {
      for (int i = 0; i < selectedValues.length; i++) {
        MailList entity = selectedValues[i];
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
    required List<MailList> all,
    required List<MailList> selectedValues,
    required dynamic Function(List<MailList>) onTap,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomMultipleSelectionDistributionGroupListTexts(
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
