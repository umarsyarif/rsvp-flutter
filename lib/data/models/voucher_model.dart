// To parse this JSON data, do
//
//     final voucherModel = voucherModelFromJson(jsonString);

import 'dart:convert';

VoucherModel voucherModelFromJson(String str) => VoucherModel.fromJson(json.decode(str));

String voucherModelToJson(VoucherModel data) => json.encode(data.toJson());

class VoucherModel {
  VoucherModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<DataVoucher> data;

  factory VoucherModel.fromJson(Map<String, dynamic> json) => VoucherModel(
    success: json["success"],
    message: json["message"],
    data: List<DataVoucher>.from(json["data"].map((x) => DataVoucher.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataVoucher {
  DataVoucher({
    required this.id,
    required this.label,
    required this.foto,
    required this.diskon,
    required this.updatedAt,
    required this.createdAt,
    required this.isActive
  });

  int id;
  String label;
  String foto;
  int diskon;
  int isActive;
  DateTime createdAt;
  DateTime updatedAt;

  factory DataVoucher.fromJson(Map<String, dynamic> json) => DataVoucher(
    id: json["id"],
    label: json["label"],
    foto: json["foto"],
    diskon: json["diskon"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isActive: json['is_active']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "foto": foto,
    "diskon": diskon,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
