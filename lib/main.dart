import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Variable to store theme mode
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(isDarkMode: isDarkMode, toggleTheme: toggleTheme),
      theme:
          ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
      darkTheme:
          ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }

  // Function to toggle between light and dark mode
  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }
}
