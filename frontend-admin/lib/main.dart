import 'package:flutter/material.dart';
import 'package:frontend/feature/splashscreen/presentation/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppName',
      theme: ThemeData(primaryColor: Colors.blue),
      home: const SplashScreen(),
    );
  }
}
