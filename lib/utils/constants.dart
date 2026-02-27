import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBlue = Color(0xFF29B6F6);
  static const Color darkBlue = Color(0xFF0288D1);
  static const Color lightBlue = Color(0xFF4FC3F7);
  static const Color successGreen = Color(0xFF66BB6A);
  static const Color warningOrange = Color(0xFFFF9800);
  static const Color dangerRed = Color(0xFFEF5350);
  static const Color textDark = Color(0xFF1E293B);
  static const Color textLight = Color(0xFF64748B);
  static const Color backgroundGray = Color(0xFFF5F7FA);
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static const TextStyle title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );
  
  static const TextStyle subtitle = TextStyle(
    fontSize: 14,
    color: AppColors.textLight,
  );
}