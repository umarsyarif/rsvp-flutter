import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/core/api_client.dart';
import 'package:kopiek_resto/data/models/konfigurasi_model.dart';
import 'package:kopiek_resto/data/models/menu_model.dart';
import 'package:kopiek_resto/data/models/satuan_model.dart';

abstract class SatuanRemoteDataSource{
  Future<bool> postSatuan(Map<String,dynamic> data);
  Future<SatuanModel> getSatuan();
  Future<bool> postMenu(FormData data);
  Future<MenuModel> getMenu();
  Future<KonfigurasiModel> getKonfigurasi();
}

@LazySingleton(as: SatuanRemoteDataSource)
class SatuanRemoteDataSourceImpl implements SatuanRemoteDataSource{
  final ApiClient _client;

  SatuanRemoteDataSourceImpl(this._client);
  
  @override
  Future<bool> postSatuan(Map<String, dynamic> data)async {
    await _client.post('/satuan', data);
    return true;
  }

  @override
  Future<SatuanModel> getSatuan() async{
    final res = await _client.get('/satuan/all');
    SatuanModel model = SatuanModel.fromJson(res);
    return model;
  }
  @override
  Future<bool> postMenu(FormData data)async {
    await _client.postFormData('/menu', data);
    return true;
  }

  @override
  Future<MenuModel> getMenu() async{
    final res = await _client.get('/menu/all');
    MenuModel model = MenuModel.fromJson(res);
    return model;
  }

  @override
  Future<KonfigurasiModel> getKonfigurasi() async{
    final res = await _client.get('/konfigurasi/find/1');
    KonfigurasiModel model = KonfigurasiModel.fromJson(res);
    return model;
  }
  
}