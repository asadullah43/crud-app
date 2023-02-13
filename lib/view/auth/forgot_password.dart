import 'package:crud_app/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../../res/components/round_button.dart';
import '../../utils/utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  bool loading = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your email',
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_rounded),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            RoundButton(
              title: 'Forgot Password',
              onPress: () {
                Navigator.pushNamed(context, RoutesName.login);
                setState(() {
                  loading = true;
                });

                auth
                    .sendPasswordResetEmail(
                        email: emailController.text.toString())
                    .then((value) {
                  setState(() {
                    loading = false;
                  });
                  Utils().flushBarErrorMessage('Check email', context);
                }).onError((error, stackTrace) {
                  setState(() {
                    loading = false;
                  });
                  Utils().flushBarErrorMessage(error.toString(), context);
                });
              },
              loading: loading,
            )
          ],
        ),
      ),
    );
  }
}
