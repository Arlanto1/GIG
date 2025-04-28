
part of 'law_enforcement_bloc_new.dart';

abstract class LawEnforcementEvent extends Equatable {
  const LawEnforcementEvent();

  @override
  List<Object?> get props => [];
}

class FetchLeoData extends LawEnforcementEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchLeoData(
      {required this.startPos,
        required this.maxPos,
        required this.newSearch,
        required this.filters});
}

class InitializeLeoValues extends LawEnforcementEvent {
  const InitializeLeoValues();
}

class RefreshLeoList extends LawEnforcementEvent {
  const RefreshLeoList();
}
