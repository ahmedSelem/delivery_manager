import 'dart:collection';

import 'package:delivery_manager/Modal/order.dart';
import 'package:delivery_manager/Widget/bar_chart.dart';
import 'package:delivery_manager/Widget/hero_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class Chart extends StatefulWidget {
  final DateTime selectedDate;
  final Function activeList;
  final SplayTreeSet<Orders> selctedOrder;

  Chart(this.activeList, this.selectedDate, this.selctedOrder);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {

  Map<String, int> data;
  void sendData() {
    data = Map<String, int>();

    if (widget.selctedOrder != null) {
      widget.selctedOrder.forEach((element) {
        if (data.containsKey(element.deliveryMan)) {
          data[element.deliveryMan]++;
        } else {
          data[element.deliveryMan] = 1;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sendData();
    return Card(
      elevation: 5,
      color: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height * .03,
      ).add(EdgeInsetsDirectional.only(bottom: 30)),
      child: Container(
        padding: EdgeInsets.all(5),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    DateTime currentDate =
                        DateTime.now().subtract(Duration(days: index));
                    String textDate = DateFormat('dd/MM').format(currentDate);
                    bool activeDate = textDate ==
                        DateFormat('dd/MM').format(widget.selectedDate);
                    return Container(
                      margin: EdgeInsets.only(
                        left: (index == 6) ? 0 : 2,
                        right: (index == 0) ? 0 : 2,
                      ),
                      child: FlatButton(
                        shape: StadiumBorder(),
                        child: Text(textDate),
                        color:
                            activeDate ? Colors.amber[400] : Colors.amber[100],
                        onPressed: () {
                          widget.activeList(currentDate);
                        },
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 8,
                child: (widget.selctedOrder == null || widget.selctedOrder.isEmpty)
                    ? Center(
                        child: Text(
                          "No Order Yet",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Text("#Order"),
                                Expanded(child: Container()),
                                Expanded(
                                  flex: 2,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      ChartHero('Ahmed Selem', Colors.pink),
                                      ChartHero('Mahmoud Shams', Colors.green),
                                      ChartHero('Mohamed Mohie', Colors.purple)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              return Row(
                                children: [
                                  Container(
                                    width: constraints.maxWidth * .1,
                                    height: constraints.maxHeight,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(color: Colors.black),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("20"),
                                        Text("10"),
                                        Text("0"),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: constraints.maxWidth * .9,
                                    height: constraints.maxHeight,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.black),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (data.containsKey("Mohamed Mohie"))
                                          ChartBar(
                                            barColor: Colors.purple,
                                            barHeigh: constraints.maxHeight *
                                                data["Mohamed Mohie"] /
                                                20,
                                            deliverMen: 'Mohamed Mohie',
                                            numberOfOrder:
                                                data["Mohamed Mohie"],
                                          ),
                                        if (data.containsKey("Ahmed Selem"))
                                          ChartBar(
                                            barColor: Colors.pink,
                                            barHeigh: constraints.maxHeight *
                                                data["Ahmed Selem"] /
                                                20,
                                            deliverMen: 'Ahmed Selem',
                                            numberOfOrder: data["Ahmed Selem"],
                                          ),
                                        if (data.containsKey("Mahmoud Shams"))
                                          ChartBar(
                                            barColor: Colors.green,
                                            barHeigh: constraints.maxHeight *
                                                data["Mahmoud Shams"] /
                                                20,
                                            deliverMen: 'Mahmoud Shams',
                                            numberOfOrder:
                                                data["Mahmoud Shams"],
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
