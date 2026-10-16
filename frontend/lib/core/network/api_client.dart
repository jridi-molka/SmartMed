import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';
import '../storage/token_storage.dart';

class ApiClient {
  final TokenStorage _tokenStorage = TokenStorage();

  Future<http.Response> post(String path,
      {Map<String, dynamic>? body, bool auth = false}) async {
    return http.post(
      Uri.parse('${ApiConstants.baseUrl}$path'),
      headers: await _headers(auth),
      body: body != null ? jsonEncode(body) : null,
    );
  }

  Future<http.Response> get(String path, {bool auth = false}) async {
    return http.get(
      Uri.parse('${ApiConstants.baseUrl}$path'),
      headers: await _headers(auth),
    );
  }

  Future<http.Response> put(String path,
      {Map<String, dynamic>? body, bool auth = false}) async {
    return http.put(
      Uri.parse('${ApiConstants.baseUrl}$path'),
      headers: await _headers(auth),
      body: body != null ? jsonEncode(body) : null,
    );
  }

  Future<Map<String, String>> _headers(bool auth) async {
    final headers = {'Content-Type': 'application/json'};
    if (auth) {
      final token = await _tokenStorage.getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }
}