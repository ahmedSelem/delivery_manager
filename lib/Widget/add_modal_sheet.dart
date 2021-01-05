import 'package:delivery_manager/Modal/order.dart';
import 'package:delivery_manager/Widget/inputs_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddModalSheet extends StatefulWidget {
  final List<String> deliveryMen;
  final Function addOrder;
  AddModalSheet(this.deliveryMen, this.addOrder);
  @override
  _AddModalSheetState createState() => _AddModalSheetState();
}

class _AddModalSheetState extends State<AddModalSheet> {
  String selectedDeliverMen;
  DateTime currentDate;
  TextEditingController inputValue;
  @override
  void initState() {
    super.initState();
    selectedDeliverMen = widget.deliveryMen[0];
    currentDate = DateTime.now();
    inputValue = TextEditingController();
  }

  @override
  void dispose() {
    inputValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          color: Theme.of(context).accentColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(12),
              child: Text(
                "let\'s Add An Order",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputLabel("Who\'ll Deliver ?"),
                  Card(
                    color: Colors.grey[300],
                    child: DropdownButtonHideUnderline(
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: DropdownButton(
                          isExpanded: true,
                          value: selectedDeliverMen,
                          items: widget.deliveryMen.map((e) {
                            return DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDeliverMen = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  InputLabel("when\'ll be deliverd ?"),
                  Row(
                    children: [
                      RaisedButton(
                        color: Colors.grey[300],
                        child: Text(
                          DateFormat('EEEE, dd/MM/yyyy').format(currentDate),
                        ),
                        onPressed: () async {
                          DateTime pickedDate = await showDatePicker(
                            context: context,
                            initialDate: currentDate,
                            firstDate: currentDate.subtract(Duration(days: 6)),
                            lastDate: currentDate.add(Duration(days: 6)),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              currentDate = DateTime(
                                pickedDate.year,
                                pickedDate.month,
                                pickedDate.day,
                                currentDate.hour,
                                currentDate.minute,
                              );
                            });
                          }
                        },
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("at"),
                      ),
                      RaisedButton(
                        color: Colors.grey[300],
                        child: Text(
                          DateFormat('hh:mm a').format(currentDate),
                        ),
                        onPressed: () async {
                          TimeOfDay time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(currentDate),
                          );
                          if (time != null) {
                            setState(() {
                              currentDate = DateTime(
                                  currentDate.year,
                                  currentDate.month,
                                  currentDate.day,
                                  time.hour,
                                  time.minute);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  InputLabel("What\'s The Price ?"),
                  Card(
                    color: Colors.grey[300],
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: inputValue,
                        decoration: InputDecoration(
                          hintText: 'Plz Enter Price',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 14),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Add Order',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          try {
                            double price = double.parse(inputValue.text);
                            if (price < 0) {
                              throw ("Invaid Price");
                            }
                            Orders order = new Orders(
                              orderDate: currentDate,
                              deliveryMan: selectedDeliverMen,
                              price: price
                            );
                            widget.addOrder(DateFormat('yyyyMMdd').format(order.orderDate), order);
                          } catch (error) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Envaild Price"),
                                  content: Text("Please Enter Vaild Price"),
                                  actions: [
                                    RaisedButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
