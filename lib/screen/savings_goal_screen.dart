import 'package:flutter/material.dart';

class SavingsGoalsScreen extends StatelessWidget {
  const SavingsGoalsScreen({super.key});

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
          'Savings Goals',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'My Goals',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212529),
              ),
            ),
            const SizedBox(height: 20),
            // Use Expanded to make the list scrollable and push the button to the bottom
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                children: const [
                  _GoalItem(
                    icon: Icons.laptop_mac,
                    title: 'Laptop',
                    amount: '\$1,200',
                    progress: 0.60, // 60%
                    progressText: '60',
                  ),
                  SizedBox(height: 16),
                  _GoalItem(
                    icon: Icons.airplanemode_active,
                    title: 'Vacation',
                    amount: '\$5,000',
                    progress: 0.25, // 25%
                    progressText: '25',
                  ),
                  SizedBox(height: 16),
                  _GoalItem(
                    icon: Icons.shield_outlined,
                    title: 'Emergency Fund',
                    amount: '\$2,000',
                    progress: 0.80, // 80%
                    progressText: '80',
                  ),
                ],
              ),
            ),
            // The "Add Goal" button is at the bottom
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: _buildAddGoalButton(context),
      
    );
  }

  // The "Add Goal" button widget
  Widget _buildAddGoalButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
      // Handle "Add Goal" action
      Navigator.pushNamed(context, '/addNewGoal');
      },
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text(
      'Add Goal',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      ),
      backgroundColor: const Color(0xFF007BFF),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0,
    );
  }
}

// A reusable widget for displaying a single savings goal item
class _GoalItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String amount;
  final double progress;
  final String progressText;

  const _GoalItem({
    required this.icon,
    required this.title,
    required this.amount,
    required this.progress,
    required this.progressText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          // Icon with a rounded background
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.grey[800], size: 28),
          ),
          const SizedBox(width: 16),
          // Goal title and amount
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF212529),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                amount,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
          const Spacer(), // Pushes the progress bar to the right
          // Progress bar and percentage text
          SizedBox(
            width: 100, // Constrain the width of the progress bar
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            progressText,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
