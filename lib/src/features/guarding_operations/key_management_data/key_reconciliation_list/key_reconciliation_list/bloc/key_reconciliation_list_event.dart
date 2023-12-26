part of 'key_reconciliation_list_bloc.dart';

abstract class KeyReconciliationListEvent extends Equatable {
  const KeyReconciliationListEvent();

  @override
  List<Object?> get props => [];
}

class FetchKeyReconciliationList extends KeyReconciliationListEvent {
  final int startPos;
  final int maxPos;

  const FetchKeyReconciliationList(
      {required this.startPos, required this.maxPos});
}

class InitializeValues extends KeyReconciliationListEvent {
  const InitializeValues();
}
