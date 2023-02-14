import 'package:flutter/material.dart';

class EmailTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FormFieldValidator<String>? validator;

  const EmailTextFormField({
    Key? key,
    required this.controller,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        emailFocusNode.unfocus();
        FocusScope.of(context).requestFocus(passwordFocusNode);
      },
      decoration: const InputDecoration(
        hintText: 'Enter Email',
        prefixIcon: Icon(Icons.email),
      ),
      validator: validator,
    );
  }
}
