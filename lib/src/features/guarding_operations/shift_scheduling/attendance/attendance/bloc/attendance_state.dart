part of 'attendance_bloc.dart';

class AttendanceState extends Equatable {
  final List<AttendanceModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final String? message;
  final CommonFilters? commonFilters;
  final Locations? locations;
  final SSUiLabels? labels;

  const AttendanceState({
    this.items = const <AttendanceModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.labels,
    this.message,
    this.locations,
    this.commonFilters,
  });

  AttendanceState copyWith({
    List<AttendanceModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    SSUiLabels? labels,
    String? message,
    Locations? locations,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
  }) {
    return AttendanceState(
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
