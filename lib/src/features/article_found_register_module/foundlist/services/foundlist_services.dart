import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getArticle = '$baseUrl/getFoundById';
  static final String _getArticleList = '$baseUrl/getArticleFound?';
}

class FoundListServices {
  // Future<FoundListModel> getFoundArticleList({
  //   required String startPosition,
  //   required String maximumRecords,
  //   required String eventId,
  // }) async {
  //   String url =
  //       '${Apis._getArticleFounds}?startPos=$startPosition&maxResults=$maximumRecords&eventId=$eventId';
  //   final response = await BaseApiService().getRequest(
  //     url: url,
  //   );
  //   return FoundListModel.fromJson(response);
  // }

  Future<FoundListModel> getFoundArticleList({
    required String startPosition,
    required String maximumRecords,
    int? eventId,
    required BaseFilterModel filters,
  }) async {
    String url =
        '${Apis._getArticleList}startPos=$startPosition&maxResults=$maximumRecords';

    if (eventId != null) {
      url = '$url&eventId=$eventId';
    }
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
      // required String userId,
    );
    return FoundListModel.fromJson(response);
  }

  Future<FoundListArticleDetails> getArticleById(
      int articleId, BuildContext context) async {
    final String url = '${Apis._getArticle}/$articleId';
    final response =
        await BaseApiService().getRequest(url: url, isAuthenticated: true);

    return FoundListArticleDetails.fromJson(response);
  }
}
