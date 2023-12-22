part of 'key_management_master_list_bloc.dart';

abstract class KeyManagementMasterListEvent extends Equatable {
  const KeyManagementMasterListEvent();

  @override
  List<Object?> get props => [];
}

class FetchKeyMasterList extends KeyManagementMasterListEvent {
  final int startPos;
  final int maxPos;

  const FetchKeyMasterList({required this.startPos, required this.maxPos});
}
class InitializeValues extends KeyManagementMasterListEvent {
  const InitializeValues();
 }