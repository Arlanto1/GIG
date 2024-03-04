part of 'key_management_issuance_list_bloc.dart';

abstract class KeyManagementIssuanceListEvent extends Equatable {
  const KeyManagementIssuanceListEvent();

  @override
  List<Object?> get props => [];
}

class FetchKeyIssuanceList extends KeyManagementIssuanceListEvent {
  final int startPos;
  final int maxPos; final bool newSearch;
  final BaseFilterModel filters;

  const FetchKeyIssuanceList(
      {required this.startPos, required this.maxPos,
        required this.newSearch,
        required this.filters});
}

class InitializeValues extends KeyManagementIssuanceListEvent {
  const InitializeValues();
}
class RefreshList extends KeyManagementIssuanceListEvent {
  const RefreshList();
}
