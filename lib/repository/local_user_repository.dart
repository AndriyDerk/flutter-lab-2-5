import 'user_repository.dart';
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert'; // Для конвертації JSON

class LocalUserRepository implements UserRepository {
  @override
  Future<void> registerUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(user.email, jsonEncode(user.toMap()));
  }

  @override
  Future<User?> getUserByEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(email);

    if (userJson == null) return null;

    final userMap = jsonDecode(userJson);
    return User.fromMap(Map<String, String>.from(userMap));
  }

  @override
  Future<void> updateUser(User user) async {
    await registerUser(user);
  }

  Future<void> saveSession(String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('current_session', email);
  }

  Future<String?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('current_session');
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('current_session');
  }
}
