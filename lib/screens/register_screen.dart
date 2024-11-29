import 'package:flutter/material.dart';
import '../widgets/text_input.dart';
import '../widgets/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextInput(label: 'Name'),
            const SizedBox(height: 16),
            const TextInput(label: 'Email'),
            const SizedBox(height: 16),
            const TextInput(label: 'Password', isPassword: true),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Register',
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        ),
      ),
    );
  }
}
