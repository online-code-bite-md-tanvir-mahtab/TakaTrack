import 'package:flutter/cupertino.dart';

class Goal {
  final IconData icon;
  final String title;
  final double amount;
  final double progress; // Value between 0.0 and 1.0
  final String progressText;

  Goal({
    required this.icon,
    required this.title,
    required this.amount,
    required this.progress,
    required this.progressText,
  });

}