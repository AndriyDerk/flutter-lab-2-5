import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String label;
  final bool isPassword;
  final TextEditingController controller;

  const TextInput({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      obscureText: isPassword,
    );
  }
}
