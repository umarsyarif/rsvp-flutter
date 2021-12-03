// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<DataOrder> data;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    success: json["success"],
    message: json["message"],
    data: List<DataOrder>.from(json["data"].map((x) => DataOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataOrder {
  DataOrder({
    required this.id,
    required this.jumlahOrang,
    required this.idPengguna,
    required this.jam,
    required this.tanggal,
    required this.subtotal,
    required this.diskon,
    required this.total,
    required this.tipe,
    required this.createdAt,
    required this.updatedAt,
    required this.statusOrder,
    required this.detailOrder,
    this.voucherOrder,
    required this.pengguna,
  });

  int id;
  int jumlahOrang;
  int idPengguna;
  String jam;
  DateTime tanggal;
  int subtotal;
  int diskon;
  int total;
  String tipe;
  DateTime createdAt;
  DateTime updatedAt;
  List<StatusOrder> statusOrder;
  List<DetailOrder> detailOrder;
  dynamic voucherOrder;
  Pengguna pengguna;

  factory DataOrder.fromJson(Map<String, dynamic> json) => DataOrder(
    id: json["id"],
    jumlahOrang: json["jumlah_orang"],
    idPengguna: json["id_pengguna"],
    jam: json["jam"],
    tanggal: DateTime.parse(json["tanggal"]),
    subtotal: json["subtotal"],
    diskon: json["diskon"],
    total: json["total"],
    tipe: json["tipe"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    statusOrder: List<StatusOrder>.from(json["status_order"].map((x) => StatusOrder.fromJson(x))),
    detailOrder: List<DetailOrder>.from(json["detail_order"].map((x) => DetailOrder.fromJson(x))),
    voucherOrder: json["voucher_order"],
    pengguna: Pengguna.fromJson(json["pengguna"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "jumlah_orang": jumlahOrang,
    "id_pengguna": idPengguna,
    "jam": jam,
    "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
    "subtotal": subtotal,
    "diskon": diskon,
    "total": total,
    "tipe": tipe,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "status_order": List<dynamic>.from(statusOrder.map((x) => x.toJson())),
    "detail_order": List<dynamic>.from(detailOrder.map((x) => x.toJson())),
    "voucher_order": voucherOrder,
    "pengguna": pengguna.toJson(),
  };
}

class DetailOrder {
  DetailOrder({
    required this.id,
    required this.idOrder,
    required this.idMenu,
    this.catatan,
    required this.jumlah,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    required this.menu,
  });

  int id;
  int idOrder;
  int idMenu;
  String? catatan;
  int jumlah;
  int total;
  DateTime createdAt;
  DateTime updatedAt;
  Menu menu;

  factory DetailOrder.fromJson(Map<String, dynamic> json) => DetailOrder(
    id: json["id"],
    idOrder: json["id_order"],
    idMenu: json["id_menu"],
    catatan: json["catatan"],
    jumlah: json["jumlah"],
    total: json["total"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    menu: Menu.fromJson(json["menu"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_order": idOrder,
    "id_menu": idMenu,
    "catatan": catatan == null ? null : catatan,
    "jumlah": jumlah,
    "total": total,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "menu": menu.toJson(),
  };
}

class Menu {
  Menu({
    required this.id,
    required this.nama,
    required this.foto,
    required this.harga,
    required this.diskon,
    required this.idSatuan,
    required this.tipe,
    required this.createdAt,
    required this.updatedAt,
    required this.satuan,
  });

  int id;
  String nama;
  String foto;
  int harga;
  int diskon;
  int idSatuan;
  String tipe;
  DateTime createdAt;
  DateTime updatedAt;
  Satuan satuan;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    id: json["id"],
    nama: json["nama"],
    foto: json["foto"],
    harga: json["harga"],
    diskon: json["diskon"],
    idSatuan: json["id_satuan"],
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

class Pengguna {
  Pengguna({
    required this.id,
    required this.username,
    required this.nama,
    required this.email,
    required this.role,
    required this.alamat,
    required this.noHp,
    required this.isVerified,
    required this.poin,
    required this.createdAt,
    required this.updatedAt,
    required this.riwayatPoin,
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
  List<dynamic> riwayatPoin;

  factory Pengguna.fromJson(Map<String, dynamic> json) => Pengguna(
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
    riwayatPoin: List<dynamic>.from(json["riwayat_poin"].map((x) => x)),
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
    "riwayat_poin": List<dynamic>.from(riwayatPoin.map((x) => x)),
  };
}

class StatusOrder {
  StatusOrder({
    required this.id,
    required this.idOrder,
    required this.status,
    this.jam,
    this.tanggal,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int idOrder;
  String status;
  dynamic jam;
  dynamic tanggal;
  DateTime createdAt;
  DateTime updatedAt;

  factory StatusOrder.fromJson(Map<String, dynamic> json) => StatusOrder(
    id: json["id"],
    idOrder: json["id_order"],
    status: json["status"],
    jam: json["jam"],
    tanggal: json["tanggal"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_order": idOrder,
    "status": status,
    "jam": jam,
    "tanggal": tanggal,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
