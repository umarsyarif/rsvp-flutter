// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  bool success;
  String message;
  String token;
  User user;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"],
    message: json["message"],
    token: json["token"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "token": token,
    "user": user.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.alamat,
    required this.isVerified,
    required this.noHp,
    required this.poin,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String username;
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
