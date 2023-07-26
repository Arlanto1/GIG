import 'package:db_atom/src/common_widgets/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitializeProviders extends StatelessWidget {
  final Widget child;
  const InitializeProviders({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => foundListArticleCubit),
        BlocProvider(create: (context) => createFoundArticleCubit),
        BlocProvider(create: (context) => lawenforcementCubit),
      ],
      child: child,
    );
  }
}
