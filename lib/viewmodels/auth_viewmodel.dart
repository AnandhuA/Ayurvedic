import 'dart:developer';

import 'package:ayurvedic/core/utlis/error_helper.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    try {
      _setLoading(true);
      _errorMessage = null;

      await _authService.login(username: username, password: password);

      _setLoading(false);
      return true;
    } catch (e) {
      log("error viewmodel $e");
      _errorMessage = ErrorHelper.getErrorMessage(e);
      _setLoading(false);
      return false;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
