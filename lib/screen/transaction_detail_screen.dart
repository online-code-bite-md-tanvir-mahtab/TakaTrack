import 'package:flutter/material.dart';
import 'package:takatrack/model/add_transaction.dart';
import 'package:takatrack/service/transaction_service.dart';

class TransactionDetailsScreen extends StatefulWidget {
  const TransactionDetailsScreen({super.key});

  @override
  State<TransactionDetailsScreen> createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  late AddTransaction _transaction;
  late double _amount;
  late DateTime _date;
  late String _description;
  late String _category;
  late String _note;
  late String _status;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _transaction =
        ModalRoute.of(context)!.settings.arguments as AddTransaction;
    final service = TransactionService();
    AddTransaction? trans = service.getTransactionById(_transaction.id);

    if (trans != null) {
      _amount = trans.amount;
      _date = trans.date;
      _description = trans.note;
      _category = trans.category;
      _note = trans.note;
      _status = trans.status;

    } else {
      // Handle the case where transaction is not found,
      // perhaps navigate back or show an error.
      _amount = 0.0;
      _date = "N/A" as DateTime;
      _description = "N/A";
      _category = "N/A";
      _note = "N/A";
      _status = "N/A";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back button press
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Transaction Details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100], // Light background for the screen
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Amount Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _category,
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${_amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Details Section
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _DetailRow(
                            label: 'Amount', value: '\$${_amount.toStringAsFixed(2)}'),
                        const Divider(height: 24, thickness: 0.5),
                        _DetailRow(
                          label: 'Date & Time',
                          value:
                              '${_date.month}/${_date.day}/${_date.year}, ${_date.hour}:${_date.minute}',
                        ),
                        const Divider(height: 24, thickness: 0.5),
                        _DetailRow(label: 'Description', value: _description.isEmpty ? 'N/A' : _description ),
                        const Divider(height: 24, thickness: 0.5),
                        _DetailRow(label: 'Status', value: _status),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Spending Insights Section
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.0),
                    child: Text(
                      'Spending Insights',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _InsightRow(
                          label: 'Average Spending',
                          subLabel: 'Last Month',
                          value: '\$110',
                        ),
                        const Divider(height: 24, thickness: 0.5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Budget Comparison',
                              style: TextStyle(fontSize: 16),
                            ),
                            const Text(
                              'Remaining Budget',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: 0.75, // Example progress value
                              backgroundColor: const Color(0xFFE9ECEF),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF1C252E),
                              ),
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(top: 4.0),
                                child: Text(
                                  '75', // Assuming this is a percentage or remaining value
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom Buttons
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Handle Edit button
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Edit',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Delete button
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Delete',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class _InsightRow extends StatelessWidget {
  final String label;
  final String subLabel;
  final String value;

  const _InsightRow({
    required this.label,
    required this.subLabel,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              Text(
                subLabel,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}