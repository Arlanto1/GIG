part of 'guarding_master_report_bloc.dart';

class GuardingMasterReportState extends Equatable {
  final List<GuardingMasterReportsModel> list;
  final bool hasReachedMax;
  final FormStatus status;
  final CommonFilters? commonFilters;
  final Locations? locations;
  final String? message;

  const GuardingMasterReportState(
      {this.list = const <GuardingMasterReportsModel>[],
      this.hasReachedMax = false,
      this.status = FormStatus.initial,
        this.message,
        this.locations,
        this.commonFilters,});

  GuardingMasterReportState copyWith({
    List<GuardingMasterReportsModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    String? message,
    Locations? locations,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,

  }) {
    return GuardingMasterReportState(
      list: items ?? list,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      commonFilters: commonFilters ?? this.commonFilters,
      locations: locations ?? this.locations,
    );
  }

  @override
  List<Object?> get props => [list, hasReachedMax, status];
}
