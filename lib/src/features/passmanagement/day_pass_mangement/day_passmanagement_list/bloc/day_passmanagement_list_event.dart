
part of 'day_passmanagement_list_bloc.dart';

abstract class DayPassManagementListEvent extends Equatable {
  const DayPassManagementListEvent();

  @override
  List<Object?> get props => [];
}

class FetchDayPassData extends DayPassManagementListEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchDayPassData(
      {required this.startPos,
        required this.maxPos,
        required this.newSearch,
        required this.filters});
}

class InitializeDayPassValues extends DayPassManagementListEvent {
  const InitializeDayPassValues();
}

class RefreshDayPassList extends DayPassManagementListEvent {
  const RefreshDayPassList();
}
