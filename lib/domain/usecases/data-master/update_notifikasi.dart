import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/repositories/data_master_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class UpdaeNotifikasi extends UseCase<bool,int>{
  final DataMasterRepository _repository;

  UpdaeNotifikasi(this._repository);
  @override
  Future<Either<AppError, bool>> call(int params) async {
    return await _repository.updateNotifikasi(params);
  }

}