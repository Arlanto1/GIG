part of 'attendance_report_billing_bloc.dart';

class AttendanceReportBillingState extends Equatable {
  final List<AttendanceModel> items;
  final bool hasReachedMax;
  final FormStatus status;

  //final GmUiLabels? labels;

  const AttendanceReportBillingState({
    this.items = const <AttendanceModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    //this.labels
  });

  AttendanceReportBillingState copyWith({
    List<AttendanceModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    // GmUiLabels? labels,
  }) {
    return AttendanceReportBillingState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      // labels: labels ?? this.labels
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
