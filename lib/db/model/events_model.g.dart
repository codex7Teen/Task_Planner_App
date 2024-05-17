// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventsModelAdapter extends TypeAdapter<EventsModel> {
  @override
  final int typeId = 7;

  @override
  EventsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventsModel(
      name: fields[0] as String,
      from: fields[1] as DateTime,
      to: fields[2] as DateTime,
      id: fields[3] as int?,
      isAllDay: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, EventsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.from)
      ..writeByte(2)
      ..write(obj.to)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.isAllDay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
