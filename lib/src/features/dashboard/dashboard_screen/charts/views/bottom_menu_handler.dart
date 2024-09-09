import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/dashboard/navigation_drawer/views/menu_navigation.dart';
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
    List<MenuItemAction> menuItemActions = [];

    MenuPermissions()
        .checkMenuPermissionsGuardingOperations(displayMenu, menuItemActions);

    openSubMenu(
      context: context,
      positionX: positionX,
      menuItems: menuItemActions.map((action) => action.menuItem).toList(),
      onOptionSelected: (context, index) {
        // Dynamically trigger the corresponding action based on the selected index
        menuItemActions[index].onSelected(context);
      },
    );
  }

  void _onGuardingOperationSubMenu(BuildContext context, int index) {
    log('Selected option: $index');
    // Navigate to the respective screen based on index
    switch (index) {
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
      menuItems: materialMovementDrawerItemsWithReturnable,
      onOptionSelected: _onMaterialMovementSubMenu,
    );
  }

  void _onMaterialMovementSubMenu(BuildContext context, int index) {
    log('Selected option: $index');
    // Navigate to the respective screen based on index
    switch (index) {
      case 0:
        Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
            arguments: {"isInward": true});
        break;
      case 1:
        Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
            arguments: {"isInward": false, "returnable": true});
        break;
      case 2:
        Navigator.pushNamed(context, materialMovementInwardsOutwardsRoute,
            arguments: {"isInward": false, "returnable": false});
        break;
      default:
        log('Invalid option selected');
    }
  }

  /// PassManagement
  void openPassManagementSubMenu() {
    List<MenuItem> menuItems = [];
    MenuPermissions()
        .checkMenuPermissionsPassManagement(displayMenu, menuItems);
    openSubMenu(
      context: context,
      positionX: positionX,
      menuItems: menuItems,
      onOptionSelected: _onPassManagementSubMenu,
    );
  }

  void _onPassManagementSubMenu(BuildContext context, int index) {
    log('Selected option: $index');
    // Navigate to the respective screen based on index
    MenuNavigation().onPassManagementItemSelected(
      context: context,
      index: index,
    );
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

  void _onShiftScheduleSubMenu(BuildContext context, int index) {
    log('Selected option: $index');
    // Navigate to the respective screen based on index
    MenuNavigation().onShiftScheduleItemSelected(
      context: context,
      index: index,
    );
  }

  /// Key Management Data
  void openKeyManagementDataSubMenu() {
    List<MenuItem> menuItems = [];
    MenuPermissions()
        .checkMenuPermissionsKeyManagementData(displayMenu, menuItems);

    openSubMenu(
      context: context,
      positionX: positionX,
      menuItems: menuItems,
      onOptionSelected: _onKeyManagementDataSubMenu,
    );
  }

  void _onKeyManagementDataSubMenu(BuildContext context, int index) {
    log('Selected option: $index');
    // Navigate to the respective screen based on index
    MenuNavigation().onKeyManagementItemSelected(
      context: context,
      index: index,
    );
  }
}
class MenuItemAction {
  final MenuItem menuItem;
  final Function(BuildContext) onSelected;

  MenuItemAction({required this.menuItem, required this.onSelected});
}