bool isValidEmail(String email) {
  return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
}

bool isValidName(String name) {
  return !RegExp(r'[0-9]').hasMatch(name);
}

bool isValidPassword(String password) {
  return password.length >= 6;
}
