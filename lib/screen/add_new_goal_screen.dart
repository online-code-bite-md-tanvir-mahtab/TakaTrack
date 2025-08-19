import 'package:flutter/material.dart';

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
            _buildTextField(
              controller: _goalNameController,
              hintText: 'Goal Name (e.g., Buy Laptop)',
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
            const Spacer(), // Pushes the buttons to the bottom
            _buildActionButtons(),
          ],
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
