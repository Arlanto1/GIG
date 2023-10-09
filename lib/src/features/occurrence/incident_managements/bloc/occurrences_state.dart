part of 'occurrences_bloc.dart';

class OccurrencesState extends Equatable {
  final List<Incident> items;
  final bool hasReachedMax;
  final LawEnforcementListStateType status;

  const OccurrencesState(
      {this.items = const <Incident>[],
        this.hasReachedMax = false,
        this.status = LawEnforcementListStateType.initial});

  OccurrencesState copyWith({
    List<Incident>? items,
    bool? hasReachedMax,
    LawEnforcementListStateType? status,
  }) {
    return OccurrencesState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
