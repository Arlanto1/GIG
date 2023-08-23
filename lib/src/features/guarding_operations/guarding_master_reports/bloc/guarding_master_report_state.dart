part of 'guarding_master_report_bloc.dart';

class GuardingMasterReportState extends Equatable {
  final List<GuardingMasterReportsModel> list;
  final bool hasReachedMax;
  final LawEnforcementListStateType status;

  const GuardingMasterReportState(
      {this.list = const <GuardingMasterReportsModel>[],
      this.hasReachedMax = false,
      this.status = LawEnforcementListStateType.initial});

  GuardingMasterReportState copyWith({
    List<GuardingMasterReportsModel>? items,
    bool? hasReachedMax,
    LawEnforcementListStateType? status,
  }) {
    return GuardingMasterReportState(
      list: items ?? list,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [list, hasReachedMax, status];
}
