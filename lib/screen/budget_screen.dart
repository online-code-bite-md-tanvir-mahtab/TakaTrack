import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  // Set the current index to 2 to highlight the "Budget" tab
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back navigation
          },
        ),
        title: const Text(
          'Budget',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSpendingPlan(),
              const SizedBox(height: 30),
              _buildBudgetBreakdown(),
              const SizedBox(height: 40),
              _buildSuggestions(),
              const SizedBox(height: 40),
              _buildTipsSection(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Builds the top section: Spending Plan and Monthly Budget
  Widget _buildSpendingPlan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Spending Plan',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212529),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Here's a breakdown of your recommended spending limits for the month.",
          style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.5),
        ),
        const SizedBox(height: 30),
        const Text(
          'Monthly Budget',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF6C757D),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '\$2,500',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212529),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'This Month',
          style: TextStyle(fontSize: 16, color: Colors.grey[500]),
        ),
      ],
    );
  }

  // Builds the simple bar chart for budget breakdown
  Widget _buildBudgetBreakdown() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _BudgetBar(label: 'Needs', height: 40),
        _BudgetBar(label: 'Wants', height: 80),
        _BudgetBar(label: 'Savings', height: 60),
      ],
    );
  }

  // Builds the Spending Suggestions section
  Widget _buildSuggestions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Spending Suggestions',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212529),
          ),
        ),
        const SizedBox(height: 20),
        _buildSuggestionItem(
          icon: Icons.home_outlined,
          title: 'Needs',
          subtitle:
              'Allocate funds for essential expenses like rent, utilities, and groceries.',
        ),
        const SizedBox(height: 20),
        _buildSuggestionItem(
          icon: Icons.wallet_giftcard,
          title: 'Wants',
          subtitle:
              'Set aside funds for discretionary spending such as entertainment and dining out.',
        ),
        const SizedBox(height: 20),
        _buildSuggestionItem(
          icon: Icons.savings_outlined,
          title: 'Savings',
          subtitle:
              'Prioritize saving a portion of your income for future goals and financial security.',
        ),
      ],
    );
  }

  // Reusable widget for suggestion items
  Widget _buildSuggestionItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.grey[800], size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212529),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Builds the final tips section at the bottom
  Widget _buildTipsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tips',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212529),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Review your spending habits regularly and adjust your budget as needed to stay on track. Consider automating savings to ensure consistent progress towards your financial goals.',
          style: TextStyle(fontSize: 15, color: Colors.grey[600], height: 1.5),
        ),
      ],
    );
  }
}

// A simple custom widget for the bars in the budget breakdown
class _BudgetBar extends StatelessWidget {
  final String label;
  final double height;

  const _BudgetBar({required this.label, required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
            border: Border(
              top: BorderSide(color: Colors.grey[400]!, width: 2.5),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }
}
