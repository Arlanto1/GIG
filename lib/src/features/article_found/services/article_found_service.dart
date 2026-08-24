
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/article_found/models/article_found_model.dart';
import 'package:db_atom/src/features/article_found/models/requestModels/article_found_request.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getList = '$baseUrl/getArticleFound';
  static final String _getById = '$baseUrl/getFoundById';
  static final String _create = '$baseUrl/addFound';
}

class ArticleFoundServices {
  final endpoint = Environment().config.apiHost;

  Future<ArticleFoundResponseModel> getListWithFilters({
    required String startPosition,
    required String maximumRecords,
    required BaseFilterModel filters,
    String? eventId,
  }) async {
    String url =
        '${Apis._getList}?startPos=$startPosition&maxResults=$maximumRecords';
    if (eventId != null) {
      url = '$url&eventId=$eventId';
    }
    var response = await BaseApiService().postRequest(
      requestedData: filters.toJson(),
      isAuthenticated: true,
      url: url,
    );
    return ArticleFoundResponseModel.fromJson(response);
  }

  Future<ArticleFoundModel> getById(
      int id,
      ) async {
    final String url = '${Apis._getById}/$id';
    final response = await BaseApiService().getRequest(
      url: url,
      isAuthenticated: true,
    );

    return ArticleFoundModel.fromJson(response);
  }

  Future<GenericResponse> createArticleFound({
    required ArticleFoundRequest body,
    required bool isSubmit,
    String? eventId,
  }) async {
    // final String url = "${Apis._create}?isSubmit=$isSubmit";
    // if (eventId != null) {
    //   url = '$url&eventProtectionId=$eventId';
    // }
    String url = "${Apis._create}?isSubmit=$isSubmit";
    if (eventId != null) {
      url = '$url&eventProtectionId=$eventId';
    }
    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );
    return GenericResponse.fromJson(response);
  }

}
