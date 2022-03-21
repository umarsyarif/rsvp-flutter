import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/repositories/data_master_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class UpdateKonfigurasi extends UseCase<bool,Map<String,dynamic>>{
  final DataMasterRepository _repository;

  UpdateKonfigurasi(this._repository);

  @override
  Future<Either<AppError, bool>> call(Map<String, dynamic> params)async {
    return await _repository.updateKonfigurasi(params);
  }

}