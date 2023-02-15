import 'package:flutter/material.dart';

class Constant {
  static const kWhiteColor = Colors.white;
  static const kBlackColor = Colors.black;
  static const kBlueColor = Colors.blue;

  static const kErrorBarIndicatorColor = Colors.red;
  static final kErrorBackgroundGradient = LinearGradient(
    colors: [Colors.red.shade900, Colors.red.shade600],
  );

  static const kErrorBoxShadows = [
    BoxShadow(
      color: Color(0x7F000000),
      spreadRadius: 2,
      blurRadius: 10,
      offset: Offset(0, 3),
    ),
  ];

  static const kSuccessToastBackgroundColor = Colors.green;

  static final kRoundBtnShadow = [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 2,
      blurRadius: 5,
      offset: const Offset(0, 3),
    ),
  ];
  static const kRoundBtnGradient = LinearGradient(
    colors: [Colors.purple, Colors.pink],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const kAppbarClr = Colors.purple;
}
