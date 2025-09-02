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
  ReportPeriod _selectedPeriod = ReportPeriod.yearly;
  int _selectedBottomNavIndex = 3; // Index for 'Reports'
  var _income;
  var _expenses;
  var _savings;
  var _expense_details;
  @override
  void initState() {
    super.initState();
    // TODO: this is for the monthly with date
    if (_selectedPeriod == ReportPeriod.monthly) {
      print("monthly selected");
      _loadMonthlyData();
    }else{
      _loadYealyData();
    }
  }

  void _loadMonthlyData() {
    ReportLogic reportLogic = ReportLogic();
    Map<String, List<dynamic>> onlyMonths = reportLogic
        .getAllTransactionMonthWithDate();
    _income = onlyMonths;
    Map<String, List<dynamic>> onlyExpMonths = reportLogic
        .getAllExpansesMonthWithday();
    _expenses = onlyExpMonths;
    Map<String, List<dynamic>> onlySavMonths = reportLogic
        .getAllSavingMonthbyDay();
    _savings = onlySavMonths;
    Map<String, List<dynamic>> onlyExpDetails = reportLogic
        .getAllExpenseBrackdownMonthWithday();
    _expense_details = onlyExpDetails;
    print("Months with transactions: $onlyExpDetails");
  }

  void _loadYealyData(){
    ReportLogic reportLogic = ReportLogic();
    Map<String, List<dynamic>> months = reportLogic
        .getAllTransactionMonthNames();
    _income = months;
    Map<String, List<dynamic>> expMonths = reportLogic
        .getAllExpansesMonthNames();
    _expenses = expMonths;
    Map<String, List<dynamic>> savMonths = reportLogic.getAllSavingMonthNames();
    _savings = savMonths;

    Map<String, List<dynamic>> expDetails = reportLogic
        .getAllExpenseBrackdownMonthNames();
    _expense_details = expDetails;
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

  Map<String, dynamic> _getTotalYearlyIncome() {
    double total = 0;
    double percent = 0;
    List<dynamic> monthlyIncome = _income['monthlyIncome'] ?? [];
    for (var amount in monthlyIncome) {
      total += amount;
    }
    if (monthlyIncome.length > 1 &&
        monthlyIncome[monthlyIncome.length - 2] != 0) {
      double lastMonth = monthlyIncome[monthlyIncome.length - 1];
      double prevMonth = monthlyIncome[monthlyIncome.length - 2];
      percent = ((lastMonth - prevMonth) / prevMonth) * 100;
    }
    return {'total': total, 'percent': percent};
  }

  List<String> _monthlyLabels() {
    // If _income['monthlyIncome'] is a list of numbers, use month names from _income['months']
    // If it's a list of maps with 'date', extract month/year from each entry
    if (_income != null && _income['monthNames'] != null) {
      return List<String>.from(_income['monthNames']);
    }
    return [];
  }

  Widget _getDynamicMonthlyTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.grey, fontSize: 12);
    final labels = _monthlyLabels();
    String text = (value.toInt() >= 0 && value.toInt() < labels.length)
        ? labels[value.toInt()]
        : 'null';
    return SideTitleWidget(
      meta: meta,
      space: 8,
      child: Text(text, style: style),
    );
  }

  List<FlSpot> _expanseSpots() {
    List<FlSpot> expenses = [];
    for (int i = 0; i < _expenses['monthlyExpenses'].length; i++) {
      print("index $i -> ${_expenses['monthlyExpenses'][i]}");
      expenses.add(
        FlSpot(
          i.toDouble(), // index as double
          _expenses['monthlyExpenses'][i]
              .toDouble(), // convert safely to double
        ),
      );
    }
    return expenses;
  }

  Map<String, dynamic> _getTotalYearlyExpense() {
    double total = 0;
    double percent = 0;
    List<dynamic> monthlyIncome = _expenses['monthlyExpenses'] ?? [];
    for (var amount in monthlyIncome) {
      total += amount;
    }
    if (monthlyIncome.length > 1 &&
        monthlyIncome[monthlyIncome.length - 2] != 0) {
      double lastMonth = monthlyIncome[monthlyIncome.length - 1];
      double prevMonth = monthlyIncome[monthlyIncome.length - 2];
      percent = ((lastMonth - prevMonth) / prevMonth) * 100;
    }
    return {'total': total, 'percent': percent};
  }

  List<String> _monthlyLabels2() {
    // If _income['monthlyIncome'] is a list of numbers, use month names from _income['months']
    // If it's a list of maps with 'date', extract month/year from each entry
    if (_expenses != null && _expenses['monthNames'] != null) {
      return List<String>.from(_expenses['monthNames']);
    }
    return [];
  }

  Widget _getDynamicMonthlyTitles2(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.grey, fontSize: 12);
    final labels = _monthlyLabels2();
    String text = (value.toInt() >= 0 && value.toInt() < labels.length)
        ? labels[value.toInt()]
        : 'null';
    return SideTitleWidget(
      meta: meta,
      space: 8,
      child: Text(text, style: style),
    );
  }

  List<FlSpot> _savingSpots() {
    List<FlSpot> expenses = [];
    for (int i = 0; i < _savings['monthlyExpenses'].length; i++) {
      print("index $i -> ${_savings['monthlyExpenses'][i]}");
      expenses.add(
        FlSpot(
          i.toDouble(), // index as double
          _savings['monthlyExpenses'][i].toDouble(), // convert safely to double
        ),
      );
    }
    return expenses;
  }

  Map<String, dynamic> _getTotalYearlySavings() {
    double total = 0;
    double percent = 0;
    List<dynamic> monthlyIncome = _savings['monthlyExpenses'] ?? [];
    for (var amount in monthlyIncome) {
      total += amount;
    }
    if (monthlyIncome.length > 1 &&
        monthlyIncome[monthlyIncome.length - 2] != 0) {
      double lastMonth = monthlyIncome[monthlyIncome.length - 1];
      double prevMonth = monthlyIncome[monthlyIncome.length - 2];
      percent = ((lastMonth - prevMonth) / prevMonth) * 100;
    }
    return {'total': total, 'percent': percent};
  }

  List<String> _monthlyLabels3() {
    // If _income['monthlyIncome'] is a list of numbers, use month names from _income['months']
    // If it's a list of maps with 'date', extract month/year from each entry
    if (_savings != null && _savings['monthNames'] != null) {
      return List<String>.from(_savings['monthNames']);
    }
    return [];
  }

  Widget _getDynamicMonthlyTitles3(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.grey, fontSize: 12);
    final labels = _monthlyLabels3();
    String text = (value.toInt() >= 0 && value.toInt() < labels.length)
        ? labels[value.toInt()]
        : 'null';
    return SideTitleWidget(
      meta: meta,
      space: 8,
      child: Text(text, style: style),
    );
  }

  List<FlSpot> _brackDownSpots() {
    List<FlSpot> expenses = [];
    for (int i = 0; i < _expense_details['categoryExpenses'].length; i++) {
      print("index $i -> ${_expense_details['categoryExpenses'][i]}");
      expenses.add(
        FlSpot(
          i.toDouble(), // index as double
          _expense_details['categoryExpenses'][i]
              .toDouble(), // convert safely to double
        ),
      );
    }
    return expenses;
  }

  Map<String, dynamic> _getTotalYearlyBreakdown() {
    double total = 0;
    double percent = 0;
    List<dynamic> monthlyIncome = _expense_details['categoryExpenses'] ?? [];
    for (var amount in monthlyIncome) {
      total += amount;
    }
    if (monthlyIncome.length > 1 &&
        monthlyIncome[monthlyIncome.length - 2] != 0) {
      double lastMonth = monthlyIncome[monthlyIncome.length - 1];
      double prevMonth = monthlyIncome[monthlyIncome.length - 2];
      percent = ((lastMonth - prevMonth) / prevMonth) * 100;
    }
    return {'total': total, 'percent': percent};
  }

  List<String> _monthlyLabels4() {
    // If _income['monthlyIncome'] is a list of numbers, use month names from _income['months']
    // If it's a list of maps with 'date', extract month/year from each entry
    if (_savings != null && _expense_details['categoryNames'] != null) {
      return List<String>.from(_expense_details['categoryNames']);
    }
    return [];
  }

  Widget _getDynamicMonthlyTitles4(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.grey, fontSize: 12);
    final labels = _monthlyLabels4();
    String text = (value.toInt() >= 0 && value.toInt() < labels.length)
        ? labels[value.toInt()]
        : 'null';
    return SideTitleWidget(
      meta: meta,
      space: 8,
      child: Text(text, style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedPeriod == ReportPeriod.monthly) {
      print("monthly selected");
      setState(() {
        _loadMonthlyData();
      });
    }else{
      setState(() {
        _loadYealyData();
      });
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
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
                amount:
                    '\$${_getTotalYearlyIncome()['total'].toStringAsFixed(1)}',
                change:
                    '${_getTotalYearlyIncome()['percent'].toStringAsFixed(1)}%',
                changeColor: _getTotalYearlyIncome()['percent'] >= 0
                    ? Colors.green
                    : Colors.red,
                spots: _incomeSpots(),
                monthoryear: _selectedPeriod == ReportPeriod.monthly
                    ? 'month'
                    : 'year',
                bottomTitles: _getDynamicMonthlyTitles,
              ),
              const SizedBox(height: 16),
              _ReportCard(
                title: 'Expenses',
                amount:
                    '\$${_getTotalYearlyExpense()['total'].toStringAsFixed(1)}',
                change:
                    '${_getTotalYearlyExpense()['percent'].toStringAsFixed(1)}%',
                changeColor: _getTotalYearlyExpense()['percent'] >= 0
                    ? Colors.green
                    : Colors.red,
                spots: _expanseSpots(),
                monthoryear: _selectedPeriod == ReportPeriod.monthly
                    ? 'month'
                    : 'year',
                bottomTitles: _getDynamicMonthlyTitles2,
              ),
              const SizedBox(height: 16),
              _ReportCard(
                title: 'Savings',
                amount:
                    '\$${_getTotalYearlySavings()['total'].toStringAsFixed(1)}',
                change:
                    '${_getTotalYearlySavings()['percent'].toStringAsFixed(1)}%',
                changeColor: _getTotalYearlySavings()['percent'] >= 0
                    ? Colors.green
                    : Colors.red,
                spots: _savingSpots(),
                monthoryear: _selectedPeriod == ReportPeriod.monthly
                    ? 'month'
                    : 'year',
                bottomTitles: _getDynamicMonthlyTitles3,
              ),
              const SizedBox(height: 24),
              const Text(
                'Expense Breakdown',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _ReportCard(
                title: 'Expenses',
                amount:
                    '\$${_getTotalYearlyBreakdown()['total'].toStringAsFixed(1)}',
                subtitle:
                    'This ${_selectedPeriod == ReportPeriod.monthly ? 'month' : 'year'}',
                spots: _brackDownSpots(),
                monthoryear: _selectedPeriod == ReportPeriod.monthly
                    ? 'month'
                    : 'year',
                bottomTitles: _getDynamicMonthlyTitles4,
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
    print("the period is $period and selected is $_selectedPeriod");
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
    print("the value is $value");
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
  final String? monthoryear;
  final Widget Function(double, TitleMeta) bottomTitles;

  const _ReportCard({
    required this.title,
    required this.amount,
    this.change,
    this.subtitle,
    this.changeColor,
    required this.spots,
    required this.monthoryear,
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
                  'This ${monthoryear} ',
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
