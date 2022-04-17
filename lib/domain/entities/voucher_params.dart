class VoucherParams{
  final String label;
  String foto;
  final int diskon;
  final String? id;
  VoucherParams(this.label, this.foto, this.diskon,{this.id});
  Map<String,dynamic> toJson()=>{
    'id':id,
    'label':label,
    'diskon':diskon,
    'foto':foto,
  };
}