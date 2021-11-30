import 'package:dartz/dartz.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/pucrhase_order_params.dart';

abstract class OrderRepository{
  Future<Either<AppError,bool>> postOrder(PurchaseOrderParams params);
}