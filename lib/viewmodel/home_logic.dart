import 'package:takatrack/model/add_goal.dart';
import 'package:takatrack/model/add_transaction.dart';
import 'package:takatrack/service/goal_service.dart';
import 'package:takatrack/service/transaction_service.dart';

class HomeLogic {
  TransactionService service = TransactionService();

  double getTotalIncome() {
    List<AddTransaction> allTrans = service.getAllTransactions();
    double totalIncome = 0;
    for (var income in allTrans) {
      if (income.isIncome == true) {
        totalIncome += income.amount;
      }
    }
    return totalIncome;
  }

  double getTotalExpenses() {
    List<AddTransaction> allTrans = service.getAllTransactions();
    double totalExpenses = 0;
    for (var expense in allTrans) {
      if (expense.isIncome == false) {
        totalExpenses += expense.amount;
      }
    }
    return totalExpenses;
  }

  double getBankBalance() {
    List<AddTransaction> allTrans = service.getAllTransactions();
    double bankBalance = 0;
    for (var trans in allTrans) {
      bankBalance += trans.isIncome ? trans.amount : -trans.amount;
    }
    return bankBalance;
  }

  double getCurrentSavings() {
    List<AddTransaction> allTrans = service.getAllTransactions();
    double savings = 0;
    for (var trans in allTrans) {
      if (trans.category == 'Insurance') {
        savings += trans.isIncome ? trans.amount : -trans.amount;
      }
    }
    return savings;
  }

  // this is for savings progress bar
  double getSavingsProgress() {
    GoalService goalService = GoalService();

    List<AddGoal> goals = goalService.getAllGoals();
    double targetSavings = 0;
    double currentSavings = 0;
    var count_goal = goals.length;
    if (count_goal == 0) return 0.0;
    for (var goal in goals) {
      // if (goal.isCompleted == false) {
      //   double targetSavings = goal.targetAmount;
      //   double currentSavings = getCurrentSavings();
      //   return (currentSavings / targetSavings).clamp(0, 1);
      // }
      targetSavings += goal.targetAmount;
      currentSavings = getCurrentSavings();
    }
    return (currentSavings / targetSavings).clamp(0, 1);
  }

  /// Returns the data for a bar chart comparing income and expenses.
  /// The result is a map with 'Income' and 'Expenses' as keys and their totals as values.
  Map<String, List<double>> getIncomeExpensesBarChartData() {
    List<AddTransaction> allTrans = service.getAllTransactions();
    List<double> allinomeTrans = [];
    List<double> allexpenseTrans = [];
    for (var income in allTrans) {
      if (income.isIncome == true) {
        allinomeTrans.add(income.amount);
      } else {
        allexpenseTrans.add(income.amount);
      }
    }
    return {'Income': allinomeTrans, 'Expenses': allexpenseTrans};
  }
}
