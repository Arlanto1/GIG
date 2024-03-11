part of 'key_management_master_list_bloc.dart';

class KeyManagementMasterListState extends Equatable {
  final List<KeyManagementMasterModel> list;
  final bool hasReachedMax;
  final FormStatus status;

  // final SlaUiLabels? labels;
  final String? message;
  final CommonFilters? commonFilters;
  final Locations? locations;

  //final GmUiLabels? labels;

  const KeyManagementMasterListState({
    this.list = const <KeyManagementMasterModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.message,
    this.locations,
    this.commonFilters,
  });

  KeyManagementMasterListState copyWith({
    List<KeyManagementMasterModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    String? message,
    Locations? locations,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    // GmUiLabels? labels,
  }) {
    return KeyManagementMasterListState(
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
