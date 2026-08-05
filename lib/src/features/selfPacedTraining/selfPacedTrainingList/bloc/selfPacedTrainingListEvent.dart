
part of 'selfPacedTrainingListBloc.dart';

abstract class SelfPacedTrainingListEvent extends Equatable{
  const SelfPacedTrainingListEvent();

  @override
  List<Object?> get props => [];
}

class FetchSelfPacedTrainingData extends SelfPacedTrainingListEvent {
  final int startPos;
  final int maxPos;
  final BaseFilterModel filters;

  const FetchSelfPacedTrainingData(
      {required this.startPos,
        required this.maxPos,
        required this.filters});
}

class InitializeValuesSelfPacedTraining extends SelfPacedTrainingListEvent{
  const InitializeValuesSelfPacedTraining();
}

class RefreshSelfPacedTrainingList extends SelfPacedTrainingListEvent{
  const RefreshSelfPacedTrainingList();
}
