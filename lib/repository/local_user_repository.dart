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

    if (userJson == null) {
      return null; // Якщо даних немає, повертаємо null
    }

    try {
      final userMap = jsonDecode(userJson);
      return User.fromMap(Map<String, String>.from(userMap));
    } catch (e) {
      // У разі помилки при декодуванні JSON, повертаємо null
      print('Error decoding user data: $e');
      return null;
    }
  }

  @override
  Future<void> updateUser(User user) async {
    await registerUser(user); // Просто перезаписуємо дані
  }
}
