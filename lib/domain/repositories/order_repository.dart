import 'package:dartz/dartz.dart';
import 'package:kopiek_resto/data/models/order_model.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/pucrhase_order_params.dart';

abstract class OrderRepository{
  Future<Either<AppError,bool>> postOrder(PurchaseOrderParams params);
  Future<Either<AppError,List<DataOrder>>> getAllOrder();
  Future<Either<AppError,DataOrder>> getDetailOrder(int id);
}