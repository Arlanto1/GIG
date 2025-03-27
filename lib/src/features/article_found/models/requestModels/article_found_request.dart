import 'package:db_atom/src/features/article_found/models/article_found_model.dart';

class ArticleFoundRequest {
  ArticleFoundRequest({
    required this.articleFoundModel,
  });

  late final ArticleFoundModel articleFoundModel;

  ArticleFoundRequest.fromJson(Map<String, dynamic> json) {
    articleFoundModel = ArticleFoundModel.fromJson(json['found']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['found'] = articleFoundModel.toJson();
    return data;
  }
}
