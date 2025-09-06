// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:takatrack/model/add_transaction.dart';
import 'package:takatrack/model/transaction.dart';
import 'package:takatrack/screen/transaction_screen.dart';
import 'package:takatrack/service/transaction_service.dart';
import 'package:takatrack/utils/util.dart';
// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

// Enum to manage the state of the transaction type selector
enum TransactionType { income, expense }

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  // State variables for the form
  TransactionType _selectedType = TransactionType.expense;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;
  DateTime? _selectedDate;

  late AddTransaction _transaction;
  late double _amount;
  late DateTime _date;
  late String _description;
  late String _category;
  late String _note;
  late String _status;

  Util util = Util();
  final service = TransactionService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is AddTransaction) {
      _transaction = args;
    } else {
      // If no arguments are passed, initialize with default values
      _transaction = AddTransaction(
        id: '',
        amount: 0.0,
        category: '',
        date: DateTime.now(),
        note: '',
        isIncome: false,
        status: 'expense',
      );
    }
    final service = TransactionService();
    AddTransaction? trans = service.getTransactionById(_transaction.id);

    if (trans != null) {
      _amount = trans.amount;
      _date = trans.date;
      _description = trans.note;
      _category = trans.category;
      _note = trans.note;
      _status = trans.status;

      // Set input fields
      _amountController.text = _amount.toString();
      _dateController.text =
          "${_date.year}-${_date.month.toString().padLeft(2, '0')}-${_date.day.toString().padLeft(2, '0')}";
      _descriptionController.text = _description;
      _selectedCategory = _category;
      _selectedDate = _date;
      _selectedType = _status == "income"
          ? TransactionType.income
          : TransactionType.expense;
    } else {
      // Handle the case where transaction is not found,
      // perhaps navigate back or show an error.
      _amount = 0.0;
      _date = DateTime.now();
      _description = "";
      _category = "";
      _note = "";
      _status = "expense";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            // Handle close action
            List<AddTransaction> trans = service.getAllTransactions();
            List<Transaction> transactions = [];
            // now looping to the trans
            for (var element in trans) {
              var icon = getCategoryIcon(element.category);
              var category = element.category;
              var date =
                  "${element.date.year}-${element.date.month}-${element.date.day}";
              var amount = element.amount;
              transactions.add(
                Transaction(
                  id: element.id,
                  icon: icon,
                  category: category,
                  date: date,
                  amount: amount,
                ),
              );
            }
            print(transactions.length);
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Add Transaction',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTransactionTypeSelector(),
              const SizedBox(height: 24),
              _buildTextField(controller: _amountController, hint: 'Amount'),
              const SizedBox(height: 16),
              _buildCategorySelector(),
              const SizedBox(height: 16),
              _buildDateField(),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _descriptionController,
                hint: 'Description (optional)',
                maxLines: 4,
              ),
              const SizedBox(height: 40),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  // Custom widget for the Income/Expense selector
  Widget _buildTransactionTypeSelector() {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Expanded(child: _buildTypeButton('Income', TransactionType.income)),
          Expanded(child: _buildTypeButton('Expense', TransactionType.expense)),
        ],
      ),
    );
  }

  // Helper for the selector buttons
  Widget _buildTypeButton(String title, TransactionType type) {
    bool isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = type;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // Reusable text field widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
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

  void _showCategorySelector() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: util.categories.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(util.categories[index]),
              onTap: () {
                setState(() {
                  _selectedCategory = util.categories[index];
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  // A tappable field that looks like a text field for category selection
  Widget _buildCategorySelector() {
    return InkWell(
      onTap: () {
        _showCategorySelector();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedCategory ?? 'Select Category',
              style: TextStyle(
                color: _selectedCategory == null
                    ? Colors.grey[500]
                    : Colors.black,
                fontSize: 16,
              ),
            ),
            Icon(Icons.unfold_more, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  // A read-only text field that shows a date picker on tap
  Widget _buildDateField() {
    return TextField(
      controller: _dateController,
      readOnly: true,
      decoration: InputDecoration(
        hintText: 'Date',
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
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
            _dateController.text = "${pickedDate.toLocal()}".split(
              ' ',
            )[0]; // Format as YYYY-MM-DD
          });
        }
      },
    );
  }

  IconData getCategoryIcon(String category) {
    switch (category) {
      case 'Groceries':
        return Icons.shopping_cart_outlined;
      case 'Salary':
        return Icons.attach_money;
      case 'Rent':
        return Icons.home_outlined;
      case 'Dining Out':
        return Icons.restaurant_outlined;
      case 'Utilities':
        return Icons.lightbulb_outline;
      case 'Transportation':
        return Icons.directions_bus_outlined;
      case 'Entertainment':
        return Icons.movie_outlined;
      case 'Shopping':
        return Icons.shopping_bag_outlined;
      case 'Bonus':
        return Icons.card_giftcard;
      case 'Insurance':
        return Icons.shield_outlined;
      case 'Loan Payments':
        return Icons.payment_outlined;
      case 'Investments':
        return Icons.show_chart;
      case 'Education':
        return Icons.school_outlined;
      case 'Travel':
        return Icons.flight_takeoff_outlined;
      case 'Clothing':
        return Icons.checkroom_outlined;
      case 'Personal Care':
        return Icons.favorite_border;
      case 'Gifts':
        return Icons.redeem;
      case 'Dividends':
        return Icons.pie_chart_outline;
      case 'Rental Income':
        return Icons.real_estate_agent_outlined;
      default:
        return Icons.category; // fallback icon
    }
  }

  // The final save button at the bottom of the screen
  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        // Handle save action
        setState(() {
          if (_transaction.id.isEmpty) {
            service.addTransaction(
              AddTransaction(
                amount: double.parse(_amountController.text),
                category: _selectedCategory.toString(),
                date: DateTime(
                  int.parse(_dateController.text.split("-")[0]),
                  int.parse(_dateController.text.split("-")[1]),
                  int.parse(_dateController.text.split("-")[2]),
                ),
                note: _descriptionController.text,
                isIncome: _selectedType == TransactionType.income
                    ? true
                    : false,
                status: _selectedType.name,
              ),
            );
          } else {
            service.updateTransaction(
              AddTransaction(
                id: _transaction.id,
                amount: double.parse(_amountController.text),
                category: _selectedCategory.toString(),
                date: DateTime(
                  int.parse(_dateController.text.split("-")[0]),
                  int.parse(_dateController.text.split("-")[1]),
                  int.parse(_dateController.text.split("-")[2]),
                ),
                note: _descriptionController.text,
                isIncome: _selectedType == TransactionType.income
                    ? true
                    : false,
                status: _selectedType.name,
              ),
            );
          }
        });
        List<AddTransaction> trans = service.getAllTransactions();
        List<Transaction> transactions = [];
        // now looping to the trans
        for (var element in trans) {
          var icon = getCategoryIcon(element.category);
          var category = element.category;
          var date =
              "${element.date.year}-${element.date.month}-${element.date.day}";
          var amount = element.amount;
          transactions.add(
            Transaction(
              id: element.id,
              icon: icon,
              category: category,
              date: date,
              amount: amount,
            ),
          );
        }
        Navigator.pop(context, transactions);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF007BFF),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 0,
      ),
      child: const Text(
        'Save',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
