import 'package:ecommerce_app/model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ratingbar extends StatelessWidget {
  late int FullStars;
  late int HalfStars;
  final double rating;
  Ratingbar({Key? key, required this.rating}) {
     FullStars = rating.toInt();
     HalfStars = ((rating - FullStars) * 2).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return   Row(
      children: List.generate(5, (index) {
        if (index < FullStars) {
          return Icon(
            Icons.star,
            size: 40,
            color: Color.fromRGBO(255, 193, 7,1),
          );
        }
        else if (index < FullStars +HalfStars) {
          return Icon(
            Icons.star_half,
            size: 40,
            color:Color.fromRGBO(255, 193, 7,1),
          );
        }
        else {
          return Icon(
            Icons.star_border,
            size: 40,
            color: Colors.grey,
          );
        }
      }),
    );
  }
}
