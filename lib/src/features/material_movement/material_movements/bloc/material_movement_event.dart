part of 'material_movement_bloc.dart';

abstract class MaterialMovementEvent extends Equatable {
  const MaterialMovementEvent();
  @override
  List<Object?> get props => [];
}

class InwardFetch extends MaterialMovementEvent{

  final int startPos;
  final int maxPos;

  const InwardFetch({required this.startPos, required this.maxPos});
}

