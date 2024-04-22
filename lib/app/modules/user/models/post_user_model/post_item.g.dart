part of 'post_item.dart';

class PostItemAdapter extends TypeAdapter<PostItem> {
  @override
  final int typeId = 1;

  @override
  PostItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostItem(
      fields[0] as String,
      fields[1] as String,
      fields[2] as int,
      fields[3] as List<dynamic>,
      fields[4] as String,
      fields[5] as DateTime,
      fields[6] as String,
      fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PostItem obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.likes)
      ..writeByte(3)
      ..write(obj.tags)
      ..writeByte(4)
      ..write(obj.text)
      ..writeByte(5)
      ..write(obj.publishDate)
      ..writeByte(6)
      ..write(obj.userName)
      ..writeByte(7)
      ..write(obj.ownerPic);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
