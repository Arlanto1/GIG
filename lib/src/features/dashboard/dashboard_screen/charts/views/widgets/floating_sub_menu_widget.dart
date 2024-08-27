import 'package:db_atom/index.dart';
import 'package:db_atom/src/utils/device_infomation.dart';

class FloatingSubMenuWidget extends StatelessWidget {
  final List<MenuItem> menuItems;
  final void Function(BuildContext context, int index) onOptionSelected;
  final double positionX;

  const FloatingSubMenuWidget({
    super.key,
    required this.menuItems,
    required this.onOptionSelected,
    required this.positionX,
  });


  @override
  Widget build(BuildContext context) {
    // Use a more descriptive name for the constant
    const double menuOffset = 30.0;

    return Positioned(
      bottom: 70.0,
      left: positionX - menuOffset,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width:  DeviceInformation().detectDeviceType(context) == DeviceType.tablet? 270: 180,
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
              int index = entry.key;
              MenuItem item = entry.value;
              return InkWell(
                onTap: () {
                  Navigator.of(context).pop(); // to close sub menu
                  onOptionSelected(context, index);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Image.asset(
                        item.imageName,
                        height: 20,
                        width: 20,
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
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
