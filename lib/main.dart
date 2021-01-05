import 'package:delivery_manager/Screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode;
  void toggleThemeMode() {
    setState(() {
      if (themeMode == ThemeMode.light) {
        themeMode = ThemeMode.dark;
      } else {
        themeMode = ThemeMode.light;
      }
    });
  }

@override
  void initState() {
    super.initState();
    themeMode = ThemeMode.light;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(toggleThemeMode),
      title: "Delivery Manager",
      theme: ThemeData(
        primaryColor: Colors.blue[800],
        accentColor: Colors.white,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.grey[400],
      ),
      themeMode: themeMode,
    );
  }
}
