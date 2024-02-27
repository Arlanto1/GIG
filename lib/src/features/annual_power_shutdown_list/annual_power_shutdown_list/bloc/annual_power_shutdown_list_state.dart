part of 'annual_power_shutdown_list_bloc.dart';

class AnnualPowerShutdownListState extends Equatable {
  final List<AnnualPowerShutDownModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final Locations? locations;
  final CommonFilters? commonFilters;


  const AnnualPowerShutdownListState(
      {this.items = const <AnnualPowerShutDownModel>[],
        this.hasReachedMax = false,
        this.commonFilters,
        this.locations,
        this.status = FormStatus.initial});

  AnnualPowerShutdownListState copyWith({
    List<AnnualPowerShutDownModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    Locations? locations,
  }) {
    return AnnualPowerShutdownListState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      commonFilters: commonFilters ?? this.commonFilters,
      locations: locations ?? this.locations,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
