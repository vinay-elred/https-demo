import 'dart:convert';
import 'dart:developer';

import 'package:http_requests/core/server_connector.dart';
import 'package:http_requests/model/user_model.dart';

class UsersAPI {
  Future<List<UserModel>> getUsers() async {
    try {
      const url = '${ServerConnector.baseUrl}/users';
      final response = await ServerConnector.client.get(Uri.parse(url));
      if (response.statusCode != 200) throw response;
      final decoded = jsonDecode(response.body) as List;
      return decoded.map((e) => UserModel.fromMap(e)).toList();
    } catch (e) {
      log("Error -> Get Users $e");
      return [];
    }
  }

  Future<List<UserModel>> getUserById(String id) async {
    try {
      const url = '${ServerConnector.baseUrl}/users';
      final uri = Uri.parse(url).replace(query: id);
      final response = await ServerConnector.client.get(uri);
      if (response.statusCode != 200) throw response;
      final decoded = jsonDecode(response.body) as List;
      return decoded.map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      log("Error -> Get Users $e");
      return [];
    }
  }
}
