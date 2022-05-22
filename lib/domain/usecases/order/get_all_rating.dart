import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/models/rating_model.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/repositories/order_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class GetAllRating extends UseCase<List<DataRating>,NoParams>{
  final OrderRepository _repository;

  GetAllRating(this._repository);
  @override
  Future<Either<AppError, List<DataRating>>> call(NoParams params) async {
    return await _repository.getAllRating();
  }

}