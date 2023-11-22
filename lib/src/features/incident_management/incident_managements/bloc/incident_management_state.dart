part of 'incident_management_bloc.dart';

class IncidentManagementsState extends Equatable {
  final List<IncidentModel> items;
  final bool hasReachedMax;
  final FormStatus status;

  const IncidentManagementsState(
      {this.items = const <IncidentModel>[],
        this.hasReachedMax = false,
        this.status = FormStatus.initial});

  IncidentManagementsState copyWith({
    List<IncidentModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
  }) {
    return IncidentManagementsState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
