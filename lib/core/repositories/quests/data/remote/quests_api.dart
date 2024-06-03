import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/quest_domain.dart';

class QuestApi {
  QuestApi({
    required Supabase supabase,
    required String url,
    required String apiKey,
  }) : _supabase = supabase;

  final Supabase _supabase;

  Future<List<QuestDomain>> getQuests() async {
    final response = await _supabase.client.from('quests').select('''
              *,
              types:id_type_of_game ( id_type, name_type ),
              organizations:id_organization(*)
              ''').order('isNew').order('price');
    final List<dynamic> data = response;
    List<QuestDomain> questList =
        data.map((jsonData) => QuestDomain.fromJson(jsonData)).toList();

    return questList;
  }

  Future<List<QuestDomain>> getQuestsWithFilter() async {
    final response = await _supabase.client
        .from('quests')
        .select('''
              *,
              types:id_type_of_game ( id_type, name_type ),
              organizations:id_organization(*)
              ''')
        .filter('types.name_type', 'eq', 'перформанс')
        .filter('category', 'eq', 'Страшные')
        // .filter('slots.date', 'eq', '')
        // .filter('slots.time', 'eq', '')
        .filter('number_of_players_max', 'gte', '3')
        .gte('price', '3000')
        .lte('price', '4000')
        .filter('age_limit', 'eq', '14')
        .filter('difficulty_level', 'eq', '2')
        .filter('level_of_fear', 'eq', '2');
    print(' Отсортированные квесты $response');
    final List<dynamic> data = response;
    List<QuestDomain> questList =
        data.map((jsonData) => QuestDomain.fromJson(jsonData)).toList();
    print(' Отсортированные квесты $questList');
    return questList;
  }

  Future<List<QuestDomain>> getQuestsByType(String type) async {
    final response = await _supabase.client.from('quests').select('''
              *,
              types:id_type_of_game ( id_type, name_type ),
              organizations:id_organization(*)
              ''').eq('category', type).order('isNew').order('price');
    final List<dynamic> data = response;
    List<QuestDomain> questList =
        data.map((jsonData) => QuestDomain.fromJson(jsonData)).toList();

    return questList;
  }

  Future<List<QuestDomain>> searchByName({
    required String query,
  }) async {
    final response = await _supabase.client.from('quests').select(''' *,
     types:id_type_of_game ( id_type, name_type ), organizations:id_organization( * )''').ilike('name', '%$query%');
    print(response);
    final List<dynamic> data = response;
    List<QuestDomain> questList =
        data.map((jsonData) => QuestDomain.fromJson(jsonData)).toList();

    return questList;
  }

  Future<QuestDomain> getQuest(String questId) async {
    final response = await _supabase.client.from('quests').select(''' *,
     types:id_type_of_game ( id_type, name_type ), organizations:id_organization(*) ''').eq('id_quest', questId);
    final data = response;
    final dynamic quest =
        data.map((jsonData) => QuestDomain.fromJson(jsonData)).first;
    return quest;
  }

// Future<List<ReservedSlotsQuestDomain>> getReservedQuests() async {
//   final userId = _supabase.client.auth.currentUser!.id;
//   final response = await _supabase.client
//       .from('reserved_slots')
//       .select(''' *, slots:id_slot(id_slot,id_quest,date,time,status)''')
//       .eq('id_user', userId)
//       .eq('slots.status', true);
//   final List<dynamic> data = response;
//   List<ReservedSlotsQuestDomain> questList =
//       data.map((jsonData) => ReservedSlotsQuestDomain.fromJson(jsonData)).toList();
//   print(questList);
//   return questList;
// }
}
