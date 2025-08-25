// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddGoalAdapter extends TypeAdapter<AddGoal> {
  @override
  final int typeId = 1;

  @override
  AddGoal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddGoal(
      id: fields[0] as String?,
      goalName: fields[1] as String,
      goalDescription: fields[2] as String,
      targetDate: fields[3] as DateTime,
      targetAmount: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, AddGoal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.goalName)
      ..writeByte(2)
      ..write(obj.goalDescription)
      ..writeByte(3)
      ..write(obj.targetDate)
      ..writeByte(4)
      ..write(obj.targetAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
