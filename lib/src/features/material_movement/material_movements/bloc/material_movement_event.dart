part of 'material_movement_bloc.dart';

abstract class MaterialMovementEvent extends Equatable {
  const MaterialMovementEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends MaterialMovementEvent {
  final int startPos;
  final int maxPos;

  const FetchData({required this.startPos, required this.maxPos});
}

class InitializeValuesMM extends MaterialMovementEvent {
  const InitializeValuesMM();
}
