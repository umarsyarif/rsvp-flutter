import 'package:dartz/dartz.dart';
import 'package:kopiek_resto/data/models/login_model.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/login_params.dart';

abstract class AuthRepository{
  Future<Either<AppError,String>> login(LoginParams params);
  Future<Either<AppError,bool>> checkSession();
  Future<Either<AppError,User>> getDetailUser();
}