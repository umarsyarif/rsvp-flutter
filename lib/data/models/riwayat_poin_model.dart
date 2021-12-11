// To parse this JSON data, do
//
//     final poinModel = poinModelFromJson(jsonString);

import 'dart:convert';

PoinModel poinModelFromJson(String str) => PoinModel.fromJson(json.decode(str));

String poinModelToJson(PoinModel data) => json.encode(data.toJson());

class PoinModel {
  PoinModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<DataRiwayatPoin> data;

  factory PoinModel.fromJson(Map<String, dynamic> json) => PoinModel(
    success: json["success"],
    message: json["message"],
    data: List<DataRiwayatPoin>.from(json["data"].map((x) => DataRiwayatPoin.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataRiwayatPoin {
  DataRiwayatPoin({
    required this.id,
    required this.idPengguna,
    required this.nominal,
    required this.tipe,
    required this.updatedAt,
    required this.createdAt,
  });

  int id;
  int idPengguna;
  int nominal;
  String tipe;
  DateTime createdAt;
  DateTime updatedAt;

  factory DataRiwayatPoin.fromJson(Map<String, dynamic> json) => DataRiwayatPoin(
    id: json["id"],
    idPengguna: json["id_pengguna"],
    nominal: json["nominal"],
    tipe: json["tipe"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_pengguna": idPengguna,
    "nominal": nominal,
    "tipe": tipe,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
