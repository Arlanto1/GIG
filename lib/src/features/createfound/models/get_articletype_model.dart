import 'dart:convert';

import '../../../models/organisation.dart';

GetArticleType getArticleTypeFromJson(String str) => GetArticleType.fromJson(json.decode(str));

String getArticleTypeToJson(GetArticleType data) => json.encode(data.toJson());

class GetArticleType {
  List<Organisation>? articleList;

  GetArticleType({
    this.articleList,
  });

  factory GetArticleType.fromJson(Map<String, dynamic> json) => GetArticleType(
        articleList: json["ARTICLE_LIST"] == null
            ? []
            : List<Organisation>.from(json["ARTICLE_LIST"]!.map((x) => Organisation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ARTICLE_LIST":
            articleList == null ? [] : List<dynamic>.from(articleList!.map((x) => x.toJson())),
      };
}

