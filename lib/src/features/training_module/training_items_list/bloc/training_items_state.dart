
part of 'training_items_bloc.dart';

class TrainingItemsState extends Equatable{
  final List<TrainingItemsModel> items;
  final Locations? location;
  final ExtraProperties? extraProperties;
  final FormStatus? status;
  final String? message;
  final bool hasReachedMax;
  final AFUiLabels? labels;
  final CommonFilters? commonFilters;
  final DisplayMenu? displayMenu;


  const TrainingItemsState({required this.items,
    this.location,
    this.extraProperties,
    this.status,
    this.message,
    this.hasReachedMax = false,
    this.labels,
    this.commonFilters,
    this.displayMenu,

  });

  TrainingItemsState copyWith({
    List<TrainingItemsModel>? items,
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
    return TrainingItemsState(
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