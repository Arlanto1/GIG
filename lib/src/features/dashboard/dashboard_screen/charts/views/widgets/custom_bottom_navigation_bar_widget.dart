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

  List<BottomMenuItem> prepareMenuItems() {
    final List<BottomMenuItem> bottomMenuItems = [];
    bool guardingOperations = ((displayMenu.gM ?? false) ||
        (displayMenu.cD ?? false) ||
        (displayMenu.gR ?? false) ||
        (displayMenu.oCC ?? false) ||
        (displayMenu.sVP ?? false) ||
        (displayMenu.gMR ?? false));

    if (guardingOperations) {
      bottomMenuItems.add(
        BottomMenuItem(
          title: Constants.guardingOperations,
          menuItem: FloatingNavbarItem(
            icon: Icons.person_pin_outlined,
            title: Constants.guardingOperations,
          ),
          onTap: () {
            final bottomMenuHandler = BottomMenuHandler(
              context: context,
              displayMenu: displayMenu,
              positionX: getItemPositionX(0),
            );
            bottomMenuHandler.openGuardingOperationSubMenu();
          },
        ),
      );
    }

    // if (displayMenu.mM ?? false) {
    //   bottomMenuItems.add(
    //     BottomMenuItem(
    //       title: Constants.materialMovement,
    //       menuItem: FloatingNavbarItem(
    //         icon: Icons.supervised_user_circle_sharp,
    //         title: Constants.materialMovement,
    //       ),
    //       onTap: () {
    //         final bottomMenuHandler = BottomMenuHandler(
    //           context: context,
    //           displayMenu: displayMenu,
    //           positionX: getItemPositionX(1),
    //         );
    //         bottomMenuHandler.openMaterialMovementSubMenu();
    //       },
    //     ),
    //   );
    // }
    if (displayMenu.pM ?? false) {
      bottomMenuItems.add(
        BottomMenuItem(
          title: Constants.passManagement,
          menuItem: FloatingNavbarItem(
            icon: Icons.quick_contacts_mail_rounded,
            title: Constants.passManagement,
          ),
          onTap: () {
            final bottomMenuHandler = BottomMenuHandler(
              context: context,
              displayMenu: displayMenu,
              positionX: getItemPositionX(2),
            );
            bottomMenuHandler.openPassManagementSubMenu();
          },
        ),
      );
    }

    if (displayMenu.keyMM ?? false) {
      bottomMenuItems.add(
        BottomMenuItem(
          title: Constants.keyManagementData,
          menuItem: FloatingNavbarItem(
            icon: Icons.key,
            title: Constants.keyManagementData,
          ),
          onTap: () {
            final bottomMenuHandler = BottomMenuHandler(
              context: context,
              displayMenu: displayMenu,
              positionX: getItemPositionX(3),
            );
            bottomMenuHandler.openKeyManagementDataSubMenu();
          },
        ),
      );
    }

    if (displayMenu.sS ?? false) {
      bottomMenuItems.add(
        BottomMenuItem(
          title: Constants.shiftScheduling,
          menuItem: FloatingNavbarItem(
            icon: Icons.calendar_month,
            title: Constants.shiftScheduling,
          ),
          onTap: () {
            final bottomMenuHandler = BottomMenuHandler(
              context: context,
              displayMenu: displayMenu,
              positionX: getItemPositionX(4),
            );
            bottomMenuHandler.openShiftScheduleSubMenu();
          },
        ),
      );
    }

    return bottomMenuItems;
  }

  double getItemPositionX(int index) {
    final RenderBox? renderBox =
        scaffoldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return 0.0;

    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final int itemCount = prepareMenuItems().length + 2;
    final double itemWidth = renderBox.size.width / itemCount;

    return offset.dx + index * itemWidth + itemWidth / 2;
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = prepareMenuItems();

    return SizedBox(
      height: 140,
      child: FloatingNavbar(
        onTap: (index) {
          if (index < menuItems.length) {
            menuItems[index].onTap(); // Call the corresponding onTap action
          }
        },
        backgroundColor: AppColors.navigationSkyBlueColor,
        selectedBackgroundColor: AppColors.white,
        selectedItemColor: AppColors.navigationSkyBlueColor,
        currentIndex: 0,
        items: menuItems
            .map((item) => item.menuItem)
            .toList(), // Use prepared menu items
      ),
    );
  }
}

class BottomMenuItem {
  final String title;
  final FloatingNavbarItem menuItem;
  final Function() onTap; // Add an onTap function

  BottomMenuItem({
    required this.title,
    required this.menuItem,
    required this.onTap,
  });
}
