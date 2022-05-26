import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/repositories/order_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

import '../../entities/check_seat_params.dart';

@lazySingleton
class CheckSeat extends UseCase<bool,CheckSeatParams>{
  final OrderRepository _repository;

  CheckSeat(this._repository);

  @override
  Future<Either<AppError, bool>> call(params) async {
    return await _repository.checkSeat(params);
  }

}