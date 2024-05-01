part of 'attendance_report_billing_bloc.dart';

abstract class AttendanceReportBillingEvent extends Equatable {
  const AttendanceReportBillingEvent();

  @override
  List<Object?> get props => [];
}

class FetchAttendanceReportBillingList extends AttendanceReportBillingEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchAttendanceReportBillingList(
      {required this.startPos,
      required this.maxPos,
      required this.newSearch,
      required this.filters});
}

class InitializeValues extends AttendanceReportBillingEvent {
  const InitializeValues();
}

class RefreshList extends AttendanceReportBillingEvent {
  const RefreshList();
}
