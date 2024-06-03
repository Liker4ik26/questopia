import 'package:questopia/core/repositories/quests/domain/quest_domain.dart';

abstract interface class QuestRepository {
  const QuestRepository._();

  Future<List<QuestDomain>> getQuests();

  Future<List<QuestDomain>> getType(String type);

  Future<List<QuestDomain>> searchByName({
    required String query,
  });
  Future<List<QuestDomain>> getQuestsWithFilter();

  Future<QuestDomain> getQuest(String questId);
}
