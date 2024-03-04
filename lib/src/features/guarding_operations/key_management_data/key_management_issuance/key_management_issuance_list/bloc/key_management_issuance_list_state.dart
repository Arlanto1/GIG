part of 'key_management_issuance_list_bloc.dart';

class KeyManagementIssuanceListState extends Equatable {
  final List<KeyManagementIssuanceModel> list;
  final bool hasReachedMax;
  final FormStatus status;
  final String? message;
  final CommonFilters? commonFilters;
  final Locations? locations;

  //final GmUiLabels? labels;

  const KeyManagementIssuanceListState({
    this.list = const <KeyManagementIssuanceModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.message,
    this.locations,
    this.commonFilters,
    //this.labels
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
    // GmUiLabels? labels,
  }) {
    return KeyManagementIssuanceListState(
      list: items ?? list,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      commonFilters: commonFilters ?? this.commonFilters,
      locations: locations ?? this.locations,
      // labels: labels ?? this.labels
    );
  }

  @override
  List<Object?> get props => [list, hasReachedMax, status];
}
