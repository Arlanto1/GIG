part of 'pass_management_list_bloc.dart';

abstract class PassManagementListEvent extends Equatable {
  const PassManagementListEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends PassManagementListEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchData({required this.startPos, required this.maxPos,required this.newSearch, required this.filters});
}

class InitializeValuesMM extends PassManagementListEvent {
  const InitializeValuesMM();
}

class RefreshList extends PassManagementListEvent {
  const RefreshList();
}
