part of 'shift_schedule_list_bloc.dart';

class ShiftScheduleListState extends Equatable {
  final List<ShiftScheduleModel> list;
  final bool hasReachedMax;
  final FormStatus status;

  //final GmUiLabels? labels;

  const ShiftScheduleListState({
    this.list = const <ShiftScheduleModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    //this.labels
  });

  ShiftScheduleListState copyWith({
    List<ShiftScheduleModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    // GmUiLabels? labels,
  }) {
    return ShiftScheduleListState(
      list: items ?? list,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      // labels: labels ?? this.labels
    );
  }

  @override
  List<Object?> get props => [list, hasReachedMax, status];
}
