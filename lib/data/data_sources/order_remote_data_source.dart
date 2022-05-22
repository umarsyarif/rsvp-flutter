import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/core/api_client.dart';
import 'package:kopiek_resto/data/models/order_model.dart';
import 'package:kopiek_resto/data/models/rating_model.dart';
import 'package:kopiek_resto/data/models/riwayat_poin_model.dart';
import 'package:kopiek_resto/domain/entities/list_order_params.dart';

abstract class OrderRemoteDataSource{
  Future<String> postOrder(Map<String,dynamic> data);
  Future<List<DataOrder>> getAllMenu(ListOrderParams params);
  Future<DataOrder> getDetailMenu(int id);
  Future<bool> updateStatus(Map<String,dynamic> data);
  Future<List<DataRiwayatPoin>> getRiwayatPoin(String idPengguna);
  Future<int> getCountOrder(String status);
  Future<bool> checkRating(int id);
  Future<bool> postRating(Map<String,dynamic>body);
  Future<RatingModel> getAllRating();
}
@LazySingleton(as: OrderRemoteDataSource)
class OrderRemoteDataSourceImpl implements OrderRemoteDataSource{
  final ApiClient _client;

  OrderRemoteDataSourceImpl(this._client);
  @override
  Future<String> postOrder(Map<String, dynamic> data)async {
    final res =  await _client.post('/order', data);
    return res['data'].toString();
  }

  @override
  Future<List<DataOrder>> getAllMenu(ListOrderParams params) async{
    final res = await _client.get('/order?status=${params.status}&idPengguna=${params.idPengguna??''}&start=${params.start}&end=${params.end}');
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

  @override
  Future<int> getCountOrder(String status)async {
    final res = await _client.get('/order/count/$status');
    return int.parse(res['data'].toString());
  }

  @override
  Future<bool> checkRating(int id)async {
    final res = await _client.get('/rating/check/$id');
    return res['data'];
  }

  @override
  Future<bool> postRating(Map<String, dynamic> body) async {
    await _client.post('/rating', body);
    return true;
  }

  @override
  Future<RatingModel> getAllRating() async {
    final res = await _client.get('/rating');
    RatingModel ratingModel = RatingModel.fromJson(res);
    return ratingModel;
  }
}