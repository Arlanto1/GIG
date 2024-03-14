part of 'duty_post_master_list_bloc.dart';

abstract class DutyPostMasterListEvent extends Equatable {
  const DutyPostMasterListEvent();

  @override
  List<Object?> get props => [];
}

class FetchDutyPostMasterList extends DutyPostMasterListEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchDutyPostMasterList({required this.startPos, required this.maxPos,   required this.newSearch,
    required this.filters});
}
class InitializeValues extends DutyPostMasterListEvent {
  const InitializeValues();
}

class RefreshList extends DutyPostMasterListEvent {
  const RefreshList();
}
