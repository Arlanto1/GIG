part of 'occurrences_bloc.dart';

class OccurrencesState extends Equatable {
  final List<Occurrence> list;
  final bool hasReachedMax;
  final FormStatus status;

  const OccurrencesState(
      {this.list = const <Occurrence>[],
      this.hasReachedMax = false,
      this.status = FormStatus.initial});

  OccurrencesState copyWith({
    List<Occurrence>? items,
    bool? hasReachedMax,
    FormStatus? status,
  }) {
    return OccurrencesState(
      list: items ?? list,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [list, hasReachedMax, status];
}
