// part of 'key_history_record_bloc.dart';
//
// class KeyHistoryRecordState extends Equatable {
//   final List<KeyManagementMasterModel>? items;
//   final bool hasReachedMax;
//   final FormStatus status;
//   final List<Organisation> ranks;
//   final String? message;
//
//   const KeyHistoryRecordState({
//     this.message,
//     this.items = const <KeyManagementMasterModel>[],
//     this.hasReachedMax = false,
//     this.status = FormStatus.initial,
//     required this.ranks,
//   });
//
//   KeyHistoryRecordState copyWith({
//     List<KeyManagementMasterModel>? items,
//     bool? hasReachedMax,
//     FormStatus? status,
//     List<Organisation>? ranks,
//     String? message,
//   }) {
//     return KeyHistoryRecordState(
//       items: items ?? this.items,
//       hasReachedMax: hasReachedMax ?? this.hasReachedMax,
//       status: status ?? this.status,
//       ranks: ranks ?? this.ranks,
//       message: message ?? this.message,
//     );
//   }
//
//   @override
//   List<Object?> get props => [items, hasReachedMax, status];
// }
part of 'key_history_record_bloc.dart';

class KeyHistoryRecordState extends Equatable {
  final List<KeyManagementMasterModel> list;
  final bool hasReachedMax;
  final FormStatus status;
    final String? message;
  final KMUiLabels? labels;

  const KeyHistoryRecordState(
      {this.list = const <KeyManagementMasterModel>[],
        this.hasReachedMax = false,
            this.message,
        this.status = FormStatus.initial,
        this.labels
      });

  KeyHistoryRecordState copyWith({
    List<KeyManagementMasterModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
        String? message,
    KMUiLabels? labels,
  }) {
    return KeyHistoryRecordState(
      list: items ?? list,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      labels: labels ?? this.labels
    );
  }

  @override
  List<Object?> get props => [list, hasReachedMax, status];
}
