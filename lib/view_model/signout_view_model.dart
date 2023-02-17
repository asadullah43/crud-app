import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class SignOutViewModel {
  final BuildContext context;
  final FirebaseAuth auth = FirebaseAuth.instance;

  SignOutViewModel(this.context);

  Future<void> signOut() async {
    try {
      await auth.signOut();
      Navigator.pushNamed(context, RoutesName.login);
      Utils().showSuccessToast('Sign out Successfully');
    } catch (error) {
      Utils().flushBarErrorMessage(error.toString(), context);
    }
  }
}
