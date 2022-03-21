// To parse this JSON data, do
//
//     final notifikasiModel = notifikasiModelFromJson(jsonString);

import 'dart:convert';

NotifikasiModel notifikasiModelFromJson(String str) => NotifikasiModel.fromJson(json.decode(str));

String notifikasiModelToJson(NotifikasiModel data) => json.encode(data.toJson());

class NotifikasiModel {
  NotifikasiModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<DataNotifikasi> data;

  factory NotifikasiModel.fromJson(Map<String, dynamic> json) => NotifikasiModel(
    success: json["success"],
    message: json["message"],
    data: List<DataNotifikasi>.from(json["data"].map((x) => DataNotifikasi.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataNotifikasi {
  DataNotifikasi({
    required this.id,
    required this.idUser,
    required this.isi,
    required this.keterangan,
    required this.type,
    required this.seen,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int idUser;
  String isi;
  String keterangan;
  String type;
  int seen;
  DateTime createdAt;
  DateTime updatedAt;

  factory DataNotifikasi.fromJson(Map<String, dynamic> json) => DataNotifikasi(
    id: json["id"],
    idUser: json["id_user"],
    isi: json["isi"],
    keterangan: json["keterangan"],
    type: json["type"],
    seen: json['seen'],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_user": idUser,
    "isi": isi,
    "keterangan": keterangan,
    "type": type,
    'seen':seen,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
