import 'package:crud_app/res/constant.dart';
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
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Constant.kAppbarClr,
      ),
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
              loading: loading,
              title: 'Forgot Password',
              onPress: () async {
                Navigator.pushNamed(context, RoutesName.login);
                setState(() {
                  loading = true;
                });

                try {
                  setState(() {
                    loading = true;
                  });
                  await FirebaseAuth.instance.sendPasswordResetEmail(
                      email: emailController.text.toString());
                  setState(() {
                    loading = false;
                  });
                  Utils().showSuccessToast('Email has been sent to you');
                } catch (error) {
                  setState(() {
                    loading = false;
                  });
                  Utils().flushBarErrorMessage(error.toString(), context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
