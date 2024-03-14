part of 'shift_schedule_list_bloc.dart';

abstract class ShiftScheduleListEvent extends Equatable {
  const ShiftScheduleListEvent();

  @override
  List<Object?> get props => [];
}

class FetchShiftScheduleList extends ShiftScheduleListEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchShiftScheduleList({required this.startPos, required this.maxPos,required this.newSearch,
    required this.filters});
}

class InitializeValues extends ShiftScheduleListEvent {
  const InitializeValues();
}

class RefreshList extends ShiftScheduleListEvent {
  const RefreshList();
}
