import 'package:flutter/material.dart';

class BuildCustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? initialValue;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;

  const BuildCustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      validator: validator,
    );
  }
}
