import 'package:hive/hive.dart';

part 'quest_entity.g.dart';

@HiveType(typeId: 0)
class QuestEntity {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int ageLimit;
  @HiveField(2)
  final int numberOfPlayerMax;
  @HiveField(3)
  final int numberOfPlayerMin;
  @HiveField(4)
  final String time;
  @HiveField(5)
  final String price;
  @HiveField(6)
  final int difficultyLevel;
  @HiveField(7)
  final int levelOfFear;
  @HiveField(8)
  final String typeOfGame;
  @HiveField(9)
  final String photos;
  @HiveField(10)
  final bool isNew;
  @HiveField(11)
  final String questId;

  QuestEntity(
      {required this.name,
      required this.ageLimit,
      required this.numberOfPlayerMax,
      required this.numberOfPlayerMin,
      required this.time,
      required this.price,
      required this.difficultyLevel,
      required this.levelOfFear,
      required this.typeOfGame,
      required this.photos,
      required this.isNew,
      required this.questId});
}
