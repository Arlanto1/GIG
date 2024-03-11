part of 'key_management_master_list_bloc.dart';

abstract class KeyManagementMasterListEvent extends Equatable {
  const KeyManagementMasterListEvent();

  @override
  List<Object?> get props => [];
}

class FetchKeyMasterList extends KeyManagementMasterListEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchKeyMasterList({required this.startPos, required this.maxPos,
    required this.newSearch,
    required this.filters});
}

class InitializeValues extends KeyManagementMasterListEvent {
  const InitializeValues();
}

class RefreshList extends KeyManagementMasterListEvent {
  const RefreshList();
}
