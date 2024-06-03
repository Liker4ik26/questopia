import 'package:hive_flutter/hive_flutter.dart';
import 'package:questopia/core/database/model/quest_entity.dart';
import 'package:questopia/core/repositories/local_database/data/local_database_repository_impl.dart';

class LocalDatabaseRepositoryImpl implements LocalDatabaseRepository {
  final questBox = Hive.box<QuestEntity>('quest_box');

  @override
  List<QuestEntity> loadQuests() {
    return questBox.values.toList();
  }

  @override
  Future<void> addQuest({
    required QuestEntity entity,
  }) async {
    await questBox.put(entity.questId, entity);
  }

  @override
  Future<void> deleteQuest({
    required String questId,
  }) async {
    await questBox.delete(questId);
  }
}
