import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/update_status_params.dart';
import 'package:kopiek_resto/domain/repositories/order_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class UpdateStatus extends UseCase<bool,UpdateStatusParams>{
  final OrderRepository _repository;

  UpdateStatus(this._repository);
  @override
  Future<Either<AppError, bool>> call(UpdateStatusParams params)async {
    return await _repository.updateStatus(params);
  }

}