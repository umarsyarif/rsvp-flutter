class LoginParams{
  final String email;
  final String password;
  LoginParams(this.email, this.password);
  Map<String,dynamic> get toJson=>{
    'email':email,
    'password':password
  };
}