part of 'duty_post_name_master_list_bloc.dart';

class DutyPostNameMasterListState extends Equatable {
  final List<DutyPostNameMasterModel> list;
  final bool hasReachedMax;
  final FormStatus status;
  final String? message;
  final CommonFilters? commonFilters;
  final Locations? locations;
  final DPNUiLabels? labels;
  final ExtraProperties? extraProperties;

  const DutyPostNameMasterListState({
    this.list = const <DutyPostNameMasterModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.labels,
    this.message,
    this.locations,
    this.commonFilters,
    this.extraProperties,
  });

  DutyPostNameMasterListState copyWith({
    List<DutyPostNameMasterModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    DPNUiLabels? labels,
    String? message,
    Locations? locations,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    ExtraProperties? extraProperties,
  }) {
    return DutyPostNameMasterListState(
      list: items ?? list,
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
  List<Object?> get props => [list, hasReachedMax, status];
}
