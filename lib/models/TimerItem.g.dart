// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TimerItem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimerItemAdapter extends TypeAdapter<TimerItem> {
  @override
  final int typeId = 1;

  @override
  TimerItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimerItem(
      duration: fields[0] as int?,
      isPaused: fields[1] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, TimerItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.duration)
      ..writeByte(1)
      ..write(obj.isPaused);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimerItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
