part of 'female_drop_pick_up_bloc.dart';

abstract class FemaleDropPickUpEvent extends Equatable {
  const FemaleDropPickUpEvent();

  @override
  List<Object?> get props => [];
}

class FetchList extends FemaleDropPickUpEvent {
  final int startPos;
  final int maxPos;

  const FetchList({required this.startPos, required this.maxPos});
}
