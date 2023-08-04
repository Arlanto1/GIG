part of 'inward_bloc.dart';

abstract class InwardEvent extends Equatable {
  const InwardEvent();
  @override
  List<Object?> get props => [];
}

class InwardFetch extends InwardEvent{

  final int startPos;
  final int maxPos;

  const InwardFetch({required this.startPos, required this.maxPos});
}

