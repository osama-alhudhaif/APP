import 'dart:convert';
import '../models/user_model.dart';
import 'api_service.dart';
import '../../core/constants/app_constants.dart';

class AuthService {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await _api.post(
      ApiEndpoints.login,
      body: {'username': username, 'password': password},
    );
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      final token = data['token'] as String;
      await _api.setToken(token);
      return {'success': true, 'token': token, 'user_id': data['user_id'], 'username': data['username']};
    }
    return {'success': false, 'error': data['error'] ?? data['detail'] ?? 'بيانات خاطئة'};
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    final response = await _api.post(ApiEndpoints.register, body: data);
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 201 || response.statusCode == 200) {
      if (body['token'] != null) {
        await _api.setToken(body['token'] as String);
      }
      return {'success': true};
    }
    final errors = body.values.whereType<List>().expand((e) => e).join(', ');
    return {'success': false, 'error': errors.isNotEmpty ? errors : (body['detail'] ?? 'فشل التسجيل')};
  }

  Future<void> logout() => _api.clearToken();

  Future<String?> getToken() => _api.getToken();

  Future<bool> isLoggedIn() => _api.hasToken();

  Future<User?> getCurrentUser() async {
    final response = await _api.get(ApiEndpoints.me, requiresAuth: true);
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }
    return null;
  }

  Future<User?> updateProfile(Map<String, dynamic> data) async {
    final response = await _api.put(ApiEndpoints.me, requiresAuth: true, body: data);
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }
    return null;
  }

  Future<bool> deleteAccount() async {
    final response = await _api.delete(ApiEndpoints.me, requiresAuth: true);
    return response.statusCode == 204 || response.statusCode == 200;
  }
}
