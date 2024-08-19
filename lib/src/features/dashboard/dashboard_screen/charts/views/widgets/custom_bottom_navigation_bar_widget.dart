import 'dart:developer';

import 'package:db_atom/index.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final BuildContext context;
  final DisplayMenu displayMenu;

  const CustomBottomNavigationBar({
    super.key,
    required this.displayMenu,
    required this.scaffoldKey,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: FloatingNavbar(
        onTap: _handleNavTap,
        backgroundColor: AppColors.navigationSkyBlueColor,
        selectedBackgroundColor: AppColors.white,
        selectedItemColor: AppColors.navigationSkyBlueColor,
        currentIndex: 0,
        // Consider making this dynamic if needed
        items: [
          // Use 'const' for efficiency since these items don't change
          FloatingNavbarItem(
            icon: Icons.person_pin_outlined,
            title: Constants.guardingOperations,
          ),
          FloatingNavbarItem(
            icon: Icons.supervised_user_circle_sharp,
            title: Constants.materialMovement,
          ),
          FloatingNavbarItem(
            icon: Icons.quick_contacts_mail_rounded,
            title: Constants.passManagement,
          ),
          FloatingNavbarItem(
            icon: Icons.calendar_month,
            title: Constants.shiftScheduling,
          ),

          FloatingNavbarItem(
            icon: Icons.key,
            title: Constants.keyManagementData,
          ),
          // Additional items can be added here...
        ],
      ),
    );
  }

  void _handleNavTap(int selectedIndex) {
    // Get the position of the tapped item
    final RenderBox? renderBox =
        scaffoldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      log('Error: Could not find RenderBox for Scaffold');
      return; // Handle the case where RenderBox is not found
    }

    final Offset offset = renderBox.localToGlobal(Offset.zero);
    const int itemCount = 7; // Define the number of items as a constant
    final double itemWidth = renderBox.size.width / itemCount;
    final double positionX =
        offset.dx + selectedIndex * itemWidth + itemWidth / 2;

    final bottomMenuHandler = BottomMenuHandler(
        context: context, displayMenu: displayMenu, positionX: positionX);

    switch (selectedIndex) {
      case 0:
        bottomMenuHandler.openGuardingOperationSubMenu();
        break;
      case 1:
        bottomMenuHandler.openMaterialMovementSubMenu();
        break;
      case 2:
        bottomMenuHandler.openPassManagementSubMenu();
        break;
      case 3:
        bottomMenuHandler.openShiftScheduleSubMenu();
        break;
      case 4:
        bottomMenuHandler.openKeyManagementDataSubMenu();
        break;
      default:
        log('Invalid tab index: $selectedIndex');
    }
  }
}
