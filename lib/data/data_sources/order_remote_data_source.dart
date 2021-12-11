import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/core/api_client.dart';
import 'package:kopiek_resto/data/models/order_model.dart';
import 'package:kopiek_resto/data/models/riwayat_poin_model.dart';
import 'package:kopiek_resto/domain/entities/list_order_params.dart';

abstract class OrderRemoteDataSource{
  Future<bool> postOrder(Map<String,dynamic> data);
  Future<List<DataOrder>> getAllMenu(ListOrderParams params);
  Future<DataOrder> getDetailMenu(int id);
  Future<bool> updateStatus(Map<String,dynamic> data);
  Future<List<DataRiwayatPoin>> getRiwayatPoin(String idPengguna);
}
@LazySingleton(as: OrderRemoteDataSource)
class OrderRemoteDataSourceImpl implements OrderRemoteDataSource{
  final ApiClient _client;

  OrderRemoteDataSourceImpl(this._client);
  @override
  Future<bool> postOrder(Map<String, dynamic> data)async {
    await _client.post('/order', data);
    return true;
  }

  @override
  Future<List<DataOrder>> getAllMenu(ListOrderParams params) async{
    final res = await _client.get('/order?status=${params.status}&idPengguna=${params.idPengguna??''}');
    OrderModel model = OrderModel.fromJson(res);
    return model.data;
  }

  @override
  Future<DataOrder> getDetailMenu(int id)async {
    final res = await _client.get('/order/find/$id');
    DataOrder order = DataOrder.fromJson(res['data']);
    return order;
  }

  @override
  Future<bool> updateStatus(Map<String, dynamic> data)async {
    await _client.post('/order/ubah-status', data);
    return true;
  }

  @override
  Future<List<DataRiwayatPoin>> getRiwayatPoin(String idPengguna)async {
    final res = await _client.get('/voucher/poin/$idPengguna');
    PoinModel model = PoinModel.fromJson(res);
    return model.data;
  }

}