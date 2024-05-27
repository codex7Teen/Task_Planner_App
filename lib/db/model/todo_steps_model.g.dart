// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_steps_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoStepsModelAdapter extends TypeAdapter<TodoStepsModel> {
  @override
  final int typeId = 6;

  @override
  TodoStepsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoStepsModel(
      stepTodo: fields[1] as String,
      isTodoChecked: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TodoStepsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.stepTodo)
      ..writeByte(2)
      ..write(obj.isTodoChecked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoStepsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
