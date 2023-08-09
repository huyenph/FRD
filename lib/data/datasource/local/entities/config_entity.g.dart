// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConfigEntityAdapter extends TypeAdapter<ConfigEntity> {
  @override
  final int typeId = 0;

  @override
  ConfigEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConfigEntity(
      theme: fields[0] as String,
      language: fields[1] as LanguageEntity,
    );
  }

  @override
  void write(BinaryWriter writer, ConfigEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.theme)
      ..writeByte(1)
      ..write(obj.language);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfigEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
