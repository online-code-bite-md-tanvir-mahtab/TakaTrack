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
      if (trans.status != 'income') {
        continue; // Skip non-income transactions
      } else {
        final monthName = _monthName(trans.date.month);
        // Sum amounts per month
        monthlyTotals[monthName] =
            (monthlyTotals[monthName] ?? 0) + trans.amount;
      }
    }

    // Separate lists for chart or UI
    List<String> monthNames = monthlyTotals.keys.toList();
    List<double> monthlyIncome = monthlyTotals.values.toList();

    return {'monthNames': monthNames, 'monthlyIncome': monthlyIncome};
  }

  Map<String, List<dynamic>> getAllExpansesMonthNames() {
    List<AddTransaction> allTrans = service.getAllTransactions();

    // Map to store month -> total amount
    Map<String, double> monthlyTotals = {};

    for (var trans in allTrans) {
      if (trans.status != 'expense') {
        continue; // Skip non-income transactions
      } else {
        final monthName = _monthName(trans.date.month);
        // Sum amounts per month
        monthlyTotals[monthName] =
            (monthlyTotals[monthName] ?? 0) + trans.amount;
      }
    }

    // Separate lists for chart or UI
    List<String> monthNames = monthlyTotals.keys.toList();
    List<double> monthlyExpenses = monthlyTotals.values.toList();

    return {'monthNames': monthNames, 'monthlyExpenses': monthlyExpenses};
  }

  Map<String, List<dynamic>> getAllSavingMonthNames() {
    List<AddTransaction> allTrans = service.getAllTransactions();

    // Map to store month -> total amount
    Map<String, double> monthlyTotals = {};

    for (var trans in allTrans) {
      if (trans.status != 'income') {
        continue; // Skip non-income transactions
      } else {
        if (trans.category != 'Insurance') {
          final monthName = _monthName(trans.date.month);
          // Sum amounts per month
          monthlyTotals[monthName] =
              (monthlyTotals[monthName] ?? 0) + trans.amount;
        } else {
          continue;
        }
      }
    }

    // Separate lists for chart or UI
    List<String> monthNames = monthlyTotals.keys.toList();
    List<double> monthlySavings = monthlyTotals.values.toList();

    return {'monthNames': monthNames, 'monthlyExpenses': monthlySavings};
  }

  Map<String, List<dynamic>> getAllExpenseBrackdownMonthNames() {
    List<AddTransaction> allTrans = service.getAllTransactions();

    // Map to store category -> total amount
    Map<String, double> categoryTotals = {};

    for (var trans in allTrans) {
      if (trans.status != 'expense') {
        continue; // Skip non-expense transactions
      } else {
        final categoryName = trans.category;
        // Sum amounts per category
        categoryTotals[categoryName] =
            (categoryTotals[categoryName] ?? 0) + trans.amount;
      }
    }

    // Separate lists for chart or UI
    List<String> categoryNames = categoryTotals.keys.toList();
    List<double> categoryExpenses = categoryTotals.values.toList();
    print("Category Names: $categoryNames");
    print("Category Expenses: $categoryExpenses");

    return {
      'categoryNames': categoryNames,
      'categoryExpenses': categoryExpenses,
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
