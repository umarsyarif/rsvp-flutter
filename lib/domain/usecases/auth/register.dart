import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/register_params.dart';
import 'package:kopiek_resto/domain/repositories/auth_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class Register extends UseCase<bool,RegisterParams>{
  final AuthRepository _repository;

  Register(this._repository);
  @override
  Future<Either<AppError, bool>> call(RegisterParams params)async {
    return await _repository.register(params);
  }

}