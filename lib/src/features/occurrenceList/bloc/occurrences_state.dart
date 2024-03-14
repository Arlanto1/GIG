part of 'occurrences_bloc.dart';

class OccurrencesState extends Equatable {
  final List<Occurrence> list;
  final bool hasReachedMax;
  final FormStatus status;
  final String? message;
  final Locations? locations;
  final CommonFilters? commonFilters;
  final OCCUiLabels? labels;

  const OccurrencesState({
    this.list = const <Occurrence>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.message,
    this.locations,
    this.commonFilters,
    this.labels,
  });

  OccurrencesState copyWith({
    List<Occurrence>? items,
    bool? hasReachedMax,
    FormStatus? status,
    CommonFilters? commonFilters,
    Locations? locations,
    String? message,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    OCCUiLabels? labels,
  }) {
    return OccurrencesState(
      list: items ?? list,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      locations: locations ?? this.locations,
      commonFilters: commonFilters ?? this.commonFilters,
      labels: labels ?? this.labels,
    );
  }

  @override
  List<Object?> get props => [list, hasReachedMax, status];
}
