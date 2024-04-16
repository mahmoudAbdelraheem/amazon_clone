import 'package:amazon_clone/features/profile/widgets/profile_button.dart';
import 'package:flutter/material.dart';

class CustomTopButtons extends StatefulWidget {
  const CustomTopButtons({super.key});

  @override
  State<CustomTopButtons> createState() => _CustomTopButtonsState();
}

class _CustomTopButtonsState extends State<CustomTopButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ProfilButton(text: 'Your Orders', onTap: () {}),
            ProfilButton(text: 'Turn Seller', onTap: () {}),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            ProfilButton(text: 'Log Out', onTap: () {}),
            ProfilButton(text: 'Your Wish List', onTap: () {}),
          ],
        ),
      ],
    );
  }
}
