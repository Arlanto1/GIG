part of 'guarding_master_data_bloc.dart';

class GuardingMasterDataState extends Equatable {
  final List<GuardingMastersDataModel> list;
  final bool hasReachedMax;
  final FormStatus status;
  final GmUiLabels? labels;
  final CommonFilters? commonFilters;
  final Locations? locations;
  final String? message;

  const GuardingMasterDataState({
    this.list = const <GuardingMastersDataModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.labels,
    this.message,
    this.locations,
    this.commonFilters,
  });

  GuardingMasterDataState copyWith({
    List<GuardingMastersDataModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    GmUiLabels? labels,
    String? message,
    Locations? locations,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
  }) {
    return GuardingMasterDataState(
      list: items ?? list,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      labels: labels ?? this.labels,
      message: message ?? this.message,
      commonFilters: commonFilters ?? this.commonFilters,
      locations: locations ?? this.locations,
    );
  }

  @override
  List<Object?> get props => [list, hasReachedMax, status];
}
