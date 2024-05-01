part of 'duty_post_name_master_list_bloc.dart';

abstract class DutyPostNameMasterListEvent extends Equatable {
  const DutyPostNameMasterListEvent();

  @override
  List<Object?> get props => [];
}

class FetchDutyPostNameMasterList extends DutyPostNameMasterListEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchDutyPostNameMasterList(
      {required this.startPos,
      required this.maxPos,
      required this.newSearch,
      required this.filters});
}

class InitializeValue extends DutyPostNameMasterListEvent {
  const InitializeValue();
}

class RefreshDPNList extends DutyPostNameMasterListEvent {
  const RefreshDPNList();
}
