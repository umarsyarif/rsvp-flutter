// To parse this JSON data, do
//
//     final konfigurasiModel = konfigurasiModelFromJson(jsonString);

import 'dart:convert';

KonfigurasiModel konfigurasiModelFromJson(String str) => KonfigurasiModel.fromJson(json.decode(str));

String konfigurasiModelToJson(KonfigurasiModel data) => json.encode(data.toJson());

class KonfigurasiModel {
  KonfigurasiModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  DataKonfigurasi data;

  factory KonfigurasiModel.fromJson(Map<String, dynamic> json) => KonfigurasiModel(
    success: json["success"],
    message: json["message"],
    data: DataKonfigurasi.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class DataKonfigurasi {
  DataKonfigurasi({
    required this.id,
    required this.buka,
    required this.tutup,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String buka;
  String tutup;
  DateTime createdAt;
  DateTime updatedAt;

  factory DataKonfigurasi.fromJson(Map<String, dynamic> json) => DataKonfigurasi(
    id: json["id"],
    buka: json["buka"],
    tutup: json["tutup"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "buka": buka,
    "tutup": tutup,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
