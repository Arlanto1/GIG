
part of 'article_found_list_bloc.dart';

abstract class ArticleFoundEvent extends Equatable{
  const ArticleFoundEvent();

  @override
  List<Object?> get props => [];
}

class FetchArticleData extends ArticleFoundEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchArticleData(
      {required this.startPos,
        required this.maxPos,
        required this.newSearch,
        required this.filters});
}

class InitializeValuesAF extends ArticleFoundEvent{
  const InitializeValuesAF();
}

class RefreshList extends ArticleFoundEvent{
  const RefreshList();
}
