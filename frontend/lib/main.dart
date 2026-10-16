import 'package:flutter/material.dart';

import 'screens/auth/login_page.dart';

void main() {
  runApp(const SmartMedApp());
}

class SmartMedApp extends StatelessWidget {
  const SmartMedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartMed',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: const LoginPage(),
    );
  }
}