
part of 'sez_pass_management_list_bloc.dart';

abstract class SezPassManagementListEvent extends Equatable {
  const SezPassManagementListEvent();

  @override
  List<Object?> get props => [];
}

class FetchSezPassData extends SezPassManagementListEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchSezPassData(
      {required this.startPos,
        required this.maxPos,
        required this.newSearch,
        required this.filters});
}

class InitializeSezPassValues extends SezPassManagementListEvent {
  const InitializeSezPassValues();
}

class RefreshSezPassList extends SezPassManagementListEvent {
  const RefreshSezPassList();
}
