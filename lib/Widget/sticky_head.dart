import 'package:flutter/material.dart';

class StickyHead extends StatelessWidget {
  final String date;
  StickyHead({@required this.date});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .04,
      ).add(
        EdgeInsets.only(
          bottom: 10,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(14),
        width: double.infinity,
        child: Text(
          date,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20
          ),
        ),
      ),
    );
  }
}
