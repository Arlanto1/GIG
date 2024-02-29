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
  final bool newSearch;
  final BaseFilterModel filters;

  const LawEnforcementFetch(
      {required this.startPos, required this.maxPos,required this.newSearch, required this.filters});
}

class LawEnforcementRefresh extends LawEnforcementListEvent {
  const LawEnforcementRefresh();
}

class InitializeValuesLEO extends LawEnforcementListEvent {
  const InitializeValuesLEO();
}

class RefreshList extends LawEnforcementListEvent {
  const RefreshList();
}
