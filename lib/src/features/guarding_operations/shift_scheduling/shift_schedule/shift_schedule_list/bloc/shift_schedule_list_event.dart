part of 'shift_schedule_list_bloc.dart';

abstract class ShiftScheduleListEvent extends Equatable {
  const ShiftScheduleListEvent();

  @override
  List<Object?> get props => [];
}

class FetchShiftScheduleList extends ShiftScheduleListEvent {
  final int startPos;
  final int maxPos;

  const FetchShiftScheduleList({required this.startPos, required this.maxPos});
}

class InitializeValues extends ShiftScheduleListEvent {
  const InitializeValues();
}
