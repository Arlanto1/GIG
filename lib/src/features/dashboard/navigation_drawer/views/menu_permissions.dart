import 'package:db_atom/index.dart';

class MenuPermissions {
  void checkMenuPermissionsGuardingOperations(
      DisplayMenu? displayMenu, List<MenuItem> menuItems) {
    if (displayMenu?.cD ?? false) {
      menuItems.add(const MenuItem(
          Constants.escalationMatrix, AppIcon.escalationMatrixIcon, 0));
    }

    if (displayMenu?.gM ?? false) {
      menuItems.add(const MenuItem(
          Constants.guardingMasterData, AppIcon.guardingMasterDataIcon, 0));
    }

    if (displayMenu?.gMR ?? false) {
      menuItems.add(const MenuItem(
          Constants.guardingMasterReport, AppIcon.guardingMasterReportIcon, 0));
    }

    if (displayMenu?.oCC ?? false) {
      menuItems.add(const MenuItem(
          Constants.shiftOccurrence, AppIcon.shiftOccurrenceIcon, 0));
    }
    if (displayMenu?.sVP ?? false) {
      menuItems.add(const MenuItem(Constants.slaViolationPenaltyTitle,
          AppIcon.slaViolationPenaltyIcon, 0));
    }
  }

  /// ShiftSchedule
  void checkMenuPermissionsShiftSchedule(
      DisplayMenu? displayMenu, List<MenuItem> menuItems) {
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
      DisplayMenu? displayMenu, List<MenuItem> menuItems) {
    if (displayMenu?.aTD ?? false) {
      menuItems
          .add(const MenuItem(Constants.dayPassManagement, AppIcon.dayPassManagementRegisterIcon, 0));
    }

    if (displayMenu?.ssDPM ?? false) {
      menuItems.add(const MenuItem(
          Constants.sezpassmgmt, AppIcon.sezPassManagementRegisterIcon, 0));
    }

    if (displayMenu?.sSDP ?? false) {
      menuItems.add(const MenuItem(
          Constants.vendorpassmgmt, AppIcon.vendorPassManagementRegisterIcon, 0));
    }

    if (displayMenu?.sS ?? false) {
      menuItems.add(const MenuItem(
          Constants.visitorpassmgmt, AppIcon.visitorPassManagementRegisterIcon, 0));
    }
  }
}
