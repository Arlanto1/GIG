part of 'key_management_issuance_list_bloc.dart';

abstract class KeyManagementIssuanceListEvent extends Equatable {
  const KeyManagementIssuanceListEvent();

  @override
  List<Object?> get props => [];
}

class FetchKeyIssuanceList extends KeyManagementIssuanceListEvent {
  final int startPos;
  final int maxPos;

  const FetchKeyIssuanceList(
      {required this.startPos, required this.maxPos});
}

class InitializeValues extends KeyManagementIssuanceListEvent {
  const InitializeValues();
}
