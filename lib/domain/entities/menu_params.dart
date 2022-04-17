class MenuParams{
  final String nama, idSatuan,tipe;
  String foto;
  final int harga,diskon,stok;
  String? id;
  MenuParams(this.nama, this.foto, this.idSatuan, this.tipe, this.harga, this.diskon, this.stok,{this.id});
  Map <String,dynamic> toJson()=>{
    'nama':nama,
    'id':id,
    'foto':foto,
    'id_satuan':idSatuan,
    'tipe':tipe,
    'harga':harga,
    'diskon':diskon,
  };
}