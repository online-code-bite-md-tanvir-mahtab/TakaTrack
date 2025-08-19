import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// Converted to a StatefulWidget
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Tracks the currently selected item in the bottom navigation bar
  int _selectedIndex = 0;

  // Handles tap events on the bottom navigation bar items
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      // The top app bar with the title and settings icon
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Color(0xFF1C252E),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFF495057)),
            onPressed: () {
              // Action for settings button
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // The main content of the screen
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileSection(),
              const SizedBox(height: 24),
              _buildSummaryCards(),
              const SizedBox(height: 32),
              _buildSavingsProgress(),
              const SizedBox(height: 32),
              const Text(
                'Income vs. Expenses',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1C252E),
                ),
              ),
              const SizedBox(height: 16),
              _buildChart(),
            ],
          ),
        ),
      ),
    );
  }

  // Builds the user profile section
  Widget _buildProfileSection() {
    return const Row(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(
            'https://i.pravatar.cc/150?img=12',
          ), // Placeholder image
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ethan Carter',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C252E),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Welcome back',
              style: TextStyle(fontSize: 16, color: Color(0xFF6C757D)),
            ),
          ],
        ),
      ],
    );
  }

  // Builds the grid of financial summary cards
  Widget _buildSummaryCards() {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _SummaryCard(title: 'Total Income', amount: '\$12,500'),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _SummaryCard(title: 'Total Expenses', amount: '\$4,200'),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _SummaryCard(title: 'Current Savings', amount: '\$8,300'),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _SummaryCard(title: 'Bank Balance', amount: '\$15,750'),
            ),
          ],
        ),
      ],
    );
  }

  // Builds the savings progress bar section
  Widget _buildSavingsProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Savings Progress',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1C252E),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '66%',
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF6C757D),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: 0.66,
          backgroundColor: const Color(0xFFE9ECEF),
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1C252E)),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  // Builds the bar chart for income vs. expenses
  Widget _buildChart() {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 20,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getBottomTitles,
                reservedSize: 38,
              ),
            ),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            makeGroupData(0, 5),
            makeGroupData(1, 16.5),
            makeGroupData(2, 10),
            makeGroupData(3, 11),
            makeGroupData(4, 19),
            makeGroupData(5, 15),
          ],
        ),
      ),
    );
  }

  // Helper function to create data for each bar in the chart
  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: const Color(0xFFE9ECEF),
          width: 20,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),
      ],
    );
  }

  // Helper function to create the labels for the bottom axis of the chart
  static Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xFF6C757D),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    // List of month abbreviations
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    String text = '';
    if (value.toInt() >= 0 && value.toInt() < months.length) {
      text = months[value.toInt()];
    }

    return SideTitleWidget(
      meta: meta,
      space: 8, // reduce space a bit for better fit
      child: Text(text, style: style),
    );
  }

  // Builds the bottom navigation bar
}

// A reusable widget for the summary cards
class _SummaryCard extends StatelessWidget {
  final String title;
  final String amount;

  const _SummaryCard({required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Color(0xFF6C757D)),
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1C252E),
            ),
          ),
        ],
      ),
    );
  }
}
