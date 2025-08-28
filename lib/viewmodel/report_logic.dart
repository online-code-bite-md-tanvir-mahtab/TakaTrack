import 'package:takatrack/model/add_transaction.dart';
import 'package:takatrack/service/goal_service.dart';
import 'package:takatrack/service/transaction_service.dart';

class ReportLogic {
  TransactionService service = TransactionService();
  GoalService goalService = GoalService();

  Map<String, List<dynamic>> getAllTransactionMonthNames() {
    List<AddTransaction> allTrans = service.getAllTransactions();
    Set<double> uniqueMonths = {};
    print("all trans: $allTrans");

    for (var trans in allTrans) {
      print("single amount : ${trans.amount}");
      uniqueMonths.add(trans.amount);
    }
    List<String> monthNames = [];
    for (var month in allTrans) {
      monthNames.add(_monthName(month.date.month));
    }

    // Calculate monthly income and store in a list
    List<double> monthlyIncome = List.filled(allTrans.length, 0.0);
    for (var trans in allTrans) {
      if (trans.status == "income") {
        int monthIndex = trans.date.month;
        if (monthIndex >= 0 && monthIndex < allTrans.length) {
          monthlyIncome[monthIndex] += trans.amount;
        }
      }
    }
    // Now monthlyIncome contains total income for each month (index 0 = January, etc.)
    return {'monthNames': monthNames, 'monthlyIncome': uniqueMonths.toList()};
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
