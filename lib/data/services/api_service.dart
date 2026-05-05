import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  String? _token;

  String? get cachedToken => _token;

  Future<void> setToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> clearToken() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_id');
  }

  Future<String?> getToken() async {
    if (_token != null) return _token;
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
    return _token;
  }

  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Map<String, String> _getHeaders({bool requiresAuth = false}) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (requiresAuth && _token != null) {
      headers['Authorization'] = 'Token $_token';
    }
    return headers;
  }

  Future<http.Response> get(
    String endpoint, {
    bool requiresAuth = false,
    Map<String, String>? queryParams,
  }) async {
    if (requiresAuth) await getToken();
    var uri = Uri.parse('${AppConstants.fullBaseUrl}$endpoint');
    if (queryParams != null && queryParams.isNotEmpty) {
      uri = uri.replace(queryParameters: queryParams);
    }
    return http.get(uri, headers: _getHeaders(requiresAuth: requiresAuth));
  }

  Future<http.Response> post(
    String endpoint, {
    bool requiresAuth = false,
    Map<String, dynamic>? body,
  }) async {
    if (requiresAuth) await getToken();
    return http.post(
      Uri.parse('${AppConstants.fullBaseUrl}$endpoint'),
      headers: _getHeaders(requiresAuth: requiresAuth),
      body: body != null ? jsonEncode(body) : null,
    );
  }

  Future<http.Response> put(
    String endpoint, {
    bool requiresAuth = false,
    Map<String, dynamic>? body,
  }) async {
    if (requiresAuth) await getToken();
    return http.put(
      Uri.parse('${AppConstants.fullBaseUrl}$endpoint'),
      headers: _getHeaders(requiresAuth: requiresAuth),
      body: body != null ? jsonEncode(body) : null,
    );
  }

  Future<http.Response> patch(
    String endpoint, {
    bool requiresAuth = false,
    Map<String, dynamic>? body,
  }) async {
    if (requiresAuth) await getToken();
    return http.patch(
      Uri.parse('${AppConstants.fullBaseUrl}$endpoint'),
      headers: _getHeaders(requiresAuth: requiresAuth),
      body: body != null ? jsonEncode(body) : null,
    );
  }

  Future<http.Response> delete(
    String endpoint, {
    bool requiresAuth = false,
  }) async {
    if (requiresAuth) await getToken();
    return http.delete(
      Uri.parse('${AppConstants.fullBaseUrl}$endpoint'),
      headers: _getHeaders(requiresAuth: requiresAuth),
    );
  }

  Future<http.Response> multipartPost(
    String endpoint, {
    required Map<String, String> fields,
    required String fileField,
    required String filePath,
    required String fileName,
  }) async {
    await getToken();
    final uri = Uri.parse('${AppConstants.fullBaseUrl}$endpoint');
    final request = http.MultipartRequest('POST', uri);
    if (_token != null) {
      request.headers['Authorization'] = 'Token $_token';
    }
    fields.forEach((key, value) => request.fields[key] = value);
    request.files.add(
      await http.MultipartFile.fromPath(fileField, filePath, filename: fileName),
    );
    final streamed = await request.send();
    return http.Response.fromStream(streamed);
  }

  Future<Uint8List> downloadBytes(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: {
      if (_token != null) 'Authorization': 'Token $_token',
    });
    if (response.statusCode == 200) return response.bodyBytes;
    throw Exception('Download failed: ${response.statusCode}');
  }
}
