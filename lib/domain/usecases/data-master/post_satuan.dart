import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/satuan_params.dart';
import 'package:kopiek_resto/domain/repositories/data_master_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class PostSatuan extends UseCase<bool,SatuanParams>{
  final DataMasterRepository _repository;
  PostSatuan(this._repository);
  @override
  Future<Either<AppError, bool>> call(SatuanParams params)async {
    return await _repository.postSatuan(params);
  }

}