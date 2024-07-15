import 'package:db_atom/index.dart';

class NotificationBell extends StatelessWidget {
  final int notificationCount;

  const NotificationBell({super.key, required this.notificationCount});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, notificationsViewRoute);
      },
      child: Stack(
        children: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, notificationsViewRoute);
            },
          ),
          Positioned(
            right: 0,
            top: 0,
            child: notificationCount > 0
                ? Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$notificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
