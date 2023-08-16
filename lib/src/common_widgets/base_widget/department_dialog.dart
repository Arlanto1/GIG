import 'package:flutter/material.dart';

import '../../constants/app_icon.dart';
import '../../constants/constants.dart';
import '../../features/createfound/views/add_employee_deparment.dart';
import '../../features/createfound/views/create_found_newuser.dart';
import '../../models/base_user.dart';
import '../../models/department.dart';
import '../custom_pop_list_texts.dart';

class BaseDialog {
  departmentDialog({
    required BuildContext context,
    required List<Department> departments,
    required Function onTap,
  }) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
              duplicateemployeeDepartments: departments,
              leftimagename: AppIcon.addicon,
              onLeftButtonTap: () {
                Navigator.pop(context);
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AddEmployeeDepartment(
                        title: '',
                      );
                    });
              },
              onTap: onTap);
        });
  }

  /// Customer Dialog with Email
  userDialog({
    required BuildContext context,
    required List<BaseUser> users,
    required Function onTap,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicatedepostorList: users,
            leftimagename: AppIcon.addicon,
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
            onTap: onTap
          );
        });
  }
}
