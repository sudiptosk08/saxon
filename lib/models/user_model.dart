class UserModel {
  UserModel({
    this.id,
    this.name,
    this.email,
    this.address,
    this.avatarUrl,
    this.phone,
    this.verifyCode,
    this.verified,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? email;
  String? address;
  dynamic avatarUrl;
  String? phone;
  dynamic verifyCode;
  bool? verified;
  dynamic createdAt;
  dynamic updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        avatarUrl: json["avatarUrl"],
        phone: json["phone"],
        verifyCode: json["verify_code"],
        verified: json["verified"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "address": address,
        "avatarUrl": avatarUrl,
        "phone": phone,
        "verify_code": verifyCode,
        "verified": verified,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
