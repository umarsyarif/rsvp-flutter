import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/models/menu_model.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/repositories/data_master_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class GetMenu extends UseCase<List<DataMenu>,NoParams>{
  final DataMasterRepository _repository;

  GetMenu(this._repository);
  @override
  Future<Either<AppError, List<DataMenu>>> call(NoParams params)async {
    return await _repository.getMenu();
  }

}