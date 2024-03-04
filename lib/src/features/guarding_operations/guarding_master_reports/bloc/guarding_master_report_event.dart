part of 'guarding_master_report_bloc.dart';

abstract class GuardingMasterReportEvent extends Equatable {
  const GuardingMasterReportEvent();

  @override
  List<Object?> get props => [];
}

class FetchReportList extends GuardingMasterReportEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchReportList(
      {required this.startPos,
      required this.maxPos,
      required this.newSearch,
      required this.filters});
}

class InitializeValuesGMR extends GuardingMasterReportEvent {
  const InitializeValuesGMR();
}

class RefreshListGMR extends GuardingMasterReportEvent {
  const RefreshListGMR();
}
