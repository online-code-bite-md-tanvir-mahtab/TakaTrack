import 'package:flutter/material.dart';

class Transaction {
  final IconData icon;
  final String category;
  final String date;
  final double amount;
  final bool isIncome;

  Transaction({
    required this.icon,
    required this.category,
    required this.date,
    required this.amount,
    this.isIncome = false,
  });
}