import 'package:equatable/equatable.dart';

class ReservedSlotsQuestDomain {
  const ReservedSlotsQuestDomain({
    required this.idReservedSlot,
    required this.idUser,
    required this.phone,
    required this.countPlayer,
    required this.idSlot,
    required this.price,
  });

  final String idReservedSlot;
  final QuestSlotDomain idSlot;
  final String idUser;
  final String phone;
  final int countPlayer;
  final String price;

  static ReservedSlotsQuestDomain fromJson(Map<String, dynamic> json) =>
      ReservedSlotsQuestDomain(
        idUser: json['id_user'],
        phone: json['phone'],
        idReservedSlot: json['id_reserved_slot'],
        idSlot: QuestSlotDomain.fromJson(json['slots']),
        countPlayer: json['count_player'],
        price: json['price'],
      );
}

class QuestSlotDomain {
  const QuestSlotDomain({
    required this.idQuest,
    required this.id,
    required this.date,
    required this.time,
    required this.status,
    // required this.idSlot,

    // required this.idQuest,
  });

  // final ReservedSlotsQuestDomain? idSlot;

  // final String idQuest;

  final String id;
  final QuestReservedDomain idQuest;
  final String date;
  final String time;
  final bool status;

  static QuestSlotDomain fromJson(Map<String, dynamic> json) => QuestSlotDomain(
        id: json['id_slot'],
        idQuest: QuestReservedDomain.fromJson(json['quests']),
        date: json['date'],
        time: json['time'],
        status: json['status'],
      );
}

class QuestReservedDomain extends Equatable {
  const QuestReservedDomain({
    required this.name,
    required this.room,
    required this.ageLimit,
    required this.numberOfPlayerMax,
    required this.numberOfPlayerMin,
    required this.time,
    required this.price,
    required this.priceForAdditional,
    required this.difficultyLevel,
    required this.levelOfFear,
    required this.description,
    required this.priceQuest,
    required this.photos,
    required this.category,
    required this.isNew,
    required this.id,
  });

  final String id;
  final String name;
  final String room;
  final int ageLimit;
  final int numberOfPlayerMax;
  final int numberOfPlayerMin;
  final String time;
  final String price;
  final String priceForAdditional;
  final int difficultyLevel;
  final int levelOfFear;
  final String description;
  final String priceQuest;
  final List<String> photos;
  final String category;
  final bool isNew;

  static QuestReservedDomain fromJson(Map<String, dynamic> json) {
    return QuestReservedDomain(
      name: json['name'],
      room: json['room'],
      ageLimit: json['age_limit'],
      numberOfPlayerMax: json['number_of_players_max'],
      numberOfPlayerMin: json['number_of_players_min'],
      time: json['time'],
      price: json['price'],
      priceForAdditional: json['price_for_additional_player'],
      difficultyLevel: json['difficulty_level'],
      levelOfFear: json['level_of_fear'],
      description: json['description'],
      priceQuest: json['price_quest'],
      photos:
          (json['photos']).map<String>((photo) => photo.toString()).toList(),
      category: json['category'],
      isNew: json['isNew'],
      id: json['id_quest'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        room,
        ageLimit,
        numberOfPlayerMax,
        numberOfPlayerMin,
        time,
        price,
        priceForAdditional,
        difficultyLevel,
        levelOfFear,
        description,
        priceQuest,
        photos,
        category,
      ];
}
