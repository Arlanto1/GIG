part of 'article_found_bloc.dart';

abstract class ArticleFoundStateEvent extends Equatable {
  const ArticleFoundStateEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends ArticleFoundStateEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;
  final int? eventId;

  const FetchData({
    required this.startPos,
    required this.maxPos,
    required this.newSearch,
    required this.filters,
    this.eventId,
  });
}

class InitializeValuesAF extends ArticleFoundStateEvent {
  const InitializeValuesAF();
}

class RefreshList extends ArticleFoundStateEvent {
  final int? eventId;

  const RefreshList({this.eventId});
}
