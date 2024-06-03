class ReservedSlotDomain {
  const ReservedSlotDomain({
    this.idReservedSlot,
    this.idUser,
    required this.phone,
    required this.countPlayer,
    required this.idSlot,
    required this.price,
  });

  final String? idReservedSlot;
  final String idSlot;
  final String? idUser;
  final String phone;
  final int countPlayer;
  final String price;

  static ReservedSlotDomain fromJson(Map<String, dynamic> json) =>
      ReservedSlotDomain(
        idUser: json['id_user'],
        phone: json['phone'],
        idReservedSlot: json['id_reserved_slot'],
        idSlot: json['id_slot'],
        countPlayer: json['count_player'],
        price: json['price'],
      );
}
