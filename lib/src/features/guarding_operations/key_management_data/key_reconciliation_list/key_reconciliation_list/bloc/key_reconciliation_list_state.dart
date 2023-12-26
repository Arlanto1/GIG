part of 'key_reconciliation_list_bloc.dart';

class KeyReconciliationListState extends Equatable {
  final List<KeyReconciliationListModel> list;
  final bool hasReachedMax;
  final FormStatus status;

  //final GmUiLabels? labels;

  const KeyReconciliationListState({
    this.list = const <KeyReconciliationListModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    //this.labels
  });

  KeyReconciliationListState copyWith({
    List<KeyReconciliationListModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    // GmUiLabels? labels,
  }) {
    return KeyReconciliationListState(
      list: items ?? list,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      // labels: labels ?? this.labels
    );
  }

  @override
  List<Object?> get props => [list, hasReachedMax, status];
}
