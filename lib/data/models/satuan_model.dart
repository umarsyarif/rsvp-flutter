// To parse this JSON data, do
//
//     final satuanModel = satuanModelFromJson(jsonString);

import 'dart:convert';

SatuanModel satuanModelFromJson(String str) => SatuanModel.fromJson(json.decode(str));

String satuanModelToJson(SatuanModel data) => json.encode(data.toJson());

class SatuanModel {
  SatuanModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<DataSatuan> data;

  factory SatuanModel.fromJson(Map<String, dynamic> json) => SatuanModel(
    success: json["success"],
    message: json["message"],
    data: List<DataSatuan>.from(json["data"].map((x) => DataSatuan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataSatuan {
  DataSatuan({
    required this.id,
    required this.nama,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String nama;
  DateTime createdAt;
  DateTime updatedAt;

  factory DataSatuan.fromJson(Map<String, dynamic> json) => DataSatuan(
    id: json["id"],
    nama: json["nama"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
