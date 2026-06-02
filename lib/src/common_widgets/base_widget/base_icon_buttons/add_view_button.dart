import 'package:db_atom/index.dart';

class AddViewButton extends StatelessWidget {
  const AddViewButton({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SvgPicture.asset(
          AppIcon.plusCircle,
          colorFilter: const ColorFilter.mode(
            AppColors.navigationSkyBlueColor,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.navigationSkyBlueColor,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
