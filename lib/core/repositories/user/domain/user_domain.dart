class UserDomain {
  const UserDomain({
    this.idUser,
    required this.fio,
    required this.phone,
   this.email,
  });

  final String? idUser;
  final String fio;
  final String phone;
  final String? email;

  static UserDomain fromJson(Map<String, dynamic> json) => UserDomain(
        idUser: json['id'],
        fio: json['FIO'],
        phone: json['phone'],
        email: json['email'],
      );
}
