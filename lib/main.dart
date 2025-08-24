import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:takatrack/screen/add_new_goal_screen.dart';
import 'package:takatrack/screen/add_transaction_screen.dart';
import 'package:takatrack/screen/budget_screen.dart';
import 'package:takatrack/screen/dashboard_screen.dart';
import 'package:takatrack/screen/main_screen.dart';
import 'package:takatrack/screen/reports_screen.dart';
import 'package:takatrack/screen/savings_goal_screen.dart';
import 'package:takatrack/model/add_transaction.dart';
import 'package:takatrack/screen/transaction_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive and register adapters if necessary
  await Hive.initFlutter(); // Uncomment if using Hive for local storage
  Hive.registerAdapter(AddTransactionAdapter()); // Register your Hive adapters here
  await Hive.openBox<AddTransaction>('transactions'); // Open a box for transactions
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
        '/transactions': (context) => TransactionsScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
