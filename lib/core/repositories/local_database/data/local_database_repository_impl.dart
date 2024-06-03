import 'package:questopia/core/database/model/quest_entity.dart';

abstract interface class LocalDatabaseRepository {
  const LocalDatabaseRepository();

  List<QuestEntity> loadQuests();

  Future<void> addQuest({
    required QuestEntity entity,
  });

  Future<void> deleteQuest({
    required String questId,
  });
}
