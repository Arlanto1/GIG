
part of 'article_found_list_bloc.dart';

class ArticleFoundState extends Equatable{
  final List<ArticleFoundModel> items;
  final Locations? location;
  final ExtraProperties? extraProperties;
  final FormStatus? status;
  final String? message;
  final bool hasReachedMax;
  final AFUiLabels? labels;
  final CommonFilters? commonFilters;


  const ArticleFoundState({required this.items,
    this.location,
    this.extraProperties,
    this.status,
    this.message,
    this.hasReachedMax = false,
    this.labels,
    this.commonFilters,

  });

  ArticleFoundState copyWith({
    List<ArticleFoundModel>? items,
    Locations? location,
    ExtraProperties? extraProperties,
    FormStatus? status,
    String? message,
    bool? hasReachedMax,
    AFUiLabels? labels,
    CommonFilters? commonFilters,
  }) {
    return ArticleFoundState(
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