part of 'sla_violation_penalty_list_bloc.dart';

abstract class SLAViolationPenaltyListEvent extends Equatable {
  const SLAViolationPenaltyListEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends SLAViolationPenaltyListEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchData(
      {required this.startPos,
      required this.maxPos,
      required this.newSearch,
      required this.filters});
}

class InitializeValues extends SLAViolationPenaltyListEvent {
  const InitializeValues();
}

class RefreshList extends SLAViolationPenaltyListEvent {
  const RefreshList();
}
