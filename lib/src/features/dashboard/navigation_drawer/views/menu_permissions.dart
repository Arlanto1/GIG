import 'package:db_atom/index.dart';

class MenuPermissions {
  void checkMenuPermissionsGuardingOperations(
      DisplayMenu? displayMenu, List<MenuItemAction> menuItemActions) {
    if (displayMenu?.cD ?? false) {
      menuItemActions.add(MenuItemAction(
        menuItem: const MenuItem(Constants.escalationMatrix, AppIcon.escalationMatrixIcon, 0),
        onSelected: (context) => Navigator.pushNamed(context, contactDetailsListRoute),
      ));
    }

    if (displayMenu?.gM ?? false) {
      menuItemActions.add(MenuItemAction(
        menuItem: const MenuItem(Constants.guardingMasterData, AppIcon.guardingMasterDataIcon, 0),
        onSelected: (context) => Navigator.pushNamed(context, guardingMasterDataRoute),
      ));
    }

    if (displayMenu?.gMR ?? false) {
      menuItemActions.add(MenuItemAction(
        menuItem: const MenuItem(Constants.guardingMasterReport, AppIcon.guardingMasterReportIcon, 0),
        onSelected: (context) => Navigator.pushNamed(context, guardingMasterReportRoute),
      ));
    }

    if (displayMenu?.oCC ?? false) {
      menuItemActions.add(MenuItemAction(
        menuItem: const MenuItem(Constants.shiftOccurrence, AppIcon.shiftOccurrenceIcon, 0),
        onSelected: (context) => Navigator.pushNamed(context, shiftOccurrenceRoute),
      ));
    }

    if (displayMenu?.sVP ?? false) {
      menuItemActions.add(MenuItemAction(
        menuItem: const MenuItem(Constants.slaViolationPenaltyTitle, AppIcon.slaViolationPenaltyIcon, 0),
        onSelected: (context) => Navigator.pushNamed(context, slaViolationPenaltyListRoute),
      ));
    }
  }
  /// ShiftSchedule
  void checkMenuPermissionsShiftSchedule(
    DisplayMenu? displayMenu,
    List<MenuItem> menuItems,
  ) {
    if (displayMenu?.aTD ?? false) {
      menuItems
          .add(const MenuItem(Constants.attendance, AppIcon.attendanceIcon, 0));
    }

    if (displayMenu?.ssDPM ?? false) {
      menuItems.add(const MenuItem(
          Constants.dutyPostMaster, AppIcon.dutyPostMasterIcon, 0));
    }

    if (displayMenu?.sSDP ?? false) {
      menuItems.add(const MenuItem(
          Constants.dutyPostNameMaster, AppIcon.dutyPostNameMasterIcon, 0));
    }

    if (displayMenu?.sS ?? false) {
      menuItems.add(const MenuItem(
          Constants.shiftSchedule, AppIcon.shiftScheduleIcon, 0));
    }
  }

  /// PassManagement
  void checkMenuPermissionsPassManagement(
    DisplayMenu? displayMenu,
    List<MenuItem> menuItems,
  ) {
    if (displayMenu?.pM ?? false) {
      menuItems.add(const MenuItem(Constants.dayPassManagement,
          AppIcon.dayPassManagementRegisterIcon, 0));
    }

    if (displayMenu?.ssDPM ?? false) {
      menuItems.add(const MenuItem(
          Constants.sezpassmgmt, AppIcon.sezPassManagementRegisterIcon, 0));
    }

    if (displayMenu?.sSDP ?? false) {
      menuItems.add(const MenuItem(Constants.vendorpassmgmt,
          AppIcon.vendorPassManagementRegisterIcon, 0));
    }

    if (displayMenu?.sS ?? false) {
      menuItems.add(const MenuItem(Constants.visitorpassmgmt,
          AppIcon.visitorPassManagementRegisterIcon, 0));
    }
  }

  void checkMenuPermissionsKeyManagementData(
      DisplayMenu? displayMenu, List<MenuItem> menuItems) {
    if (displayMenu?.keyMM ?? false) {
      menuItems.add(const MenuItem(
          Constants.keyManagementMaster, AppIcon.keyManagementDataIcon, 0));
    }

    if (displayMenu?.kMISS ?? false) {
      menuItems.add(const MenuItem(Constants.keyManagementIssuance,
          AppIcon.keyManagementIssuanceIcon, 0));
    }
    if (displayMenu?.kLD ?? false) {
      menuItems.add(const MenuItem(Constants.keyLossDestructionList,
          AppIcon.keyLossDestructionListIcon, 0));
    }
  }
}
