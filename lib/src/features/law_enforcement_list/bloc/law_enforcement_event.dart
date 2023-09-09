part of 'law_enforcement_bloc.dart';

@immutable
abstract class LawEnforcementEvent extends Equatable {
  const LawEnforcementEvent();

  @override
  List<Object?> get props => [];
}

class LawEnforcementFetch extends LawEnforcementEvent {
  final int startPos;
  final int maxPos;
  final BuildContext cont;

  const LawEnforcementFetch({required this.startPos, required this.maxPos,required this.cont});
}

class LawEnforcementRefresh extends LawEnforcementEvent {
  const LawEnforcementRefresh();
}
