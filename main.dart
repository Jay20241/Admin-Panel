import 'package:flutter/material.dart';
import 'package:multiwebpanel/views/main_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      // theme: ThemeData(
      //   scaffoldBackgroundColor: const Color.fromARGB(255, 156, 155, 155),
      // ),
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
