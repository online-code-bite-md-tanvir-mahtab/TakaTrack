import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
part 'add_goal.g.dart';


@HiveType(typeId: 1)
class AddGoal extends HiveObject{
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String goalName;
  @HiveField(2)
  late String goalDescription;
  @HiveField(3)
  late DateTime targetDate;
  @HiveField(4)
  late double targetAmount;

  AddGoal({
    String? id,
    required this.goalName,
    required this.goalDescription,
    required this.targetDate,
    required this.targetAmount,
  }) {
    this.id = id ?? Uuid().v4();
  }
}