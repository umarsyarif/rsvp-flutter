import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/models/voucher_model.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/repositories/auth_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class SaveRedeemedVoucher extends UseCase<bool,DataVoucher>{
  final AuthRepository _repository;

  SaveRedeemedVoucher(this._repository);
  @override
  Future<Either<AppError, bool>> call(DataVoucher params) async {
    return await _repository.saveRedeemedVoucher(params);
  }

}