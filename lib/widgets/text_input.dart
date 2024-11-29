import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String label;
  final bool isPassword;

  const TextInput({super.key, required this.label, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      obscureText: isPassword,
    );
  }
}
