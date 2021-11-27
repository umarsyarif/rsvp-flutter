class SatuanParams{
  final String nama;

  SatuanParams(this.nama);
  Map<String,dynamic> toJson()=>{
    'nama':nama
  };
}