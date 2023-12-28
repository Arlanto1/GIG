part of 'duty_post_name_master_list_bloc.dart';

class DutyPostNameMasterListState extends Equatable {
  final List<DutyPostNameMasterModel> list;
  final bool hasReachedMax;
  final FormStatus status;

  //final GmUiLabels? labels;

  const DutyPostNameMasterListState({
    this.list = const <DutyPostNameMasterModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    //this.labels
  });

  DutyPostNameMasterListState copyWith({
    List<DutyPostNameMasterModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    // GmUiLabels? labels,
  }) {
    return DutyPostNameMasterListState(
      list: items ?? list,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      // labels: labels ?? this.labels
    );
  }

  @override
  List<Object?> get props => [list, hasReachedMax, status];
}
