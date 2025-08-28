import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:takatrack/viewmodel/report_logic.dart';

// Enum to manage the state of the Monthly/Yearly tabs
enum ReportPeriod { monthly, yearly }

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  ReportPeriod _selectedPeriod = ReportPeriod.monthly;
  int _selectedBottomNavIndex = 3; // Index for 'Reports'
  var _income;
  @override
  void initState() {
    super.initState();
    ReportLogic reportLogic = ReportLogic();
    Map<String, List<dynamic>> months = reportLogic
        .getAllTransactionMonthNames();
    _income = months;
    print("Months with transactions: $_income");
  }

  List<FlSpot> _incomeSpots() {
    List<FlSpot> income = [];
    for (int i = 0; i < _income['monthlyIncome'].length; i++) {
      print("index $i -> ${_income['monthlyIncome'][i]}");
      income.add(
        FlSpot(
          i.toDouble(), // index as double
          _income['monthlyIncome'][i].toDouble(), // convert safely to double
        ),
      );
    }
    return income;
  }

  List<dynamic> _monthlyIncome() {
    List<dynamic> months = [];
    for (var month in _income['monthNames']) {
      print("month: $month");
      months.add(FlSpot(months.length.toDouble(), 0)); // Dummy y-value
    }
    return months;
  }

  // Dummy data for the charts
  // final List<FlSpot> _incomeSpots = const [
  //   FlSpot(0, 3),
  //   FlSpot(1, 4),
  //   FlSpot(2, 2.5),
  //   FlSpot(3, 5),
  //   FlSpot(4, 4),
  // ];
  final List<FlSpot> _expenseSpots = const [
    FlSpot(0, 2),
    FlSpot(1, 3.5),
    FlSpot(2, 2),
    FlSpot(3, 4),
    FlSpot(4, 3),
  ];
  final List<FlSpot> _savingsSpots = const [
    FlSpot(0, 1),
    FlSpot(1, 2),
    FlSpot(2, 1.5),
    FlSpot(3, 3),
    FlSpot(4, 2.5),
  ];
  final List<FlSpot> _breakdownSpots = const [
    FlSpot(0, 3),
    FlSpot(1, 2),
    FlSpot(2, 4),
    FlSpot(3, 3.5),
    FlSpot(4, 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Reports',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPeriodSelector(),
              const SizedBox(height: 24),
              _ReportCard(
                title: 'Income',
                amount: '\$2,500',
                change: '+10%',
                changeColor: Colors.green,
                spots: _incomeSpots(),
                bottomTitles: _monthlyIncome(),
              ),
              const SizedBox(height: 16),
              _ReportCard(
                title: 'Expenses',
                amount: '\$1,800',
                change: '-5%',
                changeColor: Colors.red,
                spots: _expenseSpots,
                bottomTitles: _getMonthlyTitles,
              ),
              const SizedBox(height: 16),
              _ReportCard(
                title: 'Savings',
                amount: '\$700',
                change: '+15%',
                changeColor: Colors.green,
                spots: _savingsSpots,
                bottomTitles: _getMonthlyTitles,
              ),
              const SizedBox(height: 24),
              const Text(
                'Expense Breakdown',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _ReportCard(
                title: 'Expenses',
                amount: '\$1,800',
                subtitle: 'This month',
                spots: _breakdownSpots,
                bottomTitles: _getCategoryTitles,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Builds the Monthly/Yearly tab selector
  Widget _buildPeriodSelector() {
    return Row(
      children: [
        _buildPeriodTab('Monthly', ReportPeriod.monthly),
        const SizedBox(width: 24),
        _buildPeriodTab('Yearly', ReportPeriod.yearly),
      ],
    );
  }

  // Helper widget for a single tab
  Widget _buildPeriodTab(String title, ReportPeriod period) {
    bool isSelected = _selectedPeriod == period;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPeriod = period;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          if (isSelected) Container(height: 2, width: 30, color: Colors.black),
        ],
      ),
    );
  }

  // --- Chart Title Helper Methods ---

  static Widget _getMonthlyTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.grey, fontSize: 12);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jan';
        break;
      case 6:
        text = 'Feb';
        break;
      case 7:
        text = 'Mar';
        break;
      case 8:
        text = 'Apr';
        break;
      case 9:
        text = 'May';
        break;
      default:
        return Container();
    }
    return SideTitleWidget(
      meta: meta,
      space: 8,
      child: Text(text, style: style),
    );
  }

  static Widget _getCategoryTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.grey, fontSize: 12);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Food';
        break;
      case 1:
        text = 'Rent';
        break;
      case 2:
        text = 'Utilities';
        break;
      case 3:
        text = 'Entmt';
        break;
      case 4:
        text = 'Other';
        break;
      default:
        return Container();
    }
    return SideTitleWidget(
      meta: meta,
      space: 8,
      child: Text(text, style: style),
    );
  }
}

// A reusable card widget for displaying report data and a chart
class _ReportCard extends StatelessWidget {
  final String title;
  final String amount;
  final String? change;
  final String? subtitle;
  final Color? changeColor;
  final List<FlSpot> spots;
  final Widget Function(double, TitleMeta) bottomTitles;

  const _ReportCard({
    required this.title,
    required this.amount,
    this.change,
    this.subtitle,
    this.changeColor,
    required this.spots,
    required this.bottomTitles,
  });

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
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          const SizedBox(height: 8),
          Text(
            amount,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          if (change != null && changeColor != null)
            Row(
              children: [
                Text(
                  'This month ',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                Text(
                  change!,
                  style: TextStyle(
                    color: changeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            )
          else if (subtitle != null)
            Text(
              subtitle!,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          const SizedBox(height: 20),
          SizedBox(
            height: 100,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
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
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: bottomTitles,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: Colors.black87,
                    barWidth: 2.5,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
