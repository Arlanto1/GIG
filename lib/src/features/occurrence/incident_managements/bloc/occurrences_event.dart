part of 'occurrences_bloc.dart';


abstract class OccurrencesEvent extends Equatable {
  const OccurrencesEvent();
  @override
  List<Object?> get props => [];
}

class InwardFetch extends OccurrencesEvent{

  final int startPos;
  final int maxPos;

  const InwardFetch({required this.startPos, required this.maxPos});
}
