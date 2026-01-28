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
        primaryColor: const Color(0xFF4DA3FF),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}
