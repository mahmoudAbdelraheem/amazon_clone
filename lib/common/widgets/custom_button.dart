import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const CustomButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(
          title,
        ),
      ),
    );
  }
}
