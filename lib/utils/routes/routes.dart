import 'package:crud_app/utils/routes/routes_name.dart';
import 'package:crud_app/view/auth/forgot_password.dart';
import 'package:crud_app/view/auth/login_screen.dart';
import 'package:crud_app/view/auth/signup_screen.dart';
import 'package:crud_app/view/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../view/add_data_screen.dart';
import '../../view/data_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case RoutesName.addData:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AddDataScreen());
      case RoutesName.forgotPassword:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ForgotPasswordScreen());
      case RoutesName.dataScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DataScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      case RoutesName.signup:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignupScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
