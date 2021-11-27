class RegisterParams{
  final String username,password, role, email, alamat, noHp,nama;

  RegisterParams(this.username, this.password,  this.email, this.alamat, this.noHp, this.nama,
      {this.role='pelanggan'});
  Map<String,dynamic> toJson()=>{
    'username':username,
    'nama':nama,
    'password':password,
    'role':role,
    'email':email,
    'alamat':alamat,
    'no_hp':noHp
  };
}