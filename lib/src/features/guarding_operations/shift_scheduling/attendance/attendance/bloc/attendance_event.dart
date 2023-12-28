part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object?> get props => [];
}

class FetchAttendanceList extends AttendanceEvent {
  final int startPos;
  final int maxPos;

  const FetchAttendanceList(
      {required this.startPos, required this.maxPos});
}

class InitializeValues extends AttendanceEvent {
  const InitializeValues();
}
