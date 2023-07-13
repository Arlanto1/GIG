// To parse this JSON data, do
//
//     final getArticleType = getArticleTypeFromJson(jsonString);

import 'dart:convert';

GetArticleType getArticleTypeFromJson(String str) => GetArticleType.fromJson(json.decode(str));

String getArticleTypeToJson(GetArticleType data) => json.encode(data.toJson());

class GetArticleType {
  List<ArticleList>? articleList;

  GetArticleType({
    this.articleList,
  });

  factory GetArticleType.fromJson(Map<String, dynamic> json) => GetArticleType(
        articleList: json["ARTICLE_LIST"] == null
            ? []
            : List<ArticleList>.from(json["ARTICLE_LIST"]!.map((x) => ArticleList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ARTICLE_LIST":
            articleList == null ? [] : List<dynamic>.from(articleList!.map((x) => x.toJson())),
      };
}

class ArticleList {
  int? id;
  String? name;

  ArticleList({
    this.id,
    this.name,
  });

  factory ArticleList.fromJson(Map<String, dynamic> json) => ArticleList(
        id: json["Id"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
}
