// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloglist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BlogAdapter extends TypeAdapter<Blog> {
  @override
  final int typeId = 0;

  @override
  Blog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Blog(
      id: fields[0] as String,
      image_url: fields[1] as String,
      title: fields[2] as String,
      isFavourite: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Blog obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image_url)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.isFavourite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
