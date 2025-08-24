import 'package:flutter/material.dart';
import 'package:takatrack/model/add_transaction.dart';
import 'package:takatrack/model/transaction.dart';
import 'package:takatrack/service/transaction_service.dart';

// A model class to represent a single transaction.
// This makes the code cleaner and easier to manage

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  // Builds the custom app bar at the top of the card
  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
      child: Center(
        child: Text(
          'Transactions',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
      ),
    );
  }

  List<Transaction> _transactions = [];

  Future<List<Transaction>> fetchTransData() async{
    TransactionService service = TransactionService();
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
        Transaction(icon: icon, category: category, date: date, amount: amount, isIncome: element.isIncome),
      );
    }
    return transactions;
  }

  @override
  void initState() {
    super.initState();
    fetchTransData().then((value) {
      setState(() =>
      _transactions = value);
    });
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

  // Builds a single row in the transaction list
  Widget _buildTransactionItem(Transaction transaction) {
    final Color amountColor = transaction.isIncome
        ? const Color(0xFF2E8B57)
        : const Color(0xFF333333);
    final String amountString =
        '${transaction.isIncome ? '+' : '-'}\$${transaction.amount.abs().toStringAsFixed(2)}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F7),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(
              transaction.icon,
              size: 24,
              color: const Color(0xFF555555),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.category,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  transaction.date,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            amountString,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    fetchTransData().then((value) {
      setState(() =>
      _transactions = value);
    });
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      body: SafeArea(
      child: _transactions.isEmpty
        ? const Center(
          child: CircularProgressIndicator(),
          )
        : _transactions.isEmpty
          ? const Center(
            child: Text(
              'No transactions available.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            )
          : Column(
            children: [
              Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 20.0),
                decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.0),
                ),
                ),
                child: Column(
                children: [
                  _buildAppBar(),
                  Expanded(
                  child: ListView.builder(
                    itemCount: _transactions.length,
                    itemBuilder: (context, index) {
                    return _buildTransactionItem(
                      _transactions[index],
                    );
                    },
                  ),
                  ),
                ],
                ),
              ),
              ),
            ],
            ),
      ),
      floatingActionButton: _buildAddGoalButton(context),
    );
  }

  Widget _buildAddGoalButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.pushNamed(context, '/addTransaction');
      },
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text(
        'Add Transaction',
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
}
