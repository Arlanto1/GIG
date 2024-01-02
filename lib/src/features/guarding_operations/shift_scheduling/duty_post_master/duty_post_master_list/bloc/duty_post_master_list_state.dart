part of 'duty_post_master_list_bloc.dart';


class DutyPostMasterListState extends Equatable {
  final List<DutyPostMasterModel> list;
  final bool hasReachedMax;
  final FormStatus status;
  //final GmUiLabels? labels;

  const DutyPostMasterListState(
      {this.list = const <DutyPostMasterModel>[],
        this.hasReachedMax = false,
        this.status = FormStatus.initial,
        //this.labels
      });

  DutyPostMasterListState copyWith({
    List<DutyPostMasterModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    // GmUiLabels? labels,
  }) {
    return DutyPostMasterListState(
      list: items ?? list,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      // labels: labels ?? this.labels
    );
  }

  @override
  List<Object?> get props => [list, hasReachedMax, status];
}
