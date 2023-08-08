part of 'inward_outward_bloc.dart';

abstract class InwardOutwardEvent extends Equatable {
  const InwardOutwardEvent();
  @override
  List<Object?> get props => [];
}

class InwardFetch extends InwardOutwardEvent{

  final int startPos;
  final int maxPos;

  const InwardFetch({required this.startPos, required this.maxPos});
}

