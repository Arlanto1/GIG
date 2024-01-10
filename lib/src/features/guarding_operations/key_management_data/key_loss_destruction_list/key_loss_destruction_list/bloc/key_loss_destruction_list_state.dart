part of 'key_loss_destruction_list_bloc.dart';


class KeyLossDestructionListState extends Equatable {
  final List<KeyLossDestructionListModel> list;
  final bool hasReachedMax;
  final FormStatus status;
  //final GmUiLabels? labels;

  const KeyLossDestructionListState(
      {this.list = const <KeyLossDestructionListModel>[],
        this.hasReachedMax = false,
        this.status = FormStatus.initial,
        //this.labels
      });

  KeyLossDestructionListState copyWith({
    List<KeyLossDestructionListModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    // GmUiLabels? labels,
  }) {
    return KeyLossDestructionListState(
      list: items ?? list,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      // labels: labels ?? this.labels
    );
  }

  @override
  List<Object?> get props => [list, hasReachedMax, status];
}
