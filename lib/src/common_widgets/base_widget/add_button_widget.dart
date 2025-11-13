import 'package:db_atom/index.dart';

class AddButtonWidget extends StatelessWidget {
  const AddButtonWidget({
    super.key,
    this.isDisableColor,
    this.height,
  });

  final bool? isDisableColor;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 75,
      width: 60,
      decoration: BoxDecoration(
          color: (isDisableColor ?? false)
              ? Colors.transparent
              : const Color(0xFF071130).withValues(alpha: 0.4),
          border: Border.all(
            color: (isDisableColor ?? false)
                ? Colors.white12
                : Colors.white,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(24))),
      child: const Center(
        child: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.white,
        ),

        // SvgPicture.asset(
        //   AppIcon.addicon,
        //   width: 20,
        //   height: 20,
        //   key: const Key(
        //     Keys.userIcon,
        //   ),
        // ), //Icon(Icons.add,color: AppColors.backgroundWhitecolor,size: 60,)
      ),
    );
  }
}
