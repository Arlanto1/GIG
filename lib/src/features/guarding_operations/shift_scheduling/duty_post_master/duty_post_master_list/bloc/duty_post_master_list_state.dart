part of 'duty_post_master_list_bloc.dart';

class DutyPostMasterListState extends Equatable {
  final List<DutyPostMasterModel> list;
  final bool hasReachedMax;
  final FormStatus status;
  final SSUiLabels? labels;
  final String? message;
  final CommonFilters? commonFilters;
  final Locations? locations;

  const DutyPostMasterListState({
    this.list = const <DutyPostMasterModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.labels,
    this.message,
    this.locations,
    this.commonFilters,
  });

  DutyPostMasterListState copyWith({
    List<DutyPostMasterModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    SSUiLabels? labels,
    String? message,
    Locations? locations,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
  }) {
    return DutyPostMasterListState(
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
