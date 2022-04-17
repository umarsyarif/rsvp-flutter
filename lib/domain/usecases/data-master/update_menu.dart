import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/menu_params.dart';
import 'package:kopiek_resto/domain/repositories/data_master_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class UpdateMenu extends UseCase<bool,MenuParams>{
  final DataMasterRepository _repository;

  UpdateMenu(this._repository);
  @override
  Future<Either<AppError, bool>> call(MenuParams params) async {
   return await _repository.updateMenu(params);
  }
}