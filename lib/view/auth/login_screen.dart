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
  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
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
                            setState(() {
                              loading = true;
                            });
                            _auth
                                .signInWithEmailAndPassword(
                                    email: emailcontroller.text.toString(),
                                    password:
                                        passwordcontroller.text.toString())
                                .then((value) {
                              setState(() {
                                loading = false;
                              });
                              Navigator.pushNamed(context, RoutesName.home);
                              Utils().flushBarErrorMessage(
                                  'Login Successfull', context);
                            }).onError((error, stackTrace) {
                              setState(() {
                                loading = false;
                              });
                              Utils().flushBarErrorMessage(
                                  error.toString(), context);
                            });
                          }),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                            onPressed: () {},
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
