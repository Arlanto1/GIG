part of 'duty_post_name_master_list_bloc.dart';

abstract class DutyPostNameMasterListEvent extends Equatable {
  const DutyPostNameMasterListEvent();

  @override
  List<Object?> get props => [];
}

class FetchDutyPostNameMasterList extends DutyPostNameMasterListEvent {
  final int startPos;
  final int maxPos;

  const FetchDutyPostNameMasterList(
      {required this.startPos, required this.maxPos});
}

class InitializeValues extends DutyPostNameMasterListEvent {
  const InitializeValues();
}
