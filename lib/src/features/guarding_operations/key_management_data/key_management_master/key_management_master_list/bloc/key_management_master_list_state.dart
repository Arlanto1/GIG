part of 'key_management_master_list_bloc.dart';


class KeyManagementMasterListState extends Equatable {
  final List<KeyManagementMasterModel> list;
  final bool hasReachedMax;
  final FormStatus status;
  //final GmUiLabels? labels;

  const KeyManagementMasterListState(
      {this.list = const <KeyManagementMasterModel>[],
        this.hasReachedMax = false,
        this.status = FormStatus.initial,
        //this.labels
      });

  KeyManagementMasterListState copyWith({
    List<KeyManagementMasterModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
   // GmUiLabels? labels,
  }) {
    return KeyManagementMasterListState(
        list: items ?? list,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status,
       // labels: labels ?? this.labels
    );
  }

  @override
  List<Object?> get props => [list, hasReachedMax, status];
}
