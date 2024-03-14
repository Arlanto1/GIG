part of 'guarding_rates_bloc.dart';

class GuardingRatesState extends Equatable {
  final List<GMRate> items;
  final bool hasReachedMax;
  final FormStatus status;
  final Locations? locations;
  final CommonFilters? commonFilters;
  final String? message;
  final GRUiLabels? labels;

  const GuardingRatesState(
      {this.items = const <GMRate>[],
      this.hasReachedMax = false,
      this.message,
      this.locations,
      this.commonFilters,
      this.labels,
      this.status = FormStatus.initial});

  GuardingRatesState copyWith({
    List<GMRate>? items,
    bool? hasReachedMax,
    FormStatus? status,
    Locations? locations,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    String? message,
    GRUiLabels? labels,
  }) {
    return GuardingRatesState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      commonFilters: commonFilters ?? this.commonFilters,
      locations: locations ?? this.locations,
      labels: labels ?? this.labels,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
