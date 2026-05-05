import 'package:flutter/material.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();

  User? _user;
  bool _isLoggedIn = false;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoggedIn => _isLoggedIn;
  bool get isAuthenticated => _isLoggedIn;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isSubscribed => _user?.hasActiveSubscription ?? false;

  Future<void> init() async {
    final loggedIn = await _service.isLoggedIn();
    if (loggedIn) {
      _isLoggedIn = true;
      _user = await _service.getCurrentUser();
      notifyListeners();
    }
  }

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _service.login(username, password);
    _isLoading = false;

    if (result['success'] == true) {
      _isLoggedIn = true;
      _user = await _service.getCurrentUser();
      notifyListeners();
      return true;
    }

    _error = result['error'] as String?;
    notifyListeners();
    return false;
  }

  Future<bool> register(Map<String, dynamic> data) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _service.register(data);
    _isLoading = false;

    if (result['success'] == true) {
      // Auto-login after registration if token was returned, else user must login
      final loggedIn = await _service.isLoggedIn();
      if (loggedIn) {
        _isLoggedIn = true;
        _user = await _service.getCurrentUser();
      }
      notifyListeners();
      return true;
    }

    _error = result['error'] as String?;
    notifyListeners();
    return false;
  }

  Future<void> logout() async {
    await _service.logout();
    _isLoggedIn = false;
    _user = null;
    notifyListeners();
  }

  Future<bool> updateProfile(Map<String, dynamic> data) async {
    final updated = await _service.updateProfile(data);
    if (updated != null) {
      _user = updated;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> deleteAccount() async {
    final success = await _service.deleteAccount();
    if (success) {
      _isLoggedIn = false;
      _user = null;
      notifyListeners();
    }
    return success;
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
