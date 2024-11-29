import 'package:flutter/material.dart';
import '../repository/local_user_repository.dart';
import '../services/network_service.dart';
import '../widgets/dialogs.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _repository = LocalUserRepository();
  final _networkService = NetworkService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkAutoLogin();
  }

  void _checkAutoLogin() async {
    final sessionEmail = await _repository.getSession();
    if (sessionEmail != null) {
      final isConnected = await _networkService.isConnected();
      if (!isConnected) {
        showInfoDialog(context, 'You are offline, connect to the internet.');
      }
      Navigator.pushNamed(context, '/home');
    }
  }

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final user = await _repository.getUserByEmail(email);
    if (user == null || user.password != password) {
      showInfoDialog(context, 'Invalid email or password.');
      return;
    }

    final isConnected = await _networkService.isConnected();
    if (!isConnected) {
      showInfoDialog(context, 'No internet connection.');
      return;
    }

    await _repository.saveSession(email);

    // Показуємо повідомлення і після цього перенаправляємо
    showInfoDialog(context, 'Login successful!', () {
      Navigator.pushNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Don\'t have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}
