import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/repositories/order_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class CountOrder extends UseCase<int,String>{
  final OrderRepository _repository;

  CountOrder(this._repository);
  @override
  Future<Either<AppError, int>> call(String params)async {
    return await _repository.getCountOrder(params);
  }

}