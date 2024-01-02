part of 'duty_post_master_list_bloc.dart';

abstract class DutyPostMasterListEvent extends Equatable {
  const DutyPostMasterListEvent();

  @override
  List<Object?> get props => [];
}

class FetchDutyPostMasterList extends DutyPostMasterListEvent {
  final int startPos;
  final int maxPos;

  const FetchDutyPostMasterList({required this.startPos, required this.maxPos});
}
class InitializeValues extends DutyPostMasterListEvent {
  const InitializeValues();
}