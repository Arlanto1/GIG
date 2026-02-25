part of 'csr_event_list_bloc.dart';

abstract class CSREventEvent extends Equatable {
  const CSREventEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends CSREventEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchData(
      {required this.startPos,
        required this.maxPos,
        required this.newSearch,
        required this.filters});
}

class InitializeValuesEP extends CSREventEvent {
  const InitializeValuesEP();
}

class RefreshList extends CSREventEvent {
  const RefreshList();
}
