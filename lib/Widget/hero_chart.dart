import 'package:flutter/material.dart';

class ChartHero extends StatelessWidget {
  final Color colorName;
  final String deliverMen;
  ChartHero(this.deliverMen, this.colorName);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          color: colorName,
          margin: EdgeInsets.only(
            right: 3,
            left: 10,
          ),
        ),
        Text(deliverMen),
      ],
    );
  }
}
