import 'package:crud_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/utils/routes/routes_name.dart';

class SignUpServices {
  static void login({
    required BuildContext context,
    required FirebaseAuth auth,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) {
    auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      Navigator.pushNamed(context, RoutesName.dataScreen);
      Utils().flushBarErrorMessage('User Register Successfuly', context);
    }).onError((error, stackTrace) {
      Utils().flushBarErrorMessage(error.toString(), context);
    });
  }
}