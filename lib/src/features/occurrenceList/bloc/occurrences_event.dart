part of 'occurrences_bloc.dart';

abstract class OccurrencesEvent extends Equatable {
  const OccurrencesEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends OccurrencesEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchData({required this.startPos, required this.maxPos,required this.newSearch, required this.filters});
}

class InitializeValues extends OccurrencesEvent {
  const InitializeValues();
}

class RefreshList extends OccurrencesEvent {
  const RefreshList();
}
