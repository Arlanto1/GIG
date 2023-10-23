part of 'law_enforcement_bloc.dart';

class LawEnforcementState extends Equatable {
  final List<LawEnforcementListElement> lawEnforceItems;
  final bool hasReachedMax;
  final FormStatus status;

  const LawEnforcementState(
      {this.lawEnforceItems = const <LawEnforcementListElement>[],
      this.hasReachedMax = false,
      this.status = FormStatus.initial});

  LawEnforcementState copyWith({
    List<LawEnforcementListElement>? todos,
    bool? hasReachedMax,
    FormStatus? status,
  }) {
    return LawEnforcementState(
      lawEnforceItems: todos ?? this.lawEnforceItems,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [lawEnforceItems, hasReachedMax, status];
}
