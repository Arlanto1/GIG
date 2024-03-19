part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object?> get props => [];
}

class FetchAttendanceList extends AttendanceEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchAttendanceList(
      {required this.startPos,
      required this.maxPos,
      required this.newSearch,
      required this.filters});
}

class InitializeValues extends AttendanceEvent {
  const InitializeValues();
}

class RefreshList extends AttendanceEvent {
  const RefreshList();
}
