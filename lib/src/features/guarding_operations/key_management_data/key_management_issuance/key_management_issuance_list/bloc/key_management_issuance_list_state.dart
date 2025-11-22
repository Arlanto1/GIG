part of 'key_management_issuance_list_bloc.dart';

class KeyManagementIssuanceListState extends Equatable {
  final List<KeyManagementIssuanceModel> list;
  final bool hasReachedMax;
  final FormStatus status;
  final String? message;
  final CommonFilters? commonFilters;
  final Locations? locations;
  final ExtraProperties? extraProperties;
  final DisplayMenu? displayMenu;

  final KMUiLabels? labels;

  const KeyManagementIssuanceListState({
    this.list = const <KeyManagementIssuanceModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.message,
    this.locations,
    this.commonFilters,
    this.labels,
    this.extraProperties,
    this.displayMenu,
  });

  KeyManagementIssuanceListState copyWith({
    List<KeyManagementIssuanceModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    String? message,
    Locations? locations,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    KMUiLabels? labels,
    ExtraProperties? extraProperties,
  }) {
    return KeyManagementIssuanceListState(
      list: items ?? list,
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
  List<Object?> get props => [list, hasReachedMax, status];
}
