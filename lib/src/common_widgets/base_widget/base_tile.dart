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
          color: Colors.transparent,
          border: Border.all(
            color: AppColors.white, // Border color
            width: 0.7, // Border width
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
                  // decoration: BoxDecoration(
                  //   color: AppColors.white.withValues(alpha: 0.8),
                  //   borderRadius: BorderRadius.circular(5),
                  // ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.withValues(
                            alpha: 0.2),
                        Colors.transparent,
                        Colors.red.withValues(
                            alpha: 0.2),
                        // Color(0xFF6474C6).withOpacity(0.14)
                      ],
                      stops: const [0.02, 0.35, 1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius
                        .circular(0),
                    border: Border.all(
                      color: Colors.white
                          .withValues(alpha: 0.80),
                      width: 0.8,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(
                            0xFF6474C6).withValues(
                            alpha: 0.09),
                        blurRadius: 12,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Icon(
                      icon,
                      color: AppColors.white,
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
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
