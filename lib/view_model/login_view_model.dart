import 'package:crud_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/utils/routes/routes_name.dart';

class LoginViewModel with ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool load) {
    _loading = load;
    notifyListeners();
  }

  Future<void> login({
    required BuildContext context,
    required FirebaseAuth auth,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    try {
      setLoading(true);
      await auth.signInWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString());
      setLoading(false);
      Navigator.pushNamed(context, RoutesName.dataScreen);
      Utils().showSuccessToast('Login Successfully');
    } catch (error) {
      setLoading(false);
      Utils().flushBarErrorMessage(error.toString(), context);
    }
  }
}
