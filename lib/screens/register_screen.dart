import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repository/local_user_repository.dart';
import '../utils/validators.dart';
import '../widgets/text_input.dart';
import '../widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _repository = LocalUserRepository();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  void _register() async {
    final email = _emailController.text;
    final name = _nameController.text;
    final password = _passwordController.text;

    if (!isValidEmail(email)) {
      setState(() => _errorMessage = 'Invalid email address.');
      return;
    }
    if (!isValidName(name)) {
      setState(() => _errorMessage = 'Name cannot contain numbers.');
      return;
    }
    if (!isValidPassword(password)) {
      setState(() => _errorMessage = 'Password must be at least 6 characters.');
      return;
    }

    final user = User(email: email, name: name, password: password);
    await _repository.registerUser(user);

    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextInput(label: 'Email', controller: _emailController),
            SizedBox(height: 16), // Відступ між інпутами
            TextInput(label: 'Name', controller: _nameController),
            SizedBox(height: 16),
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
            CustomButton(text: 'Register', onPressed: _register),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
