class UpdateActiveMenuParams{
  final int id;
  final int active;

  UpdateActiveMenuParams(this.id, this.active);
  Map<String,dynamic> toJson()=>{
    'id':id,
    'is_active':active
  };
}