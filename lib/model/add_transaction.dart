import 'package:hive/hive.dart';
part 'add_transaction.g.dart';

@HiveType(typeId: 0)
class AddTransaction extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late double amount;

  @HiveField(2)
  late String category;

  @HiveField(3)
  late DateTime date;

  @HiveField(4)
  late String note;

  @HiveField(5)
  late bool isIncome;

  @HiveField(6)
  late String status; // Added status field

  AddTransaction({
    required this.id,
    required this.amount,
    required this.category,
    required this.date,
    required this.note,
    required this.isIncome,
    required this.status, // Added status to constructor
  });
}