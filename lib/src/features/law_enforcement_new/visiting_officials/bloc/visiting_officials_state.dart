part of 'visiting_officials_bloc.dart';

class VisitingOfficialsState extends Equatable {
  final List<VisitingOfficialsModel>? items;
  final bool hasReachedMax;
  final FormStatus status;
  final String? message;
  final VVIPUiLabels? labels;

  const VisitingOfficialsState({
    this.message,
    this.items = const <VisitingOfficialsModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.labels,
  });

  VisitingOfficialsState copyWith({
    List<VisitingOfficialsModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    String? message,
    VVIPUiLabels? labels,
  }) {
    return VisitingOfficialsState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      labels: labels ?? this.labels,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
