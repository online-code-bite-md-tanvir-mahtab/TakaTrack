import 'package:flutter/material.dart';
import 'package:takatrack/model/add_goal.dart';
import 'package:takatrack/model/goal.dart';
import 'package:takatrack/service/goal_service.dart';

class AddNewGoalScreen extends StatefulWidget {
  const AddNewGoalScreen({super.key});

  @override
  State<AddNewGoalScreen> createState() => _AddNewGoalScreenState();
}

class _AddNewGoalScreenState extends State<AddNewGoalScreen> {
  // Controllers to manage the text in the input fields
  final TextEditingController _goalNameController = TextEditingController();
  final TextEditingController _targetAmountController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  DateTime? _selectedDate;

  final service = GoalService();

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

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _goalNameController.dispose();
    _targetAmountController.dispose();
    _deadlineController.dispose();
    _notesController.dispose();
    super.dispose();
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
            // print("backing");
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Savings Goals',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Goal',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212529),
                ),
              ),
              const SizedBox(height: 30),
              DropdownButtonFormField<String>(
                value: _goalNameController.text.isEmpty
                    ? null
                    : _goalNameController.text,
                decoration: InputDecoration(
                  hintText: 'Goal Name (e.g., Buy Laptop)',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                ),
                items:
                    [
                          'Buy Laptop',
                          'Vacation',
                          'Emergency Fund',
                          'New Phone',
                          'Other',
                          'Car',
                          'Home Renovation',
                          'Wedding',
                          'Education',
                          'Travel Abroad',
                          'Start Business',
                          'Medical Expenses',
                          'Furniture',
                          'Gadgets',
                          'Charity',
                          'Investment',
                          'Retirement',
                          'Children\'s Education',
                          'Debt Repayment',
                          'Pet Care',
                          'Fitness Equipment',
                        ]
                        .map(
                          (goal) =>
                              DropdownMenuItem(value: goal, child: Text(goal)),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _goalNameController.text = value ?? '';
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _targetAmountController,
                hintText: 'Target Amount (e.g., 50,000 BDT)',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildDateField(),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _notesController,
                hintText: 'Notes (Optional)',
                maxLines: 4,
              ),
              const SizedBox(height: 24),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  // A reusable text field widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
      ),
    );
  }

  // A read-only text field that shows a date picker on tap
  Widget _buildDateField() {
    return TextField(
      controller: _deadlineController,
      readOnly: true,
      decoration: InputDecoration(
        hintText: 'Deadline (Optional)',
        hintStyle: TextStyle(color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.grey[200],
        suffixIcon: Icon(
          Icons.calendar_today_outlined,
          color: Colors.grey[600],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
            // Format the date as you like, e.g., 'yyyy-MM-dd'
            _deadlineController.text = "${pickedDate.toLocal()}".split(' ')[0];
          });
        }
      },
    );
  }

  // The row containing the Cancel and Save Goal buttons
  Widget _buildActionButtons() {
    return Row(
      children: [
        // Cancel Button
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Handle cancel action
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[200],
              foregroundColor: Colors.black,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Save Goal Button
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Handle save action
              setState(() {
                service.addGoal(
                  AddGoal(
                    goalName: _goalNameController.text,
                    goalDescription: _notesController.text,
                    targetDate: DateTime(
                      _selectedDate!.year,
                      _selectedDate!.month,
                      _selectedDate!.day,
                    ),
                    targetAmount: double.parse(_targetAmountController.text),
                  ),
                );
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007BFF),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: const Text(
              'Save Goal',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
