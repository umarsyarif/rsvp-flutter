import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/models/login_model.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/repositories/auth_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class GetDetailUser extends UseCase<User,NoParams>{
  final AuthRepository _repository;

  GetDetailUser(this._repository);
  @override
  Future<Either<AppError, User>> call(NoParams params)async {
    return await _repository.getDetailUser();
  }

}