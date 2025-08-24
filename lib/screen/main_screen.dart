import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:takatrack/model/add_transaction.dart';
import 'package:takatrack/screen/add_transaction_screen.dart';
import 'package:takatrack/screen/budget_screen.dart';
import 'package:takatrack/screen/dashboard_screen.dart';
import 'package:takatrack/screen/reports_screen.dart';
import 'package:takatrack/screen/savings_goal_screen.dart';
import 'package:takatrack/screen/transaction_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    TransactionsScreen(),
    BudgetScreen(),
    ReportsScreen(),
    SavingsGoalsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF1C252E),
      unselectedItemColor: const Color(0xFF6C757D),
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      showUnselectedLabels: true,
      elevation: 2.0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_rounded),
          label: 'Transactions',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money_rounded),
          label: 'Budget',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_rounded),
          label: 'Reports',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.emoji_events_rounded),
          label: 'Goals',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
