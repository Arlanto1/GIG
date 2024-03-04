part of 'key_loss_destruction_list_bloc.dart';

abstract class KeyLossDestructionListEvent extends Equatable {
  const KeyLossDestructionListEvent();

  @override
  List<Object?> get props => [];
}

class FetchKeyLossList extends KeyLossDestructionListEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchKeyLossList(
      {required this.startPos,
      required this.maxPos,
      required this.newSearch,
      required this.filters});
}

class InitializeValues extends KeyLossDestructionListEvent {
  const InitializeValues();
}

class RefreshList extends KeyLossDestructionListEvent {
  const RefreshList();
}
