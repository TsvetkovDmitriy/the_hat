import 'package:flutter/material.dart';
import 'package:hat/theme/colors.dart';

class ButtonNavigationBar extends StatelessWidget {
  ButtonNavigationBar({super.key, required this.onPressed, required this.text});

  final VoidCallback onPressed;
  String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(AppColors.blue),
          padding: MaterialStateProperty.all(
              const EdgeInsets.only(left: 60, top: 15, right: 60, bottom: 15)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: AppColors.blue)))),
      child: Text(text),
    );
  }
}
