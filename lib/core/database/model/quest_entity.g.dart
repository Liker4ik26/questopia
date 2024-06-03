// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestEntityAdapter extends TypeAdapter<QuestEntity> {
  @override
  final int typeId = 0;

  @override
  QuestEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestEntity(
      name: fields[0] as String,
      ageLimit: fields[1] as int,
      numberOfPlayerMax: fields[2] as int,
      numberOfPlayerMin: fields[3] as int,
      time: fields[4] as String,
      price: fields[5] as String,
      difficultyLevel: fields[6] as int,
      levelOfFear: fields[7] as int,
      typeOfGame: fields[8] as String,
      photos: fields[9] as String,
      isNew: fields[10] as bool,
      questId: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QuestEntity obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.ageLimit)
      ..writeByte(2)
      ..write(obj.numberOfPlayerMax)
      ..writeByte(3)
      ..write(obj.numberOfPlayerMin)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.difficultyLevel)
      ..writeByte(7)
      ..write(obj.levelOfFear)
      ..writeByte(8)
      ..write(obj.typeOfGame)
      ..writeByte(9)
      ..write(obj.photos)
      ..writeByte(10)
      ..write(obj.isNew)
      ..writeByte(11)
      ..write(obj.questId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
