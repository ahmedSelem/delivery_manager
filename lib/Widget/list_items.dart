import 'package:delivery_manager/Modal/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListItems extends StatelessWidget {
  final Orders order;
  final Function removeOrder;
  ListItems(this.order, this.removeOrder);
  @override
  Widget build(BuildContext context) {
    bool darkTheme = Theme.of(context).primaryColor == Colors.grey[400];
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height * .02,
      ).add(EdgeInsets.only(bottom: 10)),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: darkTheme ? Colors.white70 : Theme.of(context).accentColor,
      child: Padding(
        padding: EdgeInsets.all(9.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${order.price.toStringAsFixed(2)}\$",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            order.deliveryMan,
          ),
          subtitle: Text(
            DateFormat("hh:mm a").format(order.orderDate),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,
            onPressed: () {
              removeOrder(DateFormat('yyyMMdd').format(order.orderDate), order);
            },
          ),
        ),
      ),
    );
  }
}
