import 'package:flutter/material.dart';
import 'screens/queue_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode
          ? ThemeData.dark()
          : ThemeData(
              primarySwatch: Colors.cyan,
              scaffoldBackgroundColor: Colors.lightBlue[100],
            ),
      home: QueueListScreen(
        isDarkMode: isDarkMode,
        onToggleTheme: () {
          setState(() => isDarkMode = !isDarkMode);
        },
      ),
    );
  }
}