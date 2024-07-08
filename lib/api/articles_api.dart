import 'dart:convert';
import 'dart:developer';

import 'package:http_requests/core/server_connector.dart';

import '../model/article_model.dart';

class ArticlesAPI {
  Future<List<ArticleModel>> getArticles() async {
    try {
      const url = '${ServerConnector.baseUrl}/articles';
      final response = await ServerConnector.client.get(Uri.parse(url));
      if (response.statusCode != 200) throw response;
      final decoded = jsonDecode(response.body) as List;
      return decoded.map((e) => ArticleModel.fromMap(e)).toList();
    } catch (e) {
      log("Error -> Get Articles $e");
      return [];
    }
  }

  Future<List<ArticleModel>> postArticle(ArticleModel article) async {
    try {
      const url = '${ServerConnector.baseUrl}/articles';
      final uri = Uri.parse(url);
      final response = await ServerConnector.client.post(
        uri,
        body: article,
      );
      if (response.statusCode != 200) throw response;
      final decoded = jsonDecode(response.body) as List;
      return decoded.map((e) => ArticleModel.fromMap(e)).toList();
    } catch (e) {
      log("Error -> POST Articles $e");
      return [];
    }
  }
}
