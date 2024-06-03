import 'package:questopia/core/repositories/slots/domain/reserved_slot_domain.dart';
import 'package:questopia/core/repositories/slots/domain/slot_domain.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SlotsApi {
  SlotsApi({
    required Supabase supabase,
    required String url,
    required String apiKey,
  }) : _supabase = supabase;

  final Supabase _supabase;

  Future<List<SlotDomain>> getSlots(
      {required String questId, required DateTime date}) async {
    final response = await _supabase.client
        .from('slots')
        .select(
            '''*,quests:id_quest( price, number_of_players_max, number_of_players_min, price_for_additional_player )''')
        .eq('id_quest', questId)
        .eq('date', date)
        .order('time', ascending: true);
    final List<dynamic> data = response;
    List<SlotDomain> slotsList =
        data.map((jsonData) => SlotDomain.fromJson(jsonData)).toList();

    return slotsList;
  }

  Future<void> reserveSlot({required ReservedSlotDomain slotDomain}) async {
    await _supabase.client.from('reserved_slots').insert({
      'id_user': _supabase.client.auth.currentUser!.id,
      'id_slot': slotDomain.idSlot,
      'count_player': slotDomain.countPlayer,
      'phone': slotDomain.phone,
      'price': slotDomain.price,
    });
    await _supabase.client
        .from('slots')
        .update({'status': true}).eq('id_slot', slotDomain.idSlot);
  }
}
