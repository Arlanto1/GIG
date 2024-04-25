part of 'article_found_bloc.dart';

class ArticleFoundState extends Equatable {
  final List<FoundModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final Locations? locations;
  final CommonFilters? commonFilters;
  final User? loggedInUser;
  final String? message;
  final AFUiLabels? labels;
  final ExtraProperties? extraProperties;

  const ArticleFoundState({
    this.items = const <FoundModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.message,
    this.locations,
    this.commonFilters,
    this.loggedInUser,
    this.labels,
    this.extraProperties,
  });

  ArticleFoundState copyWith({
    List<FoundModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    String? message,
    Locations? locations,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    User? loggedInUser,
    AFUiLabels? labels,
    ExtraProperties? extraProperties,
  }) {
    return ArticleFoundState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      commonFilters: commonFilters ?? this.commonFilters,
      locations: locations ?? this.locations,
      loggedInUser: loggedInUser ?? this.loggedInUser,
      labels: labels ?? this.labels,
      extraProperties: extraProperties ?? this.extraProperties,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
