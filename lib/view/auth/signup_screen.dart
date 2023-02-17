import 'package:crud_app/res/components/round_button.dart';
import 'package:crud_app/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/components/email_field.dart';
import '../../res/components/password_field.dart';
import '../../res/constant.dart';
import '../../view_model/signup_view_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onSignUpButtonPressed(SignUpViewModel signUpViewModel) {
    if (_formKey.currentState!.validate()) {
      signUpViewModel.signUp(
        context: context,
        auth: _auth,
        emailController: emailController,
        passwordController: passwordController,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final signUpViewModel = Provider.of<SignUpViewModel>(context);
    print('build');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constant.kWhiteColor,
          elevation: 0,
          title: const Center(
            child: Text(
              'SIGN UP',
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
                        return 'Enter email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundButton(
                      loading: signUpViewModel.loading,
                      title: 'Sign Up',
                      onPress: () => onSignUpButtonPressed(signUpViewModel)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already hava an account?",
                        style: TextStyle(
                          color: Constant.kBlackColor,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RoutesName.login);
                          },
                          child: const Text("Login")),
                    ],
                  )
                ],
              ),
            )));
  }
}
