import 'package:flutter/cupertino.dart';

class Orders {
  static int _counter = 0;
  int id;
  double price;
  DateTime orderDate;
  String deliveryMan;

  Orders({
    @required this.orderDate,
    @required this.deliveryMan,
    @required this.price,
  }) {
    this.id =  ++_counter;
  }
}
