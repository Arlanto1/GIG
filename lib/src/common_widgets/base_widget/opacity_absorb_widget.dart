import 'package:db_atom/index.dart';

class OpacityAbsorbInkWellWidget extends StatelessWidget {
  final bool absorbing;
  final Widget child;
  final VoidCallback? onTap;

  const OpacityAbsorbInkWellWidget({
    super.key,
    required this.absorbing,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: absorbing ? 0.5 : 1,
      child: AbsorbPointer(
        absorbing: absorbing,
        child: InkWell(
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
