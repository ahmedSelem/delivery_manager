import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double barHeigh;
  final Color barColor;
  final String deliverMen;
  final int numberOfOrder;
  ChartBar({
    @required this.barColor,
    @required this.barHeigh,
    @required this.deliverMen,
    @required this.numberOfOrder,
  });
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: '$deliverMen \n #$numberOfOrder Orders',
      textStyle: TextStyle(color: Theme.of(context).primaryColor),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Container(
        height: barHeigh,
        width: 20,
        color: barColor,
      ),
    );
  }
}
