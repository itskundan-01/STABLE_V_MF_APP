import 'package:flutter/material.dart';
import 'package:mf_app/screens/home_screen.dart';
// import 'package:mf_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mutual Fund App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: FundSelectionScreen(),
      home: const HomeScreen(),
    );
  }
}
