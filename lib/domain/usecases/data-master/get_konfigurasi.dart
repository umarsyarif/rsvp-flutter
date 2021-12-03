import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/models/konfigurasi_model.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/repositories/data_master_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class GetKonfigurasi extends UseCase<DataKonfigurasi,NoParams>{
  final DataMasterRepository _repository;

  GetKonfigurasi(this._repository);
  @override
  Future<Either<AppError, DataKonfigurasi>> call(NoParams params)async {
    return await _repository.getKonfigurasi();
  }

}