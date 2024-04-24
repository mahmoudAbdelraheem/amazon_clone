import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final Color? color;
  const CustomButton(
      {super.key, required this.title, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: color,
        ),
        child: Text(
          title,
          style: TextStyle(color: color == null ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
