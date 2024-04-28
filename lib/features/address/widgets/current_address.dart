import 'package:flutter/material.dart';

class CurrentAddress extends StatelessWidget {
  final String address;
  const CurrentAddress({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
          ),
          child: Text(
            address,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'OR',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
