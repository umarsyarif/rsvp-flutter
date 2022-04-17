import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/repositories/auth_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class GetUserPoin extends UseCase<int,int>{
  final AuthRepository _repository;
  GetUserPoin(this._repository);
  @override
  Future<Either<AppError, int>> call(int params) async {
    return await _repository.getPoinPengguna(params);
  }

}