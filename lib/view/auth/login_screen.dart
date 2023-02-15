import 'package:crud_app/res/components/round_button.dart';
import 'package:crud_app/utils/routes/routes_name.dart';
import 'package:crud_app/view_model/login_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../res/components/email_field.dart';
import '../../res/components/password_field.dart';
import '../../res/constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  void onLoginButtonPressed() {
    if (_formKey.currentState!.validate()) {
      LoginServices.login(
        context: context,
        auth: _auth,
        emailController: emailController,
        passwordController: passwordController,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.kWhiteColor,
      appBar: AppBar(
        backgroundColor: Constant.kWhiteColor,
        elevation: 0,
        title: const Center(
          child: Text(
            'LOGIN',
            style: TextStyle(
              color: Constant.kBlackColor,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmailTextFormField(
                    controller: emailController,
                    emailFocusNode: emailFocusNode,
                    passwordFocusNode: passwordFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PasswordTextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter password';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundButton(
                    loading: loading,
                    title: 'Login',
                    onPress: onLoginButtonPressed,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.forgotPassword);
                      },
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(
                          color: Constant.kBlackColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Constant.kBlackColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesName.signup);
                        },
                        child: const Text("Signup"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
