import 'dart:ui';

import 'package:db_atom/index.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({
    super.key,
    required this.username,
    required this.email,
  });

  final String username;
  final String email;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(color: AppColors.backgroundWhiteColor),
      child: InkWell(
        onTap: () async {
          // Navigator.pushNamed(
          //   context,
          //   resetPwdScreenRoute,
          //   arguments: {'viaNavigationDrawer': true},
          // );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 30.0,
              backgroundColor: AppColors.navigationSkyBlueColor,
              child: CircleAvatar(
                backgroundColor: AppColors.backgroundWhiteColor,
                radius: 28.0,
                child: CircleAvatar(
                  backgroundColor: AppColors.divideLineGreyColor,
                  radius: 25,
                  backgroundImage: AssetImage(AppIcon.userImage),
                ),
              ),

              // NetworkImage("Your Photo Url"), // for Network image
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(username, style: Styles.textStyleGrey16),
                  Text(email, style: Styles.textStyleRegularNormalGrey14),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
