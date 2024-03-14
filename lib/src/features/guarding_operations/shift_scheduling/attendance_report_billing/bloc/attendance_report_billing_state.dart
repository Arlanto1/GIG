part of 'attendance_report_billing_bloc.dart';

class AttendanceReportBillingState extends Equatable {
  final List<AttendanceReportBillingModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final String? message;
  final CommonFilters? commonFilters;
  final Locations? locations;
  final SSUiLabels? labels;

  const AttendanceReportBillingState({
    this.items = const <AttendanceReportBillingModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.message,
    this.labels,
    this.locations,
    this.commonFilters,
  });

  AttendanceReportBillingState copyWith({
    List<AttendanceReportBillingModel>? items,
    bool? hasReachedMax,
    String? message,
    FormStatus? status,
    SSUiLabels? labels,
    Locations? locations,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
  }) {
    return AttendanceReportBillingState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      labels: labels ?? this.labels,
      message: message ?? this.message,
      commonFilters: commonFilters ?? this.commonFilters,
      locations: locations ?? this.locations,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
