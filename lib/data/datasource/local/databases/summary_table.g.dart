// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SummaryTableAdapter extends TypeAdapter<SummaryTable> {
  @override
  final int typeId = 0;

  @override
  SummaryTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SummaryTable(
      originalText: fields[0] as String?,
      summarizedText: fields[1] as String?,
      favorite: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SummaryTable obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.originalText)
      ..writeByte(1)
      ..write(obj.summarizedText)
      ..writeByte(2)
      ..write(obj.favorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SummaryTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
