part of 'key_management_issuance_list_bloc.dart';

class KeyManagementIssuanceListState extends Equatable {
  final List<KeyManagementIssuanceModel> list;
  final bool hasReachedMax;
  final FormStatus status;

  //final GmUiLabels? labels;

  const KeyManagementIssuanceListState({
    this.list = const <KeyManagementIssuanceModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    //this.labels
  });

  KeyManagementIssuanceListState copyWith({
    List<KeyManagementIssuanceModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    // GmUiLabels? labels,
  }) {
    return KeyManagementIssuanceListState(
      list: items ?? list,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      // labels: labels ?? this.labels
    );
  }

  @override
  List<Object?> get props => [list, hasReachedMax, status];
}
