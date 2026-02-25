part of 'material_movement_bloc.dart';

abstract class MaterialMovementEvent extends Equatable {
  const MaterialMovementEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends MaterialMovementEvent {
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

class InitializeValuesMM extends MaterialMovementEvent {
  const InitializeValuesMM();
}

class RefreshList extends MaterialMovementEvent {
  const RefreshList();
}


class FetchApprovalById extends MaterialMovementEvent {
  final int apStepId;
  // final String objectId;

  const FetchApprovalById({required this.apStepId,});

  @override
  List<Object?> get props => [apStepId];
}


class SaveRecord extends MaterialMovementEvent {
  final ApprovalModel model;
  // final int apStepId;

  const SaveRecord({
    required this.model,
    // required this.apStepId,
  });
}