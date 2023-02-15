import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../res/constant.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        title: "Error",
        titleText: const Text(
          "Error",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Constant.kWhiteColor,
          ),
        ),
        messageText: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
            color: Constant.kWhiteColor,
          ),
        ),
        icon: const Icon(
          Icons.error_outline,
          size: 28.0,
          color: Constant.kWhiteColor,
        ),
        duration: const Duration(seconds: 4),
        leftBarIndicatorColor: Colors.red,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        backgroundGradient: Constant.kErrorBackgroundGradient,
        boxShadows: Constant.kErrorBoxShadows,
        isDismissible: true,
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
        reverseAnimationCurve: Curves.fastOutSlowIn,
      )..show(context),
    );
  }

  void showSuccessToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Constant.kSuccessToastBackgroundColor,
      textColor: Constant.kWhiteColor,
      fontSize: 16.0,
    );
  }
}
