import 'package:questopia/core/repositories/quests/data/quests_repository.dart';
import 'package:questopia/core/repositories/quests/data/remote/quests_api.dart';
import 'package:questopia/core/repositories/quests/domain/quest_domain.dart';

class QuestRepositoryImpl implements QuestRepository {
  QuestRepositoryImpl({
    required QuestApi questApi,
  }) : _questApi = questApi;

  final QuestApi _questApi;

  @override
  Future<List<QuestDomain>> getQuests() async {
    final response = await _questApi.getQuests();
    return response;
  }

  @override
  Future<QuestDomain> getQuest(String questId) async {
    final response = await _questApi.getQuest(questId);
    return response;
  }

  @override
  Future<List<QuestDomain>> getType(String type) async {
    final response = await _questApi.getQuestsByType(type);
    return response;
  }

  @override
  Future<List<QuestDomain>> searchByName({required String query}) async {
    final response = await _questApi.searchByName(query: query);
    return response;
  }

  @override
  Future<List<QuestDomain>> getQuestsWithFilter() async {
    final response = await _questApi.getQuestsWithFilter();
    return response;
  }
}
