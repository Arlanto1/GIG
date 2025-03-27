
part of 'article_found_list_bloc.dart';

abstract class ArticleFoundEvent extends Equatable{
  const ArticleFoundEvent();

  @override
  List<Object?> get props => [];
}

class FetchArticleData extends ArticleFoundEvent {
  final int maxResults;
  final int startPos;
  final bool newSearch;
  final BaseFilterModel filters;
  const FetchArticleData(
      this.maxResults,
      this.startPos,
      this.newSearch,
      this.filters);
}

class InitializeValuesAF extends ArticleFoundEvent{
  const InitializeValuesAF();
}

class RefreshList extends ArticleFoundEvent{
  const RefreshList();
}
