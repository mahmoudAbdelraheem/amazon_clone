import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../constants/global_variables.dart';

class Stars extends StatelessWidget {
  final double rating;
  const Stars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: GlobalVariables.secondaryColor,
      ),
      itemCount: 5,
      itemSize: 15.0,
      direction: Axis.horizontal,
    );
  }
}
