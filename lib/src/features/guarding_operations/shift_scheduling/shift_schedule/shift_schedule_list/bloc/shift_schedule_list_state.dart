part of 'shift_schedule_list_bloc.dart';

class ShiftScheduleListState extends Equatable {
  final List<ShiftScheduleModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final String? message;
  final SSUiLabels? labels;

  const ShiftScheduleListState({
    this.items = const <ShiftScheduleModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.message,
    this.labels
  });

  ShiftScheduleListState copyWith({
    List<ShiftScheduleModel>? items,
    bool? hasReachedMax,
    String? message,
    FormStatus? status,
    SSUiLabels? labels,
  }) {
    return ShiftScheduleListState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      labels: labels ?? this.labels
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
