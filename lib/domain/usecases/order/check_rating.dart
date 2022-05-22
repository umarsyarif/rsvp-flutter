import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/repositories/order_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class CheckRating extends UseCase<bool,int>{
  final OrderRepository _repository;

  CheckRating(this._repository);

  @override
  Future<Either<AppError, bool>> call(int params) async {
    return await _repository.checkRating(params);
  }

}