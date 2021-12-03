import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/models/order_model.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/repositories/order_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class GetDetailOrder extends UseCase<DataOrder,int>{
  final OrderRepository _repository;

  GetDetailOrder(this._repository);
  @override
  Future<Either<AppError, DataOrder>> call(int params)async {
    return await _repository.getDetailOrder(params);
  }

}