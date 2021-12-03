import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/core/api_client.dart';
import 'package:kopiek_resto/data/models/order_model.dart';

abstract class OrderRemoteDataSource{
  Future<bool> postOrder(Map<String,dynamic> data);
  Future<List<DataOrder>> getAllMenu();
  Future<DataOrder> getDetailMenu(int id);
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
  Future<List<DataOrder>> getAllMenu() async{
    final res = await _client.get('/order');
    OrderModel model = OrderModel.fromJson(res);
    return model.data;
  }

  @override
  Future<DataOrder> getDetailMenu(int id)async {
    final res = await _client.get('/order/find/$id');
    DataOrder order = DataOrder.fromJson(res['data']);
    return order;
  }

}