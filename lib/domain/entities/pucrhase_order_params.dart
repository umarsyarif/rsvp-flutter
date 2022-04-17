class PurchaseOrderParams{
  final String idPengguna;
  final int jumlahOrang;
  final String jam;
  final String tanggal;
  final String tipe;
  final List<String> idMenu;
  final List<String> catatan;
  final List<int> jumlah;
  final String idVoucher;
  final int poin;

  PurchaseOrderParams(
      {required this.idPengguna,
      required this.jumlah,
      required this.jam,
      required this.tanggal,
      required this.tipe,
      required this.idMenu,
      required this.catatan,
      required this.jumlahOrang,
      required this.idVoucher,required this.poin,});
  Map<String,dynamic> toJson()=>{
    'id_pengguna':idPengguna,
    'jumlah':jumlah,
    'jam':jam,
    'tanggal':tanggal,
    'tipe':tipe,
    'id_menu':idMenu,
    'catatan':catatan,
    'jumlah_orang':jumlahOrang,
    'id_voucher':idVoucher,
    'poin':poin
  };
}