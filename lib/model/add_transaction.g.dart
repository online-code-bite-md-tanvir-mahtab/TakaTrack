// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddTransactionAdapter extends TypeAdapter<AddTransaction> {
  @override
  final int typeId = 0;

  @override
  AddTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddTransaction(
      id: fields[0] as String,
      amount: fields[1] as double,
      category: fields[2] as String,
      date: fields[3] as DateTime,
      note: fields[4] as String,
      isIncome: fields[5] as bool,
      status: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddTransaction obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.note)
      ..writeByte(5)
      ..write(obj.isIncome)
      ..writeByte(6)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
