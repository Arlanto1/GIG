part of 'visiting_officials_list_bloc.dart';

class VisitingOfficialListState extends Equatable {
  final List<LawVisitingOfficial>? items;
  final bool hasReachedMax;
  final FormStatus status;
  final List<Organisation> departments;
  final String? message;
  final LeoUiLabels? labels;

  const VisitingOfficialListState({
    this.message,
    this.items = const <LawVisitingOfficial>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    required this.departments,
    this.labels
  });

  VisitingOfficialListState copyWith({
    List<LawVisitingOfficial>? items,
    bool? hasReachedMax,
    FormStatus? status,
    List<Organisation>? departments,
    String? message,
    LeoUiLabels? labels,
  }) {
    return VisitingOfficialListState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      departments: departments ?? this.departments,
      message: message ?? this.message,
      labels: labels ?? this.labels,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
