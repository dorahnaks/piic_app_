import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const PIICClusterSaveApp());
}

class PIICClusterSaveApp extends StatelessWidget {
  const PIICClusterSaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PIIC ClusterSave',
      theme: ThemeData(
        primaryColor: const Color(0xFF0288D1),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0288D1),
          secondary: const Color(0xFF66BB6A),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}