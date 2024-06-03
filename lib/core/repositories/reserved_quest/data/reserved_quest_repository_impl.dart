import 'package:questopia/core/repositories/reserved_quest/data/remote/reserved_quests_api.dart';
import 'package:questopia/core/repositories/reserved_quest/data/reserved_quest_repository.dart';

import '../domain/reserved_quest.dart';

class ReservedQuestRepositoryImpl implements ReservedQuestRepository {
  ReservedQuestRepositoryImpl({
    required ReservedQuestApi reservedQuestApi,
  }) : _reservedQuestApi = reservedQuestApi;

  final ReservedQuestApi _reservedQuestApi;

  @override
  Future<List<ReservedSlotsQuestDomain>> getReservedQuests() async {
    final response = await _reservedQuestApi.getReservedQuests();
    return response;
  }

  @override
  Future<void> deleteReservedQuest(
      ReservedSlotsQuestDomain reservedSlotsQuestDomain) async {
    await _reservedQuestApi.deleteReservedQuest(reservedSlotsQuestDomain);
  }
}
