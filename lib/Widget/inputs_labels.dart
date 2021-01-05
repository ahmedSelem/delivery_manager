import 'package:flutter/material.dart';

class InputLabel extends StatelessWidget {
  final String label;
  InputLabel(this.label);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
