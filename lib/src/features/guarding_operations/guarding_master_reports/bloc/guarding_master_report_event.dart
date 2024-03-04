part of 'guarding_master_report_bloc.dart';

abstract class GuardingMasterReportEvent extends Equatable {
  const GuardingMasterReportEvent();

  @override
  List<Object?> get props => [];
}

class FetchReportList extends GuardingMasterReportEvent {
  final int startPos;
  final int maxPos;

  const FetchReportList({required this.startPos, required this.maxPos});
}
class RefreshListGMR extends GuardingMasterReportEvent {
  const RefreshListGMR();
}
