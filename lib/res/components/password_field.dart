import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const PasswordTextFormField({
    Key? key,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: FocusNode(),
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Enter Password',
        prefixIcon: Icon(Icons.lock),
      ),
      validator: validator,
    );
  }
}
