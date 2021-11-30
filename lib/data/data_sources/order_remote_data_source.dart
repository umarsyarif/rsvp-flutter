import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/core/api_client.dart';

abstract class OrderRemoteDataSource{
  Future<bool> postOrder(Map<String,dynamic> data);
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

}