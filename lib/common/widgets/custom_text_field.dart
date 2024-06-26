import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController myController;
  final String hintText;
  final int maxLine;
  const CustomTextField({
    super.key,
    required this.myController,
    required this.hintText,
    this.maxLine = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: myController,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38,
            ),
          ),
        ),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Please Enter Your $hintText';
          }
          return null;
        },
        maxLines: maxLine,
      ),
    );
  }
}
