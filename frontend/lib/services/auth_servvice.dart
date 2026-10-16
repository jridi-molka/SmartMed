import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/constants/api_constants.dart';
import '../core/network/api_client.dart';
import '../core/network/api_exception.dart';
import '../core/storage/token_storage.dart';
import '../models/login_response.dart';
import '../models/user.dart';

class AuthService {
  final ApiClient _client = ApiClient();
  final TokenStorage _tokenStorage = TokenStorage();

  Future<User> register(String name, String email, String password) async {
    final response = await _client.post(
      ApiConstants.register,
      body: {'name': name, 'email': email, 'password': password},
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    }
    throw ApiException(_errorMessage(response));
  }

  Future<LoginResponse> login(String email, String password) async {
    final response = await _client.post(
      ApiConstants.login,
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final result = LoginResponse.fromJson(jsonDecode(response.body));
      await _tokenStorage.saveToken(result.accessToken);
      return result;
    }
    throw ApiException(_errorMessage(response));
  }

  Future<User> getMe() async {
    final response = await _client.get(ApiConstants.me, auth: true);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    throw ApiException(_errorMessage(response));
  }

  Future<void> logout() async {
    try {
      await _client.post(ApiConstants.logout, auth: true);
    } finally {
      await _tokenStorage.deleteToken();
    }
  }

  String _errorMessage(http.Response response) {
    try {
      final json = jsonDecode(response.body);
      final detail = json['detail'];
      if (detail is String) return detail;
      if (detail is List && detail.isNotEmpty) {
        return detail.first['msg'] as String;
      }
    } catch (_) {}
    return 'Erreur serveur (${response.statusCode})';
  }
}