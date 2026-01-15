class NewApp {
  final List<News>? news;
  final int? count;
  final String? status;

  NewApp({
    this.news,
    this.count,
    this.status,
  });

  NewApp.fromJson(Map<String, dynamic> json)
      : news = (json['news'] as List?)
      ?.map((dynamic e) => News.fromJson(e as Map<String, dynamic>))
      .toList(),
        count = json['count'] as int?,
        status = json['status'] as String?;

  Map<String, dynamic> toJson() => {
    'news': news?.map((e) => e.toJson()).toList(),
    'count': count,
    'status': status
  };
}

class News {
  final String? publishedAt;
  final String? imageUrl;
  final int? id;
  final String? sourceName;
  final String? title;
  final String? url;
  final String? category;

  News({
    this.publishedAt,
    this.imageUrl,
    this.id,
    this.sourceName,
    this.title,
    this.url,
    this.category,
  });

  News.fromJson(Map<String, dynamic> json)
      : publishedAt = json['publishedAt'] as String?,
        imageUrl = json['imageUrl'] as String?,
        id = json['id'] as int?,
        sourceName = json['sourceName'] as String?,
        title = json['title'] as String?,
        url = json['url'] as String?,
        category = json['category'] as String?;

  Map<String, dynamic> toJson() => {
    'publishedAt': publishedAt,
    'imageUrl': imageUrl,
    'id': id,
    'sourceName': sourceName,
    'title': title,
    'url': url,
    'category': category
  };
}
