import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

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
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}