part of 'transport_medical_list_bloc.dart';

class TransportMedicalState extends Equatable {
  final List<TransportMedicalModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final Locations? locations;
  final CommonFilters? commonFilters;
  final String? message;
  final EPUiLabels? labels;
  final ExtraProperties? extraProperties;
  final DisplayMenu? displayMenu;


  const TransportMedicalState({
    this.items = const <TransportMedicalModel>[],
    this.hasReachedMax = false,
    this.locations,
    this.commonFilters,
    this.message,
    this.labels,
    this.status = FormStatus.initial,
    this.extraProperties,
    this.displayMenu
  });

  TransportMedicalState copyWith({
    List<TransportMedicalModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    Locations? locations,
    String? message,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    EPUiLabels? labels,
    ExtraProperties? extraProperties,
  }) {
    return TransportMedicalState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      commonFilters: commonFilters ?? this.commonFilters,
      locations: locations ?? this.locations,
      labels: labels ?? this.labels,
      extraProperties: extraProperties ?? this.extraProperties,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
