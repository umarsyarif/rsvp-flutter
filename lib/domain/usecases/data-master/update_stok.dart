import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/update_stok_params.dart';
import 'package:kopiek_resto/domain/repositories/data_master_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class UpdateStok extends UseCase<bool,UpdateStokParams>{
  final DataMasterRepository _repository;

  UpdateStok(this._repository);
  @override
  Future<Either<AppError, bool>> call(UpdateStokParams params)async {
    return await _repository.updateStokMenu(params);
  }

}