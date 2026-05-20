
part of 'training_items_bloc.dart';

abstract class TrainingItemsEvent extends Equatable{
  const TrainingItemsEvent();

  @override
  List<Object?> get props => [];
}

class FetchTrainingItemsData extends TrainingItemsEvent {
  final String id;
  final int startPos;
  final int maxPos;
  // final BaseFilterModel filters;

  const FetchTrainingItemsData(
      {required this.id,
        required this.startPos,
        required this.maxPos,
        // required this.filters
      });
}

class InitializeValuesTrainingItems extends TrainingItemsEvent{
  final String id;
  const InitializeValuesTrainingItems({required this.id});
}

class RefreshTrainingItemsList extends TrainingItemsEvent{  final String id;
  const RefreshTrainingItemsList({required this.id});
}
