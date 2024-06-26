// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_steps_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskStepsModelAdapter extends TypeAdapter<TaskStepsModel> {
  @override
  final int typeId = 5;

  @override
  TaskStepsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskStepsModel(
      step: fields[0] as String,
      isStepChecked: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TaskStepsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.step)
      ..writeByte(1)
      ..write(obj.isStepChecked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskStepsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
