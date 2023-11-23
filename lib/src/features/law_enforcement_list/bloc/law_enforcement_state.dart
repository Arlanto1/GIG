part of 'law_enforcement_bloc.dart';

class LawEnforcementState extends Equatable {
  final List<LawEnforcementListElement> items;
  final bool hasReachedMax;
  final FormStatus status;

  const LawEnforcementState(
      {this.items = const <LawEnforcementListElement>[],
      this.hasReachedMax = false,
      this.status = FormStatus.initial});

  LawEnforcementState copyWith({
    List<LawEnforcementListElement>? todos,
    bool? hasReachedMax,
    FormStatus? status,
  }) {
    return LawEnforcementState(
      items: todos ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
