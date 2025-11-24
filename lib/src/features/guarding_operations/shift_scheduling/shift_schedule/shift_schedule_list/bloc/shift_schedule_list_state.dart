part of 'shift_schedule_list_bloc.dart';

class ShiftScheduleListState extends Equatable {
  final List<ShiftScheduleModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final String? message;
  final CommonFilters? commonFilters;
  final Locations? locations;
  final SSUiLabels? labels;
  final ExtraProperties? extraProperties;
  final DisplayMenu? displayMenu;

  const ShiftScheduleListState({
    this.items = const <ShiftScheduleModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.message,
    this.labels,
    this.locations,
    this.commonFilters,
    this.extraProperties,
    this.displayMenu
  });

  ShiftScheduleListState copyWith({
    List<ShiftScheduleModel>? items,
    bool? hasReachedMax,
    String? message,
    FormStatus? status,
    SSUiLabels? labels,
    Locations? locations,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    ExtraProperties? extraProperties,
  }) {
    return ShiftScheduleListState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      labels: labels ?? this.labels,
      message: message ?? this.message,
      commonFilters: commonFilters ?? this.commonFilters,
      locations: locations ?? this.locations,
      extraProperties: extraProperties ?? this.extraProperties,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
