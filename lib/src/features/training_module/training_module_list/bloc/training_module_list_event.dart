
part of 'training_module_list_bloc.dart';

abstract class TrainingModuleListEvent extends Equatable{
  const TrainingModuleListEvent();

  @override
  List<Object?> get props => [];
}

class FetchTrainingData extends TrainingModuleListEvent {
  final int startPos;
  final int maxPos;
  final BaseFilterModel filters;

  const FetchTrainingData(
      {required this.startPos,
        required this.maxPos,
        required this.filters});
}

class InitializeValuesTraining extends TrainingModuleListEvent{
  const InitializeValuesTraining();
}

class RefreshTrainingList extends TrainingModuleListEvent{
  const RefreshTrainingList();
}
