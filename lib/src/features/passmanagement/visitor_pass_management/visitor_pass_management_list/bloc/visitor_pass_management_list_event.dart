
part of 'visitor_pass_management_list_bloc.dart';

abstract class VisitorPassManagementListEvent extends Equatable {
  const VisitorPassManagementListEvent();

  @override
  List<Object?> get props => [];
}

class FetchVisitorPassData extends VisitorPassManagementListEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchVisitorPassData(
      {required this.startPos,
        required this.maxPos,
        required this.newSearch,
        required this.filters});
}

class InitializeVisitorPassValues extends VisitorPassManagementListEvent {
  const InitializeVisitorPassValues();
}

class RefreshVisitorPassList extends VisitorPassManagementListEvent {
  const RefreshVisitorPassList();
}
