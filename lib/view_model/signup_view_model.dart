import 'package:crud_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/utils/routes/routes_name.dart';

class SignUpViewModel with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  void setLoading(bool load) {
    _loading = load;
    notifyListeners();
  }

  Future<void> signUp({
    required BuildContext context,
    required FirebaseAuth auth,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    setLoading(true);
    try {
      await auth.createUserWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString());

      setLoading(false);
      Navigator.pushNamed(context, RoutesName.dataScreen);
      Utils().showSuccessToast('User Register Successfully');
    } catch (error) {
      setLoading(false);
      Utils().flushBarErrorMessage(error.toString(), context);
    }
  }
}
