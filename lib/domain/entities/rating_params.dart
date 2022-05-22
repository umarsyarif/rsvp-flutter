class RatingParams{
  final String idUser;
  final String rating;
  final String? catatan;
  RatingParams(this.idUser, this.rating, {this.catatan});

  Map<String,dynamic> get json =>{
    'id_user':idUser,
    'rating':rating,
    'catatan':catatan
  };
}