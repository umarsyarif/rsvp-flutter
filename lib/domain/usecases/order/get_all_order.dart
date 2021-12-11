import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/models/order_model.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/list_order_params.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/repositories/order_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class GetAllOrder extends UseCase<List<DataOrder>,ListOrderParams>{
  final OrderRepository _repository;

  GetAllOrder(this._repository);
  @override
  Future<Either<AppError, List<DataOrder>>> call(ListOrderParams params)async {
    return await _repository.getAllOrder(params);
  }
}