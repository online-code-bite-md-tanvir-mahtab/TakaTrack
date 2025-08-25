import 'package:flutter/material.dart';
import 'package:takatrack/model/add_goal.dart';
import 'package:takatrack/model/goal.dart';
import 'package:takatrack/model/transaction.dart';
import 'package:takatrack/service/goal_service.dart';
import 'package:takatrack/service/transaction_service.dart';
import 'package:takatrack/widget/goal_item.dart';

// 1. Converted to StatefulWidget
class SavingsGoalsScreen extends StatefulWidget {
  const SavingsGoalsScreen({super.key});

  @override
  State<SavingsGoalsScreen> createState() => _SavingsGoalsScreenState();
}

// 2. State class created to hold the logic and mutable state
class _SavingsGoalsScreenState extends State<SavingsGoalsScreen> {
  // 3. State variables are defined here
  List<Goal> _goals = [];
  bool _isLoading = true;

  // 4. initState is used to fetch data when the widget is first built
  @override
  void initState() {
    super.initState();
    _loadGoals();
  }

  // Helper method to load data and update the state
  Future<void> _loadGoals() async {
    // The fetchGoalData logic is now part of the state
    try {
      final goals = await _fetchGoalData();
      // Use `mounted` check to avoid calling setState on a disposed widget
      if (mounted) {
        // 5. setState triggers a UI rebuild with the new data
        setState(() {
          _goals = goals;
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching goals: $e");
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // All logic methods are now part of the State class
  IconData getGoalCategoryIcon(String category) {
    switch (category) {
      case 'Buy Laptop':
        return Icons.laptop_mac;
      case 'Vacation':
        return Icons.beach_access_outlined;
      case 'Emergency Fund':
        return Icons.warning_amber_outlined;
      case 'New Phone':
        return Icons.phone_android_outlined;
      case 'Other':
        return Icons.more_horiz;
      case 'Car':
        return Icons.directions_car_outlined;
      case 'Home Renovation':
        return Icons.home_repair_service_outlined;
      case 'Wedding':
        return Icons.favorite_border;
      case 'Education':
        return Icons.school_outlined;
      case 'Travel Abroad':
        return Icons.flight_takeoff_outlined;
      case 'Start Business':
        return Icons.business_center_outlined;
      case 'Medical Expenses':
        return Icons.local_hospital_outlined;
      case 'Furniture':
        return Icons.chair_outlined;
      case 'Gadgets':
        return Icons.devices_other_outlined;
      case 'Charity':
        return Icons.volunteer_activism_outlined;
      case 'Investment':
        return Icons.show_chart;
      case 'Retirement':
        return Icons.emoji_people_outlined;
      case 'Children\'s Education':
        return Icons.child_care_outlined;
      case 'Debt Repayment':
        return Icons.payment_outlined;
      case 'Pet Care':
        return Icons.pets_outlined;
      case 'Fitness Equipment':
        return Icons.fitness_center_outlined;
      default:
        return Icons.savings_outlined; // fallback icon
    }
  }

  Future<List<Goal>> _fetchGoalData() async {
  GoalService service = GoalService();
  TransactionService tService = TransactionService();

  // Fetch transactions asynchronously
  final transactions = await tService.getAllTransactions();

  // Calculate total insurance amount
  double allInsurance = 0.0;
  for (var txn in transactions) {
    if (txn.category == 'Insurance') {
      allInsurance += txn.amount;
    }
    print("Transaction Amount: ${txn.amount}, Category: ${txn.category}");
  }

  // Fetch all goals
  List<AddGoal> goals = await service.getAllGoals();
  List<Goal> goalList = [];

  for (var goal in goals) {
    var icon = getGoalCategoryIcon(goal.goalName);

    // Calculate progress percentage
    double progress = goal.targetAmount > 0
        ? (allInsurance / goal.targetAmount).clamp(0.0, 1.0)
        : 0.0;

    goalList.add(
      Goal(
        title: goal.goalName,
        amount: goal.targetAmount, // Format amount as string
        icon: icon,
        progress: progress,
        progressText: "${(progress * 100).toStringAsFixed(1)}%", // percentage
      ),
    );
  }

  return goalList;
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 0,
    );
  }

  // 6. The build method is now inside the State class
  @override
  Widget build(BuildContext context) {
    _loadGoals();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        title: const Text(
          'Savings Goals',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ), // Consistent padding
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
            // 7. UI now handles loading and empty states
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _goals.isEmpty
                  ? const Center(
                      child: Text(
                        'No savings goals yet.\nAdd one to get started!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _goals.length,
                      itemBuilder: (context, index) {
                        final goal = _goals[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: GoalItem(
                            icon: goal.icon,
                            title: goal.title,
                            amount: goal.amount.toString(),
                            progress: goal.progress,
                            progressText: goal.progressText,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildAddGoalButton(context),
    );
  }
}
