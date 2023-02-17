import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  PasswordTextFormField({
    Key? key,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _obsecurePassword,
        builder: (context, value, child) {
          return TextFormField(
            controller: controller,
            focusNode: FocusNode(),
            obscureText: _obsecurePassword.value,
            obscuringCharacter: '*',
            decoration: InputDecoration(
              hintText: 'Enter Password',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: InkWell(
                  onTap: () {
                    _obsecurePassword.value = !_obsecurePassword.value;
                  },
                  child: Icon(_obsecurePassword.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility)),
              fillColor: Colors.grey[200],
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.red.shade300),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.red.shade300),
              ),
            ),
            validator: validator,
          );
        });
  }
}
