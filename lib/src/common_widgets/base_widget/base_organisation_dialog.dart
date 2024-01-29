import 'dart:developer';

import 'package:db_atom/index.dart';

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
          duplicateEmployeeDepartments: organisations,
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
    Function? functionToCall,
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
                  return BaseAddUserDialog(
                    title: Constants.createnewuser,
                    functionToCall: functionToCall ?? () {},
                  );
                });
          },
          onTap: enabled ? onTap : null,
        );
      },
    );
  }
}
