import 'dart:developer';

import 'package:db_atom/index.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final BuildContext context;
  final DisplayMenu displayMenu;

  CustomBottomNavigationBar({
    super.key,
    required this.displayMenu,
    required this.scaffoldKey,
    required this.context,
  });

  List<FloatingNavbarItem> getMenuItems() {
    List<FloatingNavbarItem> items = [];

    if (displayMenu.gM ?? false) {
      items.add(
        FloatingNavbarItem(
          icon: Icons.person_pin_outlined,
          title: Constants.guardingOperations,
        ),
      );
    }
    if (displayMenu.mM ?? false) {
      items.add(
        FloatingNavbarItem(
          icon: Icons.supervised_user_circle_sharp,
          title: Constants.materialMovement,
        ),
      );
    }
    if (displayMenu.pM ?? false) {
      items.add(
        FloatingNavbarItem(
          icon: Icons.quick_contacts_mail_rounded,
          title: Constants.passManagement,
        ),
      );
    }
    if (displayMenu.keyMM ?? false) {
      items.add(
        FloatingNavbarItem(
          icon: Icons.key,
          title: Constants.keyManagementData,
        ),
      );
    }
    if (displayMenu.sS ?? false) {
      items.add(
        FloatingNavbarItem(
          icon: Icons.calendar_month,
          title: Constants.shiftScheduling,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    List<FloatingNavbarItem> menuItems = getMenuItems();

    return SizedBox(
      height: 140,
      child: FloatingNavbar(
        onTap: (index) => _handleNavTap(index, menuItems),
        backgroundColor: AppColors.navigationSkyBlueColor,
        selectedBackgroundColor: AppColors.white,
        selectedItemColor: AppColors.navigationSkyBlueColor,
        currentIndex: 0,
        items: menuItems,
      ),
    );
  }

  void _handleNavTap(int selectedIndex, List<FloatingNavbarItem> menuItems) {
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
      context: context,
      displayMenu: displayMenu,
      positionX: positionX,
    );

    switch (menuItems[selectedIndex].title) {
      case Constants.guardingOperations:
        bottomMenuHandler.openGuardingOperationSubMenu();
        break;
      case Constants.materialMovement:
        bottomMenuHandler.openMaterialMovementSubMenu();
        break;
      case Constants.passManagement:
        bottomMenuHandler.openPassManagementSubMenu();
        break;
      case Constants.keyManagementData:
        bottomMenuHandler.openKeyManagementDataSubMenu();
        break;
      case Constants.shiftScheduling:
        bottomMenuHandler.openShiftScheduleSubMenu();
        break;
       }
  }
}
