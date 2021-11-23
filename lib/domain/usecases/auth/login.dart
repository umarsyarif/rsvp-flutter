import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/login_params.dart';
import 'package:kopiek_resto/domain/repositories/auth_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class Login extends UseCase<String,LoginParams>{
  final AuthRepository repository;
  Login(this.repository);
  @override
  Future<Either<AppError, String>> call(LoginParams params) async{
    return await repository.login(params);
  }
}