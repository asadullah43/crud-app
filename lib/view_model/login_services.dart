import 'package:crud_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/utils/routes/routes_name.dart';

class LoginServices {
  static void login({
    required BuildContext context,
    required FirebaseAuth auth,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) {
    auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      Navigator.pushNamed(context, RoutesName.dataScreen);
      Utils().flushBarErrorMessage('Login Successfull', context);
    }).onError((error, stackTrace) {
      Utils().flushBarErrorMessage(error.toString(), context);
    });
  }
}
