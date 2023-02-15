import 'package:crud_app/res/constant.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;

  const RoundButton({
    Key? key,
    required this.title,
    this.loading = false,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          gradient: Constant.kRoundBtnGradient,
          boxShadow: Constant.kRoundBtnShadow,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  color: Constant.kWhiteColor,
                )
              : Text(
                  title,
                  style: const TextStyle(
                    color: Constant.kWhiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
        ),
      ),
    );
  }
}
