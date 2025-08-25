import 'package:hive/hive.dart';
import 'package:takatrack/model/add_transaction.dart';

class TransactionService {
  // inisializing the database
  final Box<AddTransaction> _transactionBox = Hive.box<AddTransaction>(
    "transactions",
  );

  // insert

  List<AddTransaction> getAllTransactions() {
    return _transactionBox.values.toList();
  }

  Future<void> addTransaction(AddTransaction transaction) async {
    await _transactionBox.put(transaction.id, transaction);
  }

  Future<void> deleteTransaction(String id) async {
    await _transactionBox.delete(id);
  }

  AddTransaction? getTransaction(String id) {
    return _transactionBox.get(id);
  }

  Future<void> updateTransaction(AddTransaction transaction) async {
    await _transactionBox.put(transaction.id, transaction);
  }
}
