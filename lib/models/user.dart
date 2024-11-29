class User {
  final String email;
  final String name;
  final String password;

  User({required this.email, required this.name, required this.password});

  Map<String, String> toMap() => {
        'email': email,
        'name': name,
        'password': password,
      };

  factory User.fromMap(Map<String, String> map) {
    if (!map.containsKey('email') ||
        !map.containsKey('name') ||
        !map.containsKey('password')) {
      throw Exception('Invalid user data');
    }

    return User(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
