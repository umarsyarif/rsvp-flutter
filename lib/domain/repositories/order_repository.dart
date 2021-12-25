import 'package:dartz/dartz.dart';
import 'package:kopiek_resto/data/models/order_model.dart';
import 'package:kopiek_resto/data/models/riwayat_poin_model.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/list_order_params.dart';
import 'package:kopiek_resto/domain/entities/pucrhase_order_params.dart';
import 'package:kopiek_resto/domain/entities/update_status_params.dart';

abstract class OrderRepository{
  Future<Either<AppError,String>> postOrder(PurchaseOrderParams params);
  Future<Either<AppError,List<DataOrder>>> getAllOrder(ListOrderParams params);
  Future<Either<AppError,DataOrder>> getDetailOrder(int id);
  Future<Either<AppError,bool>> updateStatus(UpdateStatusParams params);
  Future<Either<AppError,List<DataRiwayatPoin>>> getRiwayatPoin(String idPengguna);
  Future<Either<AppError,int>> getCountOrder(String status);
}