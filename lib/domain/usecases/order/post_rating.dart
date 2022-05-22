import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/rating_params.dart';
import 'package:kopiek_resto/domain/repositories/order_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class PostRating extends UseCase<bool,RatingParams>{
  final OrderRepository _repository;

  PostRating(this._repository);
  @override
  Future<Either<AppError, bool>> call(RatingParams params) async {
    return await _repository.postRating(params);
  }

}