import 'package:takatrack/model/add_transaction.dart';
import 'package:takatrack/service/goal_service.dart';
import 'package:takatrack/service/transaction_service.dart';

class ReportLogic {
  TransactionService service = TransactionService();
  GoalService goalService = GoalService();

  Map<String,List<dynamic>> getAllTransactionMonthNames() {
    List<AddTransaction> allTrans = service.getAllTransactions();
    Set<int> uniqueMonths = {};

    for (var trans in allTrans) {
      uniqueMonths.add(trans.date.month);
      if (trans.status == 'income') {
        // Assuming recurring transactions happen monthly for simplicity
        for (int i = 1; i <= 12; i++) {
          uniqueMonths.add(i);
        }
      }
    }
    List<String> monthNames = uniqueMonths.map((month) {
      return _monthName(month);
    }).toList();

    // Calculate monthly income and store in a list
    List<double> monthlyIncome = List.filled(12, 0.0);
    for (var trans in allTrans) {
      if (trans.status == "income") {
        int monthIndex = trans.date.month - 1;
        if (monthIndex >= 0 && monthIndex < 12) {
          monthlyIncome[monthIndex] += trans.amount;
        }
      }
    }
    // Now monthlyIncome contains total income for each month (index 0 = January, etc.)
    return {
      'monthNames': monthNames,
      'monthlyIncome': monthlyIncome,
    };
  }

  String _monthName(int month) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    if (month >= 1 && month <= 12) {
      return monthNames[month - 1];
    }
    return 'Unknown';
  }
}
