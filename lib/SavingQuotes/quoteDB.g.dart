// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../SavingQuotes/quoteDB.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuoteDBAdapter extends TypeAdapter<QuoteDB> {
  @override
  final int typeId = 0;

  @override
  QuoteDB read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuoteDB()
      ..id = fields[0] as int
      ..author = fields[1] as String
      ..quoteContent = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, QuoteDB obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.quoteContent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuoteDBAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
