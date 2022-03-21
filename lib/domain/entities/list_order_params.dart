class ListOrderParams{
  final String status;
  final String? idPengguna;
  final String start;
  final String end;

  ListOrderParams(this.status, {this.idPengguna,required this.start,required this.end});
}