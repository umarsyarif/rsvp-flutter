class OrderParams{
  final String jenis,tanggal,jam;
  final int jumlahOrang;

  OrderParams(this.jenis, this.tanggal, this.jam, this.jumlahOrang);

  Map<String,dynamic> toJson()=>{
    'jenis':jenis,
    'tanggal':tanggal,
    'jam':jam,
    'jumlah_orang':jumlahOrang
  };
}