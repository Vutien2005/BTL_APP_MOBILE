import 'package:flutter/material.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  bool _isAuthenticated = false;

  UserModel? get user => _user;
  bool get isAuthenticated => _isAuthenticated;

  AuthProvider() {
    // Check if user is logged in (mock)
    _checkAuthState();
  }

  void _checkAuthState() {
    // TODO: Check shared preferences for saved login
    // For now, assume not logged in
  }

  Future<void> signInWithEmail(String email, String password) async {
    // Mock authentication
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'test@example.com' && password == 'password') {
      _user = UserModel(id: '1', name: 'Test User', email: email);
      _isAuthenticated = true;
      notifyListeners();
    } else {
      throw Exception('Invalid credentials');
    }
  }

  Future<void> signUpWithEmail(
    String email,
    String password,
    String name,
  ) async {
    // Mock registration
    await Future.delayed(const Duration(seconds: 1));
    _user = UserModel(id: '1', name: name, email: email);
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> signOut() async {
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    // Mock password reset
    await Future.delayed(const Duration(seconds: 1));
  }
}
