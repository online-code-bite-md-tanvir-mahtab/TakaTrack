import 'package:hive/hive.dart';
import 'package:takatrack/model/add_transaction.dart';

class TransactionService {
  // inisializing the database
  final Box<AddTransaction> _transactionBox = Hive.box<AddTransaction>(
    "transactions",
  );

  // insert

  List<AddTransaction> getAllTransactions() {
    final transactions = _transactionBox.values.toList();
    transactions.sort((a, b) => b.date.compareTo(a.date));
    return transactions;
  }

  AddTransaction? getTransactionById(String id) {
    return _transactionBox.get(id);
  }

  Future<void> addTransaction(AddTransaction transaction) async {
    await _transactionBox.put(transaction.id, transaction);
  }

  Future<void> deleteTransaction(String id) async {
    final transaction = _transactionBox.get(id);
    if (transaction != null) {
      // This code only updates the transaction status before deleting.
      // It does NOT affect any bank balance directly.
      transaction.status = 'income'; // or whatever status you want
      await _transactionBox.put(id, transaction);
    }
    await _transactionBox.delete(id);
  }

  AddTransaction? getTransaction(String id) {
    return _transactionBox.get(id);
  }

  Future<void> updateTransaction(AddTransaction transaction) async {
    await _transactionBox.put(transaction.id, transaction);
  }
}
