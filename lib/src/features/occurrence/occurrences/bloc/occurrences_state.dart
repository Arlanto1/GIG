part of 'occurrences_bloc.dart';

class OccurrencesState extends Equatable {
  final List<Occurrence> items;
  final bool hasReachedMax;
  final FormStatus status;

  const OccurrencesState(
      {this.items = const <Occurrence>[],
        this.hasReachedMax = false,
        this.status = FormStatus.initial});

  OccurrencesState copyWith({
    List<Occurrence>? items,
    bool? hasReachedMax,
    FormStatus? status,
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
