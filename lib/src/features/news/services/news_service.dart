import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/news/model/news_model.dart';

class NewsService {
  static const String apiKey = "72686dd13bba450684050a85538532e1";
  static const String news1 =
      "https://api.qa.dbatom.arlanto.com/api/atomrestservice/getLatestNews";

  Future<NewApp> fetchNews({
    required String location,
    required String category,
  }) async {
    final String url = category == "general"
        ?  "$news1?state=$location&category=general"
        : "$news1?state=$location&category=$category";
    final response = await BaseApiService().getRequest(
      url: url,
      isAuthenticated: true,
    );

    return NewApp.fromJson(response);
  }
}

