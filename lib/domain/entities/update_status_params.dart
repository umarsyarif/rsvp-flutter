class UpdateStatusParams{
  final int id;
  final String status;

  UpdateStatusParams(this.id, this.status);
  Map<String,dynamic> toJson()=>{
    'id_order':id,
    'status':status
  };
}