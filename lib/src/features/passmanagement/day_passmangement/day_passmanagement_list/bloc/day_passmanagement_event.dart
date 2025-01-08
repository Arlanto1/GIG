
part of 'day_passmanagement_bloc.dart';

abstract class DayPassManagementEvent extends Equatable {
  const DayPassManagementEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends DayPassManagementEvent {
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

class InitializeValues extends DayPassManagementEvent {
  const InitializeValues();
}

class RefreshList extends DayPassManagementEvent {
  const RefreshList();
}
