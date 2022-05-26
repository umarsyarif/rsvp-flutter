class CheckSeatParams{
  final String date;
  final int jumlahOrang;
  CheckSeatParams(this.date, this.jumlahOrang);
  Map<String,dynamic> get json=>{
    'date':date,
    'jumlah_orang':jumlahOrang
  };
}