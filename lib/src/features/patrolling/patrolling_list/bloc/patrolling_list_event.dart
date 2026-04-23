part of 'patrolling_list_bloc.dart';

abstract class PatrollingListEvent extends Equatable {
  const PatrollingListEvent();

  @override
  List<Object?> get props => [];
}

class FetchPatrolData extends PatrollingListEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchPatrolData(
      {required this.startPos,
        required this.maxPos,
        required this.newSearch,
        required this.filters
      });
}

class InitializeValuesPatrolling extends PatrollingListEvent {
  const InitializeValuesPatrolling();
}

class RefreshList extends PatrollingListEvent {
  const RefreshList();
}
