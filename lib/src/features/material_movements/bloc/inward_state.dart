part of 'inward_bloc.dart';

@immutable
 class InwardState extends Equatable {

  final List<LawEnforcementListElement> items;
  final bool hasReachedMax;
  final LawEnforcementListStateType status;

  const InwardState(
      {this.items = const <LawEnforcementListElement>[],
        this.hasReachedMax = false,
        this.status = LawEnforcementListStateType.initial});


  InwardState copyWith({
    List<LawEnforcementListElement>? items,
    bool? hasReachedMax,
    LawEnforcementListStateType? status,
  }) {
    return InwardState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
