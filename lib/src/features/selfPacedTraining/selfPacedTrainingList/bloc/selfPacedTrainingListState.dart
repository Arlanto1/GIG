
part of 'selfPacedTrainingListBloc.dart';

class SelfPacedTrainingListState extends Equatable{
  final List<SelfPacedTrainingModel> items;
  final Locations? location;
  final ExtraProperties? extraProperties;
  final FormStatus? status;
  final String? message;
  final bool hasReachedMax;
  final AFUiLabels? labels;
  final CommonFilters? commonFilters;
  final DisplayMenu? displayMenu;


  const SelfPacedTrainingListState({required this.items,
    this.location,
    this.extraProperties,
    this.status,
    this.message,
    this.hasReachedMax = false,
    this.labels,
    this.commonFilters,
    this.displayMenu,

  });

  SelfPacedTrainingListState copyWith({
    List<SelfPacedTrainingModel>? items,
    Locations? location,
    ExtraProperties? extraProperties,
    FormStatus? status,
    String? message,
    bool? hasReachedMax,
    AFUiLabels? labels,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
  }) {
    return SelfPacedTrainingListState(
      items: items ?? this.items,
      location:location?? this.location,
      extraProperties: extraProperties?? this.extraProperties,
      status: status??this.status,
      message: message?? this.message,
      hasReachedMax: hasReachedMax?? this.hasReachedMax,
      labels:labels??this.labels,
      commonFilters: commonFilters?? this.commonFilters,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}