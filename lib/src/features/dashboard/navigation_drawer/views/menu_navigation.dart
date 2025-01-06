import 'package:db_atom/index.dart';

class MenuNavigation {
  // TODO: Need to use in drawer_reusable
  void onPassManagementItemSelected({
    required BuildContext context,
    required int index,
  }) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
          "passMngDetails": PassMngArguments(0, 'Day Pass Management', false)
        });
        break;
      case 1:
        Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
          "passMngDetails": PassMngArguments(3, 'SEZ Pass Management', false)
        });
        break;
      case 2:
        Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
          "passMngDetails": PassMngArguments(2, 'Vendor Pass Management', false)
        });
        break;
      case 3:
        Navigator.pushNamed(context, daypassmanagementListRoute, arguments: {
          "passMngDetails":
              PassMngArguments(1, 'Visitor Pass Management', false)
        });
        break;
      default:
        break;
    }
  }

  // TODO: Need to use in drawer_reusable
  void onShiftScheduleItemSelected({
    required BuildContext context,
    required int index,
  }) {
    switch (index) {
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

  onKeyManagementItemSelected({
    required BuildContext context,
    required int index,
  }) async {
    // _menuScaffoldKey.currentState!.closeDrawer();
    // _passlastSelectedItem = index;
    //BlocProvider.of<DrawerCubit>(context).getindexChange(index);
    //state = const DrawerInitial();
    // context.read<DrawerCubit>().getPassMgmtIndexChange(index);
    switch (index) {
      case 0:
        Navigator.pushNamed(context, keyManagementMasterListRoute,
            arguments: {"Key Management Master": false});
        break;
      case 1:
        Navigator.pushNamed(context, keyManagementIssuanceListRoute,
            arguments: {"Key Management Issuance List": false});
        break;
      case 2:
        Navigator.pushNamed(context, keyLossDestructionListRoute,
            arguments: {"Key Loss Destruction List": false});
        break;
    }
  }
}
