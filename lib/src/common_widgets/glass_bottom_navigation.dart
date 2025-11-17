
import 'dart:ui';

import 'package:db_atom/index.dart';

class GlassBottomNavExample extends StatefulWidget {
  const GlassBottomNavExample({super.key});

  @override
  State<GlassBottomNavExample> createState() => _GlassBottomNavExampleState();
}

class _GlassBottomNavExampleState extends State<GlassBottomNavExample> {
  int _selectedIndex = 0;

  final List<IconData> icons = [
    Icons.home_rounded,
    Icons.search_rounded,
    Icons.notifications_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF071130),
      extendBody: true, // to allow FAB overlap

      // 🟣 Floating Action Button (centered circular)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 68,
        height: 68,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.12),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.25),
              blurRadius: 20,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.3),
                    Colors.white.withValues(alpha: 0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white, size: 32),
                onPressed: () {
                  // FAB tap action
                },
              ),
            ),
          ),
        ),
      ),

      // 🧭 Bottom Navigation Bar
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // curved background with notch
          CustomPaint(
            size: const Size(double.infinity, 90),
            painter: _NavBarPainter(
              backgroundColor: const Color(0xFF0A163F),
            ),
          ),

          // icons row
          SizedBox(
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(icons.length, (index) {
                return IconButton(
                  onPressed: () => setState(() => _selectedIndex = index),
                  icon: Icon(
                    icons[index],
                    color: _selectedIndex == index
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.5),
                    size: 28,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// 🎨 Custom curved background for bottom nav
class _NavBarPainter extends CustomPainter {
  final Color backgroundColor;
  _NavBarPainter({required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.35, 0);
    path.quadraticBezierTo(
        size.width * 0.5, 50, size.width * 0.65, 0); // notch curve
    path.lineTo(size.width, 0);
    path.lineTo(size.width, 90);
    path.lineTo(0, 90);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
