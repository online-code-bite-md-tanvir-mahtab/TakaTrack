import 'package:takatrack/model/add_transaction.dart';
import 'package:takatrack/service/transaction_service.dart';

class HomeLogic {
  TransactionService service = TransactionService();
  
  double getTotalIncome(){
    List<AddTransaction> allTrans =  service.getAllTransactions();
    double totalIncome = 0;
    for(var income in allTrans){
      if(income.isIncome == true){
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

}