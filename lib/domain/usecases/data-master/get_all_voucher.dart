import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/models/voucher_model.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/repositories/data_master_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class GetAllVoucher extends UseCase<List<DataVoucher>,String>{
  final DataMasterRepository _repository;

  GetAllVoucher(this._repository);
  @override
  Future<Either<AppError, List<DataVoucher>>> call(String params)async {
    return await _repository.getAllVoucher(params);
  }

}