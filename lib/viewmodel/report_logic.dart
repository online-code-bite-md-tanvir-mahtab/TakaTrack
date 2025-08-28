import 'package:takatrack/model/add_transaction.dart';
import 'package:takatrack/service/goal_service.dart';
import 'package:takatrack/service/transaction_service.dart';

class ReportLogic {
  TransactionService service = TransactionService();
  GoalService goalService = GoalService();

  Map<String, List<dynamic>> getAllTransactionMonthNames() {
  List<AddTransaction> allTrans = service.getAllTransactions();
  
  // Map to store month -> total amount
  Map<String, double> monthlyTotals = {};

  for (var trans in allTrans) {
    final monthName = _monthName(trans.date.month);
    // Sum amounts per month
    monthlyTotals[monthName] = (monthlyTotals[monthName] ?? 0) + trans.amount;
  }

  // Separate lists for chart or UI
  List<String> monthNames = monthlyTotals.keys.toList();
  List<double> monthlyIncome = monthlyTotals.values.toList();

  return {
    'monthNames': monthNames,
    'monthlyIncome': monthlyIncome,
  };
}


  String _monthName(int month) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    if (month >= 1 && month <= 12) {
      return monthNames[month - 1];
    }
    return 'Unknown';
  }
}
