import 'package:flutter/material.dart';
import '../widgets/text_input.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextInput(label: 'Email'),
            const SizedBox(height: 16),
            const TextInput(label: 'Password', isPassword: true),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Login',
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('Don\'t have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}
