part of 'attendance_bloc.dart';

class AttendanceState extends Equatable {
  final List<AttendanceModel> list;
  final bool hasReachedMax;
  final FormStatus status;

  //final GmUiLabels? labels;

  const AttendanceState({
    this.list = const <AttendanceModel>[],
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
      list: items ?? list,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      // labels: labels ?? this.labels
    );
  }

  @override
  List<Object?> get props => [list, hasReachedMax, status];
}
