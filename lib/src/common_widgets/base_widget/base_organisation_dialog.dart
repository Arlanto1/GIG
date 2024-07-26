import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_add_organisation_dialog.dart';

class BaseOrganisationDialog {
  departmentDialog({
    required BuildContext context,
    required List<Organisation> organisations,
    required Function onTap,
    String? title, // Ex: 'Add Key Type'
    String? orgName, // TODO: Need to make it required and non nullable
    bool? createEntity, // Ex: false
    Function? functionToCall,
    bool enabled = true,
    bool? leftImage = false,
  }) {
    FocusManager.instance.primaryFocus?.unfocus();
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        log('-organisations-----');
        return CustomListTexts(
          duplicateEmployeeDepartments: organisations,
          /// Uncomment leftImageName to enable + icon functionality
          leftImageName: leftImage == true ? AppIcon.addicon : null,
          onLeftButtonTap: () {
            Navigator.pop(context);
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext dialogContext) {
                  return BaseAddOrganisationDialog(
                    title: title ?? '',
                    orgName: orgName ?? '',
                    createEntity: createEntity,
                    functionToCall: functionToCall ?? () {},
                  );
                });
          },
          onTap: enabled ? onTap : null,
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
    String? roleName,
  }) {
    FocusManager.instance.primaryFocus?.unfocus();
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomListTexts(
          duplicateDepostorList: users,
          duplicateEntityList: entities,
          leftImageName: functionToCall != null &&
              roleName == ConstantUserRoles.atomStaticUser
              ? AppIcon.addicon
              : null,
          onLeftButtonTap: () {
            Navigator.pop(context);
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext dialogContext) {
                  return BaseAddUserDialog(
                    title: Constants.createnewuser,
                    roleName: roleName ?? '',
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
