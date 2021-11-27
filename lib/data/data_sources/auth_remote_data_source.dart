import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/core/api_client.dart';
import 'package:kopiek_resto/data/models/login_model.dart';

abstract class AuthRemoteDataSource{
  Future<LoginModel> login(Map<String,dynamic> body);
  Future<bool> register(Map<String,dynamic> data);
}
@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  final ApiClient _client;
  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<LoginModel> login(Map<String, dynamic> body) async {
    final res = await _client.post('/login', body);
    LoginModel model = LoginModel.fromJson(res);
    return model;
  }

  @override
  Future<bool> register(Map<String, dynamic> data) async{
    await _client.post('/register', data);
    return true;
  }
}