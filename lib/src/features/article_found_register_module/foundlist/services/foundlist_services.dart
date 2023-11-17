import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_article_details.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:flutter/material.dart';

import '../../../../configurations/environment_config.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getArticle = '$baseUrl/getFoundById';
  static final String _getArticleList = '$baseUrl/getArticleFound?';
}

class FoundListServices {
  Future<FoundListModel> getFoundArticleList({
    required String startPosition,
    required String maximumRecords,
    required String userId,
    BuildContext? context,
  }) async {
    String url =
        '${Apis._getArticleList}startPos=$startPosition&maxResults=$maximumRecords&userId=$userId';
    var response = await BaseApiService().getRequest(
      isAuthenticated: true,
      url: url,
    );
    return FoundListModel.fromJson(response);
  }

  Future<FoundListArticleDetails> getArticleById(
      int articleId, BuildContext context) async {
    final String url = '${Apis._getArticle}/$articleId';
    final response =
        await BaseApiService().getRequest(url: url, isAuthenticated: false);

    return FoundListArticleDetails.fromJson(response);
  }
}
