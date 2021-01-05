import 'dart:collection';

import 'dart:math';
import 'package:delivery_manager/Modal/order.dart';
import 'package:delivery_manager/Widget/add_modal_sheet.dart';
import 'package:delivery_manager/Widget/chart.dart';
import 'package:delivery_manager/Widget/delivery_manager_background.dart';
import 'package:delivery_manager/Widget/delivery_manger_title.dart';
import 'package:delivery_manager/Widget/list_items.dart';
import 'package:delivery_manager/Widget/sticky_head.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class HomeScreen extends StatefulWidget {
  final Function toggleThemeMode;
  HomeScreen(this.toggleThemeMode);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollControll = ScrollController();
  bool showButton = false;
  DateTime selectedDate;
  bool switchMode;
  SplayTreeSet<Orders> selctedOrder;

  SplayTreeMap<String, Map<String, dynamic>> ordersSorted =
      SplayTreeMap<String, Map<String, dynamic>>((String a, String b) {
    return -a.compareTo(b);
  });

//Add Order
  void addOrder(String key, Orders order) {
    Navigator.pop(context);
    setState(() {
      if (ordersSorted.containsKey(key)) {
        ordersSorted[key]['list'].add(order);
      } else {
        ordersSorted[key] = Map<String, dynamic>();
        ordersSorted[key]['date'] =
            DateFormat('EEEE, dd/MM/yyyy').format(order.orderDate);
        ordersSorted[key]['list'] = SplayTreeSet<Orders>((Orders a, Orders b) {
          return a.orderDate.compareTo(b.orderDate);
        });
        ordersSorted[key]['list'].add(order);
      }
    });
  }

//Remove Order
  void removeOrder(String key, Orders order) {
    setState(() {
      ordersSorted[key]['list'].remove(order);
      if (ordersSorted[key]["list"].isEmpty) {
        ordersSorted.remove(key);
      }
    });
  }

//Active List And Date In Chart
  void activeList(DateTime date) {
    setState(() {
      selectedDate = date;
      String key = DateFormat('yyyyMMdd').format(selectedDate);
      if (ordersSorted.containsKey(key)) {
        selctedOrder = ordersSorted[key]['list'];
      } else {
        selctedOrder = null;
      }
    });
  }

  //Generate Orders
  List<String> deliveryMen = ['Mohamed Mohie', 'Mahmoud Shams', 'Ahmed Selem'];
  @override
  void initState() {
    super.initState();
    final ordersList = List.generate(
      12,
      (index) {
        return Orders(
          deliveryMan: deliveryMen[Random().nextInt(3)],
          price: Random().nextDouble() * 500,
          orderDate: DateTime.now().subtract(
            Duration(
              days: Random().nextInt(12),
              hours: Random().nextInt(24),
              minutes: Random().nextInt(60),
            ),
          ),
        );
      },
    );

    ordersList.forEach((element) {
      final key = DateFormat('yyyyMMdd').format(element.orderDate);
      if (!ordersSorted.containsKey(key)) {
        ordersSorted[key] = Map<String, dynamic>();
        ordersSorted[key]['date'] =
            DateFormat('EEEE, dd/MM/yyyy').format(element.orderDate);
        ordersSorted[key]['list'] = SplayTreeSet((Orders a, Orders b) {
          return a.orderDate.compareTo(b.orderDate);
        });
      }
      ordersSorted[key]['list'].add(element);
    });

    selectedDate = DateTime.now();
    String key = DateFormat('yyyyMMdd').format(selectedDate);
    if (ordersSorted.containsKey(key)) {
      selctedOrder = ordersSorted[key]['list'];
    } else {
      selctedOrder = null;
    }
    switchMode = false;
  }

  @override
  void dispose() {
    scrollControll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Stack(
        children: [
          DeliverManageBackground(),
          SafeArea(
            child: Column(
              children: [
                DeliverManagTitle(),
                Chart(activeList, selectedDate, selctedOrder),
                Expanded(
                  child: NotificationListener<ScrollUpdateNotification>(
                    onNotification: (notification) {
                      if (notification.metrics.pixels > 20) {
                        setState(() {
                          showButton = true;
                        });
                      } else {
                        setState(() {
                          showButton = false;
                        });
                      }
                      return true;
                    },
                    child: ListView.builder(
                        padding: EdgeInsets.only(
                          bottom: kFloatingActionButtonMargin + 56,
                        ),
                        controller: scrollControll,
                        physics: BouncingScrollPhysics(),
                        itemCount: ordersSorted.length,
                        itemBuilder: (context, index) {
                          final keys = ordersSorted.keys.toList();
                          final currentKey = keys[index];
                          final currentDate = ordersSorted[currentKey]['date'];
                          final SplayTreeSet<Orders> currentOrder =
                              ordersSorted[currentKey]['list'];
                          return StickyHeader(
                            header: StickyHead(date: currentDate),
                            content: Column(
                              children: currentOrder.map((element) {
                                return ListItems(element, removeOrder);
                              }).toList(),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        child: Row(
          mainAxisAlignment: (showButton)
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.end,
          children: [
            if (showButton)
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 2 * kFloatingActionButtonMargin),
                child: FloatingActionButton(
                  mini: true,
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.brown,
                  onPressed: () {
                    scrollControll.jumpTo(0.0);
                  },
                ),
              ),
            Spacer(),
            Switch(
              value: switchMode,
              // activeThumbImage: ImageProvider(),
              activeColor: Theme.of(context).primaryColor,
              activeTrackColor: Colors.white,
              autofocus: true,
              onChanged: (value) {
                switchMode = value;
                widget.toggleThemeMode();
              },
            ),
            FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return AddModalSheet(deliveryMen, addOrder);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
