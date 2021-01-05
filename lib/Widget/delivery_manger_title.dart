import 'package:flutter/material.dart';

class DeliverManagTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width * .06,
      ),
      child: Text(
        "Delivery Manager",
        style: TextStyle(color: Colors.white, fontSize: 30),
      ),
    );
  }
}
