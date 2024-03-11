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

  const FetchData({required this.startPos, required this.maxPos,required this.newSearch, required this.filters});
}

class InitializeValuesAF extends ArticleFoundStateEvent {
  const InitializeValuesAF();
}

class RefreshList extends ArticleFoundStateEvent {
  const RefreshList();
}
