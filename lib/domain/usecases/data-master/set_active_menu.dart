import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/update_menu_params.dart';
import 'package:kopiek_resto/domain/repositories/data_master_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class SetActiveMenu extends UseCase<bool,UpdateActiveMenuParams>{
  final DataMasterRepository _repository;

  SetActiveMenu(this._repository);
  @override
  Future<Either<AppError, bool>> call(UpdateActiveMenuParams params)async {
    return await _repository.setActvieMenu(params);
  }

}