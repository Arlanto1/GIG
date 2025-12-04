// // import 'dart:convert';
// // import 'dart:developer';
// // import 'package:http/http.dart' as http;
// //
// // class NewsService {
// //   static const String apiKey = "346542cc-a65c-4f5b-9dfa-128179f19bac"; // ← put your key
// //   static const String baseUrl = "https://eventregistry.org/api/v1/article/getArticles";
// //
// //   Future<List<Map<String, dynamic>>> fetchNews(String category) async {
// //     final url = Uri.parse(
// //       "$baseUrl?apiKey=$apiKey",
// //     );
// //
// //     final response = await http.get(url);
// //     log('response ${response}');
// //     if (response.statusCode == 200) {
// //       final data = jsonDecode(response.body);
// //       log('responseBody ${response.body}');
// //       final List articles = data["articles"] ?? [];
// //
// //       return articles.map((article) {
// //         return {
// //           "title": article["title"] ?? "",
// //           "source": article["source"]?["name"] ?? "",
// //           "time": article["publishedAt"] ?? "",
// //           "image": article["urlToImage"] ??
// //               "https://via.placeholder.com/150", // Fallback image
// //           "tag": category.toUpperCase(),
// //         };
// //       }).toList();
// //     } else {
// //       throw Exception("Failed to load news");
// //     }
// //   }
// // }
//
// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
//
// class NewsService {
//   static const String apiKey = "346542cc-a65c-4f5b-9dfa-128179f19bac";
//   static const String baseUrl =
//       "https://eventregistry.org/api/v1/article/getArticles";
//
//   Future<List<Map<String, dynamic>>> fetchNews(String category) async {
//     final url = Uri.parse(
//       "$baseUrl?apiKey=$apiKey"
//           "&keyword=$category"
//           "&lang=eng"
//           "&sortBy=date" // latest news
//           "&resultType=articles"
//           "&articlesPage=1"
//           "&articlesCount=20",
//     );
//
//     log("Calling: $url");
//
//     final response = await http.get(url);
//
//     log('status: ${response.statusCode}');
//     log('responseBody ${response.body}');
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//
//       final List articles = data["articles"]?["results"] ?? [];
//
//       return articles.map((article) {
//         return {
//           "title": article["title"] ?? "",
//           "source": article["source"] ?? "",
//           "time": article["date"] ?? "",
//           "image": article["image"] ??
//               "https://via.placeholder.com/150",
//           "tag": category.toUpperCase(),
//         };
//       }).toList();
//     } else {
//       throw Exception("Failed to load news");
//     }
//   }
// }


import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class NewsService {
  static const String apiKey = "72686dd13bba450684050a85538532e1";
  static const String baseUrl = "https://newsapi.org/v2/top-headlines";

  Future<List<Map<String, dynamic>>> fetchTopHeadlines({
    String country = "US",
    required String category,
  }) async {

    final String url = category == "general"
        ? "$baseUrl?country=us&apiKey=$apiKey"
        : "$baseUrl?country=us&category=$category&apiKey=$apiKey";

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    log("STATUS: ${response.statusCode}");
    log("BODY: ${response.body}");
    log("URL: $url");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List articles = data["articles"] ?? [];

      return articles.map((article) {
        return {
          "title": article["title"] ?? "",
          "description": article["description"] ?? "",
          "source": {
            "id": article["source"]?["id"],
            "name": article["source"]?["name"],
          },
          "author": article["author"] ?? "",
          "url": article["url"] ?? "",
          "image": article["urlToImage"] ?? "",
          "time": article["publishedAt"] ?? "",
          "content": article["content"] ?? "",
        };
      }).toList();
    } else {
      throw Exception("Failed to fetch headlines");
    }
  }
}
