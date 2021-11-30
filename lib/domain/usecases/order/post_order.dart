import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/pucrhase_order_params.dart';
import 'package:kopiek_resto/domain/repositories/order_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class PostOrder extends UseCase<bool,PurchaseOrderParams>{
  final OrderRepository _repository;

  PostOrder(this._repository);
  @override
  Future<Either<AppError, bool>> call(PurchaseOrderParams params)async {
    return await _repository.postOrder(params);
  }

}