import '../models/user.dart';

abstract class UserRepository {
  Future<void> registerUser(User user);
  Future<User?> getUserByEmail(String email);
  Future<void> updateUser(User user);
}
