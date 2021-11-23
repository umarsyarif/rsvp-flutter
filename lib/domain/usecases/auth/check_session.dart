import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/repositories/auth_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class CheckSession extends UseCase<bool,NoParams>{
  final AuthRepository _repository;

  CheckSession(this._repository);
  @override
  Future<Either<AppError, bool>> call(NoParams params) async{
    return await _repository.checkSession();
  }

}