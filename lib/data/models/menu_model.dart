// To parse this JSON data, do
//
//     final menuModel = menuModelFromJson(jsonString);

import 'dart:convert';

MenuModel menuModelFromJson(String str) => MenuModel.fromJson(json.decode(str));

String menuModelToJson(MenuModel data) => json.encode(data.toJson());

class MenuModel {
  MenuModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<DataMenu> data;

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
    success: json["success"],
    message: json["message"],
    data: List<DataMenu>.from(json["data"].map((x) => DataMenu.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataMenu {
  DataMenu({
    required this.id,
    required this.nama,
    required this.foto,
    required this.harga,
    required this.idSatuan,
    required this.diskon,
    required this.tipe,
    required this.createdAt,
    required this.satuan,
    required this.isActive,
    required this.updatedAt,
  });

  int id;
  String nama;
  String foto;
  int harga;
  int diskon;
  int idSatuan;
  String tipe;
  int isActive;
  DateTime createdAt;
  DateTime updatedAt;
  Satuan satuan;

  factory DataMenu.fromJson(Map<String, dynamic> json) => DataMenu(
    id: json["id"],
    nama: json["nama"],
    foto: json["foto"],
    harga: json["harga"],
    diskon: json["diskon"],
    idSatuan: json["id_satuan"],
    isActive: json['is_active'],
    tipe: json["tipe"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    satuan: Satuan.fromJson(json["satuan"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "foto": foto,
    "harga": harga,
    "diskon": diskon,
    "id_satuan": idSatuan,
    "tipe": tipe,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "satuan": satuan.toJson(),
  };
}

class Satuan {
  Satuan({
    required this.id,
    required this.nama,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String nama;
  DateTime createdAt;
  DateTime updatedAt;

  factory Satuan.fromJson(Map<String, dynamic> json) => Satuan(
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
