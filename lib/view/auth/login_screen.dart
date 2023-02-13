import 'package:crud_app/res/components/round_button.dart';
import 'package:crud_app/utils/routes/routes_name.dart';
import 'package:crud_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailcontroller.text.toString(),
            password: passwordcontroller.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
      Navigator.pushNamed(context, RoutesName.dataScreen);
      Utils().flushBarErrorMessage('Login Successfull', context);
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().flushBarErrorMessage(error.toString(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text('LOGIN'))),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: _formkey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: emailcontroller,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            hintText: 'Enter Email'),
                        onFieldSubmitted: ((value) {
                          Utils.fieldFocusChange(
                              context, emailFocusNode, passwordFocusNode);
                        }),
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
                      TextFormField(
                          controller: passwordcontroller,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              hintText: 'Enter Password'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter email';
                            } else {
                              return null;
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      RoundButton(
                          loading: loading,
                          title: 'Login',
                          onPress: () {
                            if (emailcontroller.text.isEmpty) {
                              Utils()
                                  .flushBarErrorMessage("Enter email", context);
                            } else if (passwordcontroller.text.isEmpty) {
                              Utils().flushBarErrorMessage(
                                  "Enter password", context);
                            } else if (passwordcontroller.text.length < 6) {
                              Utils().flushBarErrorMessage(
                                  "Enter 6 digit password", context);
                            } else {
                              login();
                            }
                          }),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RoutesName.forgotPassword);
                            },
                            child: const Text('Forgot Password')),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't hava an account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RoutesName.signup);
                              },
                              child: const Text("Signup")),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
