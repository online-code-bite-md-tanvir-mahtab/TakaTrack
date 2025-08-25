import 'package:hive/hive.dart';
import 'package:takatrack/model/add_goal.dart';

class GoalService {
  final Box<AddGoal> goalBox = Hive.box<AddGoal>('goals');

  List<AddGoal> getAllGoals() {
    return goalBox.values.toList();
  }

  Future<void> addGoal(AddGoal goal) async {
    await goalBox.put(goal.id, goal);
  }

  Future<void> deleteGoal(String id) async {
    await goalBox.delete(id);
  }

  AddGoal? getGoal(String id) {
    return goalBox.get(id);
  }

  Future<void> updateGoal(AddGoal goal) async {
    await goalBox.put(goal.id, goal);
  }
}