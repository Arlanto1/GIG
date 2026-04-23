part of 'patrolling_list_bloc.dart';

class PatrollingListState extends Equatable {
  final List<PatrollingModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final Locations? locations;
  final CommonFilters? commonFilters;
  final String? message;
  final IMUiLabels? labels;
  final ExtraProperties? extraProperties;
  final DisplayMenu? displayMenu;


  const PatrollingListState({
    this.items = const <PatrollingModel>[],
    this.hasReachedMax = false,
    this.locations,
    this.commonFilters,
    this.message,
    this.labels,
    this.status = FormStatus.initial,
    this.extraProperties,
    this.displayMenu
  });

  PatrollingListState copyWith({
    List<PatrollingModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    Locations? locations,
    String? message,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    IMUiLabels? labels,
    ExtraProperties? extraProperties,
  }) {
    return PatrollingListState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      commonFilters: commonFilters ?? this.commonFilters,
      locations: locations ?? this.locations,
      labels: labels ?? this.labels,
      extraProperties: extraProperties ?? this.extraProperties,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
