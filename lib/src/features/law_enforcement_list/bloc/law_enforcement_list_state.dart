part of 'law_enforcement_list_bloc.dart';

class LawEnforcementListState extends Equatable {
  final List<LawEnforcementListElement> items;
  final bool hasReachedMax;
  final FormStatus status;

  const LawEnforcementListState(
      {this.items = const <LawEnforcementListElement>[],
      this.hasReachedMax = false,
      this.status = FormStatus.initial});

  LawEnforcementListState copyWith({
    List<LawEnforcementListElement>? todos,
    bool? hasReachedMax,
    FormStatus? status,
  }) {
    return LawEnforcementListState(
      items: todos ?? items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
