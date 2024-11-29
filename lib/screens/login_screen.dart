import 'package:flutter/material.dart';
import '../repository/local_user_repository.dart';
import '../widgets/text_input.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _repository = LocalUserRepository();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final user = await _repository.getUserByEmail(email);

    if (user == null) {
      setState(() => _errorMessage = 'User not found.');
      return;
    }

    if (user.password != password) {
      setState(() => _errorMessage = 'Invalid password.');
      return;
    }

    Navigator.pushNamed(context, '/home');
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
            TextInput(label: 'Email', controller: _emailController),
            SizedBox(height: 16), // Відступ між інпутами
            TextInput(
              label: 'Password',
              isPassword: true,
              controller: _passwordController,
            ),
            SizedBox(height: 16),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            SizedBox(height: 16),
            CustomButton(text: 'Login', onPressed: _login),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text("Don't have an account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}
