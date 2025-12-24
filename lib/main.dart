import 'package:flutter/material.dart';
import 'screens/start_screen.dart';

void main() {
  runApp(const AirplaneGameApp());
}

class AirplaneGameApp extends StatelessWidget {
  const AirplaneGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airplane Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const StartScreen(),
    );
  }
}
