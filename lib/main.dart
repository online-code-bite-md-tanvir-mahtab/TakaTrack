import 'package:flutter/material.dart';
import 'package:takatrack/screen/add_new_goal_screen.dart';
import 'package:takatrack/screen/add_transaction_screen.dart';
import 'package:takatrack/screen/budget_screen.dart';
import 'package:takatrack/screen/dashboard_screen.dart';
import 'package:takatrack/screen/main_screen.dart';
import 'package:takatrack/screen/reports_screen.dart';
import 'package:takatrack/screen/savings_goal_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TakaTrack',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/addTransaction': (context) => const AddTransactionScreen(),
        '/budget': (context) => const BudgetScreen(),
        '/reports_screen': (context) => const ReportsScreen(),
        '/savingsGoals': (context) => const SavingsGoalsScreen(),
        '/addNewGoal': (context) => const AddNewGoalScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
