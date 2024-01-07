import 'dart:developer';

import 'package:flutter/material.dart';

import '../../constants/app_icon.dart';
import '../../constants/constants.dart';
import '../../features/createfound/views/add_employee_deparment.dart';
import '../../features/createfound/views/create_found_newuser.dart';
import '../../models/base_user.dart';
import '../../models/organisation.dart';
import '../custom_pop_list_texts.dart';

class BaseOrganisationDialog {
  departmentDialog({
    required BuildContext context,
    required List<Organisation> organisations,
    required Function onTap,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomListTexts(
          duplicateatomCompanyTypes: organisations,
          leftImageName: AppIcon.addicon,
          onLeftButtonTap: () {
            Navigator.pop(context);
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext dialogContext) {
                  return const AddEmployeeDepartment(
                    title: '',
                  );
                });
          },
          onTap: onTap,
        );
      },
    );
  }

  /// Customer Dialog with Email
  userDialog({
    required BuildContext context,
    List<BaseUser>? users,
    List<Organisation>? entities,
    required Function onTap,
    bool enabled = true,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        log('-enabled--$enabled-');
        return CustomListTexts(
          duplicateDepostorList: users,
          duplicateEntityList: entities,
          leftImageName: AppIcon.addicon,
          onLeftButtonTap: () {
            Navigator.pop(context);
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext dialogContext) {
                  return CreateFoundNewUser(
                    title: Constants.createnewuser,
                  );
                });
          },
          onTap: enabled ? onTap : null,
        );
      },
    );
  }
}
