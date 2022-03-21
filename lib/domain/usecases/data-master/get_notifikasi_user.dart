import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/models/notifikasi_model.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/repositories/auth_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class GetNotifikasiUser extends UseCase<List<DataNotifikasi>,int>{
  final AuthRepository _repository;

  GetNotifikasiUser(this._repository);
  @override
  Future<Either<AppError, List<DataNotifikasi>>> call(int params)async {
    return await _repository.getNotifikasiUser(params);
  }
}