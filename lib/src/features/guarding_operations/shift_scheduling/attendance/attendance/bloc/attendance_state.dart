part of 'attendance_bloc.dart';

class AttendanceState extends Equatable {
  final List<AttendanceModel> items;
  final bool hasReachedMax;
  final FormStatus status;

  //final GmUiLabels? labels;

  const AttendanceState({
    this.items = const <AttendanceModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    //this.labels
  });

  AttendanceState copyWith({
    List<AttendanceModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    // GmUiLabels? labels,
  }) {
    return AttendanceState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      // labels: labels ?? this.labels
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
