import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/dashboard/navigation_drawer/views/menu_permissions.dart';

class BottomMenuHandler {
  final BuildContext context;
  final DisplayMenu displayMenu;

  final double positionX;

  const BottomMenuHandler({
    required this.context,
    required this.displayMenu,
    required this.positionX,
  });

  void openSubMenu({
    required BuildContext context,
    required double positionX,
    required List<MenuItem> menuItems,
    required void Function(BuildContext, int) onOptionSelected,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  color: Colors.black54,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
            FloatingSubMenuWidget(
              menuItems: menuItems,
              onOptionSelected: onOptionSelected,
              positionX: positionX,
            ),
          ],
        );
      },
    );
  }

  /// Guarding Operations
  void openGuardingOperationSubMenu() {
    List<MenuItem> menuItems = [];

    MenuPermissions()
        .checkMenuPermissionsGuardingOperations(displayMenu, menuItems);
    openSubMenu(
      context: context,
      positionX: positionX,
      menuItems: menuItems,
      onOptionSelected: _onGuardingOperationSubMenu,
    );
  }

  void _onGuardingOperationSubMenu(BuildContext context, int optionIndex) {
    log('Selected option: $optionIndex');
    // Navigate to the respective screen based on optionIndex
    switch (optionIndex) {
      case 0:
        log('contactDetailsListRoute');
        Navigator.pushNamed(context, contactDetailsListRoute);
        break;
      case 1:
        Navigator.pushNamed(context, guardingMasterDataRoute);
        break;
      case 2:
        Navigator.pushNamed(context, guardingMasterReportRoute);
        break;
      case 3:
        Navigator.pushNamed(context, shiftOccurrenceRoute);
        break;
      case 4:
        Navigator.pushNamed(context, slaViolationPenaltyListRoute);
        break;
      default:
        log('Invalid option selected');
    }
  }

  /// MaterialMovement
  void openMaterialMovementSubMenu() {
    // List<MenuItem> menuItems = [];
    // if (displayMenu.mM ?? false) {
    //   menuItems.add(const MenuItem(
    //       Constants.materialMovement, AppIcon.materialMovementIcon, 1));
    // }
    openSubMenu(
      context: context,
      positionX: positionX,
      menuItems: materialMovementDrawerItems,
      onOptionSelected: _onMaterialMovementSubMenu,
    );
  }

  void _onMaterialMovementSubMenu(BuildContext context, int optionIndex) {
    log('Selected option: $optionIndex');
    // Navigate to the respective screen based on optionIndex
    switch (optionIndex) {
      case 0:
        Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
            arguments: {"isInward": true});
        break;
      case 1:
        Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
            arguments: {"isInward": false});
        break;
      default:
        log('Invalid option selected');
    }
  }

  /// PassManagement
  void openPassManagementSubMenu() {
    List<MenuItem> menuItems = [];
    MenuPermissions().checkMenuPermissionsPassManagement(displayMenu, menuItems);
    openSubMenu(
      context: context,
      positionX: positionX,
      menuItems: menuItems,
      onOptionSelected: _onPassManagementSubMenu,
    );
  }
  void _onPassManagementSubMenu(BuildContext context, int optionIndex) {
    log('Selected option: $optionIndex');
    // Navigate to the respective screen based on optionIndex
    switch (optionIndex) {
      case 0:
        log('day pass management index0');
        Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
          "passMngDetails": PassMngArguments(0, 'Day Pass Management', false)
        });
        break;
      case 1:
        log('Sez pass Management index6');
        Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
          "passMngDetails": PassMngArguments(3, 'Sez Pass Management', false)
        });
        break;
      case 2:
        log('vendor pass management index4');
        Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
          "passMngDetails": PassMngArguments(2, 'Vendor Pass Management', false)
        });
        break;
      case 3:
        log('visitor pass management index2');
        Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
          "passMngDetails":
          PassMngArguments(1, 'Visitor Pass Management', false)
        });
        break;
      default:
        break;
    }
  }

  /// Shift Scheduling
  void openShiftScheduleSubMenu() {
    List<MenuItem> menuItems = [];
    MenuPermissions().checkMenuPermissionsShiftSchedule(displayMenu, menuItems);

    openSubMenu(
      context: context,
      positionX: positionX,
      menuItems: menuItems,
      onOptionSelected: _onShiftScheduleSubMenu,
    );
  }

  void _onShiftScheduleSubMenu(BuildContext context, int optionIndex) {
    log('Selected option: $optionIndex');
    // Navigate to the respective screen based on optionIndex
    switch (optionIndex) {
      case 0:
        Navigator.pushNamed(context, attendanceListRoute);
        break;
      case 1:
        Navigator.pushNamed(context, dutyPostMasterListRoute);
        break;
      case 2:
        Navigator.pushNamed(context, dutyPostNameMasterListRoute);
        break;
      case 3:
        Navigator.pushNamed(context, shiftScheduleListRoute);
        break;
      case 4:
        Navigator.pushNamed(context, attendanceReportBillingListRoute);
        break;
      default:
        break;
    }
  }
}
