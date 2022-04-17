class UpdateStokParams{
  final String id;
  final String jumlah;

  UpdateStokParams(this.id, this.jumlah);
  Map<String,dynamic> toJson()=>{
    'id':id,
    'jumlah':jumlah
  };
}