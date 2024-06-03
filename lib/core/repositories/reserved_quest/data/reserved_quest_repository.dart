import '../domain/reserved_quest.dart';

abstract interface class ReservedQuestRepository {
  const ReservedQuestRepository._();

  Future<List<ReservedSlotsQuestDomain>> getReservedQuests();

  Future<void> deleteReservedQuest(
      ReservedSlotsQuestDomain reservedSlotsQuestDomain);
}
