import 'dart:developer';

import 'package:db_atom/index.dart';

class FloatingSubMenu extends StatelessWidget {
  final List<MenuItem> menuItems; // Updated to use MenuItem
  final void Function(BuildContext context, int index) onOptionSelected;
  final double positionX; // X position of the submenu

  const FloatingSubMenu({
    super.key,
    required this.menuItems,
    required this.onOptionSelected,
    required this.positionX,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 70.0,
      left: positionX - 40, // Adjusted position
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 1),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: menuItems.asMap().entries.map((entry) {
              int idx = entry.key;
              MenuItem item = entry.value;
              return GestureDetector(
                onTap: () {
                  log('x');
                  Navigator.of(context).pop(); // Close the menu
                  onOptionSelected(context, idx);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            item.imageName,
                            height: 20, // Set your desired height
                            width: 20, // Set your desired width
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              item.title,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
