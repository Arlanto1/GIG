import 'package:db_atom/index.dart';

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.height,
    required this.label,
    this.icon = Icons.info,
  });

  final double height;
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.navigationSkyBlueColor, // Border color
            width: .7, // Border width
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x11000000),
              offset: Offset(0, 4),
              blurRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.navigationSkyBlueColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Icon(
                      icon,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // CommonWidgets.verticalSpacerWidget(height * 0.01),
              Text(
                label,
                softWrap: true,
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.clip, // Clip text when it overflows
              ),
            ],
          ),
        ),
      ),
    );
  }
}
