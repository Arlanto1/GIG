part of 'attendance_report_billing_bloc.dart';

abstract class AttendanceReportBillingEvent extends Equatable {
  const AttendanceReportBillingEvent();

  @override
  List<Object?> get props => [];
}

class FetchAttendanceList extends AttendanceReportBillingEvent {
  final int startPos;
  final int maxPos;

  const FetchAttendanceList(
      {required this.startPos, required this.maxPos});
}

class InitializeValues extends AttendanceReportBillingEvent {
  const InitializeValues();
}
