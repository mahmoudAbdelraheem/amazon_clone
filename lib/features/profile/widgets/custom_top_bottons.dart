import '../services/profile_services.dart';
import 'profile_button.dart';
import 'package:flutter/material.dart';

class CustomTopButtons extends StatelessWidget {
  const CustomTopButtons({super.key});

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
            ProfilButton(
              text: 'Log Out',
              onTap: () => ProfileServicesImp().logOut(context: context),
            ),
            ProfilButton(text: 'Your Wish List', onTap: () {}),
          ],
        ),
      ],
    );
  }
}
