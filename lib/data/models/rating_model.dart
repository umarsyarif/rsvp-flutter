// To parse this JSON data, do
//
//     final ratingModel = ratingModelFromJson(jsonString);

import 'dart:convert';

RatingModel ratingModelFromJson(String str) => RatingModel.fromJson(json.decode(str));

String ratingModelToJson(RatingModel data) => json.encode(data.toJson());

class RatingModel {
  RatingModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<DataRating> data;

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
    success: json["success"],
    message: json["message"],
    data: List<DataRating>.from(json["data"].map((x) => DataRating.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataRating {
  DataRating({
    required this.id,
    required this.idUser,
    required this.rating,
    this.catatan,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  int id;
  int idUser;
  int rating;
  String? catatan;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  factory DataRating.fromJson(Map<String, dynamic> json) => DataRating(
    id: json["id"],
    idUser: json["id_user"],
    rating: json["rating"],
    catatan: json["catatan"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_user": idUser,
    "rating": rating,
    "catatan": catatan,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user": user.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.username,
    required this.nama,
    required this.role,
    required this.email,
    required this.alamat,
    required this.noHp,
    required this.isVerified,
    required this.poin,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String username;
  String nama;
  String role;
  String email;
  String alamat;
  String noHp;
  int isVerified;
  int poin;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    nama: json["nama"],
    role: json["role"],
    email: json["email"],
    alamat: json["alamat"],
    noHp: json["no_hp"],
    isVerified: json["is_verified"],
    poin: json["poin"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "nama": nama,
    "role": role,
    "email": email,
    "alamat": alamat,
    "no_hp": noHp,
    "is_verified": isVerified,
    "poin": poin,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
