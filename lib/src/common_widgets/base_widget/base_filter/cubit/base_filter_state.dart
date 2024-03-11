part of 'base_filter_cubit.dart';

class BaseFilterState extends Equatable {
  final FormStatus status;

  final List<Organisation> locations;

  const BaseFilterState({
    required this.status,
    required this.locations,
  });

  BaseFilterState copyWith({
    FormStatus? status,
    List<Organisation>? locations,
  }) {
    return BaseFilterState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
    );
  }

  @override
  List<Object> get props => [status, locations];
}
