import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFF8F3FF);
  static const Color primary = Color(0xFFE91E63);
  static const Color cardWork = Color(0xFFFFF9C4);      // Light yellow
  static const Color cardStudy = Color(0xFFFFCDD2);     // Light pink
  static const Color cardPersonal = Color(0xFFBBDEFB);  // Light blue
  static const Color iconColor = Color(0xFF757575);     // Grey for icons
}

class Categories {
  static const String all = 'All';
  static const String work = 'Work';
  static const String study = 'Study';
  static const String personal = 'Personal';

  static Color getColorForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'work':
        return AppColors.cardWork;
      case 'study':
        return AppColors.cardStudy;
      case 'personal':
        return AppColors.cardPersonal;
      default:
        return Colors.white;
    }
  }

  static List<String> values = [all, work, study, personal];
} 