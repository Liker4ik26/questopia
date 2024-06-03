class SlotDomain {
  const SlotDomain({
    required this.idSlot,
    required this.idQuest,
    required this.date,
    required this.time,
    required this.status,
    required this.price,
    required this.playersMax,
    required this.playersMin,
    required this.priceAdditionalPlayer,
  });

  final String idSlot;
  final String idQuest;
  final DateTime date;
  final String time;
  final QuestPriceDomain price;
  final bool status;
  final QuestPriceDomain playersMax;
  final QuestPriceDomain playersMin;
  final QuestPriceDomain priceAdditionalPlayer;

  static SlotDomain fromJson(Map<String, dynamic> json) => SlotDomain(
        idQuest: json['id_quest'],
        date: DateTime.parse(json['date']),
        time: json['time'],
        idSlot: json['id_slot'],
        status: json['status'],
        price: QuestPriceDomain.fromJson(json['quests']),
        playersMax: QuestPriceDomain.fromJson(json['quests']),
        playersMin: QuestPriceDomain.fromJson(json['quests']),
        priceAdditionalPlayer: QuestPriceDomain.fromJson(json['quests']),
      );
}

class QuestPriceDomain {
  const QuestPriceDomain({
    required this.price,
    required this.playersMax,
    required this.playersMin,
    required this.priceAdditionalPlayer,
  });

  final String price;
  final int playersMax;
  final int playersMin;
  final String priceAdditionalPlayer;

  static QuestPriceDomain fromJson(Map<String, dynamic> json) {
    return QuestPriceDomain(
      price: json['price'],
      playersMax: json['number_of_players_max'],
      playersMin: json['number_of_players_min'],
      priceAdditionalPlayer: json['price_for_additional_player'],
    );
  }
}
