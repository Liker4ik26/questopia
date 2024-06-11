import 'package:questopia/core/repositories/reserved_quest/domain/reserved_quest.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReservedQuestApi {
  ReservedQuestApi({
    required Supabase supabase,
    required String url,
    required String apiKey,
  }) : _supabase = supabase;

  final Supabase _supabase;

  Future<void> deleteReservedQuest(
      ReservedSlotsQuestDomain reservedSlotsQuestDomain) async {
    await _supabase.client.from('slots').update({
      'status': false,
    }).eq('id_slot', reservedSlotsQuestDomain.idSlot.id);
  }

  Future<List<ReservedSlotsQuestDomain>> getReservedQuests() async {
    final userId = _supabase.client.auth.currentUser!.id;
    final response = await _supabase.client.from('reserved_slots').select(
        ''' *, slots:id_slot(*, quests:id_quest(*))''').eq('id_user', userId);
    // .order('date',referencedTable: 'slots',ascending: true);
    final List<dynamic> data = response;

    List<ReservedSlotsQuestDomain> questList = data
        .map((jsonData) => ReservedSlotsQuestDomain.fromJson(jsonData))
        .toList();
    print(questList);
    return questList;
  }
}
