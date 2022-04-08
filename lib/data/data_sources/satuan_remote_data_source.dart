import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/core/api_client.dart';
import 'package:kopiek_resto/data/models/konfigurasi_model.dart';
import 'package:kopiek_resto/data/models/menu_model.dart';
import 'package:kopiek_resto/data/models/satuan_model.dart';
import 'package:kopiek_resto/data/models/voucher_model.dart';

abstract class SatuanRemoteDataSource{
  Future<bool> postSatuan(Map<String,dynamic> data);
  Future<SatuanModel> getSatuan();
  Future<bool> postMenu(FormData data);
  Future<MenuModel> getMenu(String params);
  Future<KonfigurasiModel> getKonfigurasi();
  Future<bool> postVoucher(FormData data);
  Future<List<DataVoucher>> getAllVoucher(String params);
  Future<bool> updateKonfigurasi(Map<String,dynamic> params);
  Future<bool> updateNotifikasi(int id);
  Future<bool> updateMenu(Map<String,dynamic> body);
  Future<bool> updateVoucher(Map<String,dynamic> body);
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
  Future<MenuModel> getMenu(String params) async{
    final res = await _client.get('/menu/all?active=$params');
    MenuModel model = MenuModel.fromJson(res);
    return model;
  }

  @override
  Future<KonfigurasiModel> getKonfigurasi() async{
    final res = await _client.get('/konfigurasi/find/1');
    KonfigurasiModel model = KonfigurasiModel.fromJson(res);
    return model;
  }

  @override
  Future<bool> postVoucher(FormData data)async {
    await _client.postFormData('/voucher', data);
    return true;
  }

  @override
  Future<List<DataVoucher>> getAllVoucher(String params) async{
    final res = await _client.get('/voucher/all?active=$params');
    VoucherModel model = VoucherModel.fromJson(res);
    return model.data;
  }

  @override
  Future<bool> updateKonfigurasi(Map<String, dynamic> params)async {
    await _client.patch('/konfigurasi', params);
    return true;
  }

  @override
  Future<bool> updateNotifikasi(int id) async {
    await _client.get('/user/notifikasi/baca/$id');
    return true;
  }

  @override
  Future<bool> updateMenu(Map<String, dynamic> body)async {
    await _client.patch('/menu', body);
    return true;
  }

  @override
  Future<bool> updateVoucher(Map<String, dynamic> body) async {
    await _client.patch('/voucher', body);
    return true;
  }
  
}