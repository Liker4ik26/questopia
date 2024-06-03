import 'package:equatable/equatable.dart';

class QuestDomain extends Equatable {
  const QuestDomain({
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
    required this.typeOfGame,
    required this.priceQuest,
    required this.photos,
    required this.category,
    required this.isNew,
    required this.id,
    required this.organization,
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
  final TypeOfGameDomain typeOfGame;
  final String priceQuest;
  final List<String> photos;
  final String category;
  final bool isNew;
  final Organization organization;

  static QuestDomain fromJson(Map<String, dynamic> json) {

    return QuestDomain(
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
      typeOfGame: TypeOfGameDomain.fromJson(json['types']),
      priceQuest: json['price_quest'],
      photos:
          (json['photos']).map<String>((photo) => photo.toString()).toList(),
      category: json['category'],
      isNew: json['isNew'],
      id: json['id_quest'],
      organization: Organization.fromJson(json['organizations']),
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
        typeOfGame,
        priceQuest,
        photos,
        category,
      ];
}

class TypeOfGameDomain {
  const TypeOfGameDomain({
    required this.id,
    required this.nameOfType,
  });

  final String id;
  final String nameOfType;

  static TypeOfGameDomain fromJson(Map<String, dynamic> json) =>
      TypeOfGameDomain(
        id: json['id_type'],
        nameOfType: json['name_type'],
      );
}

class Organization {
  const Organization({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.loginInformation,
    required this.ceo,
    required this.wifi,
    required this.parkingPlace,
    required this.waitingRoom,
  });

  final String id;
  final String name;
  final String address;
  final String phone;
  final String loginInformation;
  final String ceo;
  final bool wifi;
  final String parkingPlace;
  final String waitingRoom;

  static Organization fromJson(Map<String, dynamic> json) => Organization(
        id: json['id_organization'],
        name: json['name_organization'],
        address: json['address'],
        phone: json['phone'],
        loginInformation: json['login_information'],
        ceo: json['ceo'],
        wifi: json['wifi'],
        parkingPlace: json['parking_place'],
        waitingRoom: json['waiting_room'],
      );
}
enum Types { scary, forChildren, forBeginners, entourage, all }