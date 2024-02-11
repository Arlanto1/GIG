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
      height: height ?? 60,
      width: 50,
      decoration: BoxDecoration(
          color: (isDisableColor ?? false)
              ? AppColors.gerylightBackground
              : AppColors.navigationSkybluecolor,
          border: Border.all(
            color: (isDisableColor ?? false)
                ? AppColors.gerylightBackground
                : AppColors.navigationSkybluecolor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
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
