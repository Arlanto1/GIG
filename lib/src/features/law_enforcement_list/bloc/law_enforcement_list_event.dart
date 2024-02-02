part of 'law_enforcement_list_bloc.dart';

@immutable
abstract class LawEnforcementListEvent extends Equatable {
  const LawEnforcementListEvent();

  @override
  List<Object?> get props => [];
}

class LawEnforcementFetch extends LawEnforcementListEvent {
  final int startPos;
  final int maxPos;
  final BuildContext cont;

  const LawEnforcementFetch({required this.startPos, required this.maxPos,required this.cont});
}

class LawEnforcementRefresh extends LawEnforcementListEvent {
  const LawEnforcementRefresh();
}
