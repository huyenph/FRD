// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LanguageEntityAdapter extends TypeAdapter<LanguageEntity> {
  @override
  final int typeId = 1;

  @override
  LanguageEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LanguageEntity(
      title: fields[0] as String,
      locale: fields[1] as String,
      subTitle: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LanguageEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.locale)
      ..writeByte(2)
      ..write(obj.subTitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
