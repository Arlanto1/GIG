part of 'inward_bloc.dart';

@immutable
 class InwardState extends Equatable {

  final List<LawEnforcementListElement> lawEnforceItems;
  final bool hasReachedMax;
  final LawEnforcementListStateType status;

  const InwardState(
      {this.lawEnforceItems = const <LawEnforcementListElement>[],
        this.hasReachedMax = false,
        this.status = LawEnforcementListStateType.initial});


  InwardState copyWith({
    List<LawEnforcementListElement>? todos,
    bool? hasReachedMax,
    LawEnforcementListStateType? status,
  }) {
    return InwardState(
      lawEnforceItems: todos ?? this.lawEnforceItems,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [lawEnforceItems, hasReachedMax, status];
}
