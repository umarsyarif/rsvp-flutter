import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:kopiek_resto/data/models/konfigurasi_model.dart';
import 'package:kopiek_resto/data/models/menu_model.dart';
import 'package:kopiek_resto/data/models/satuan_model.dart';
import 'package:kopiek_resto/data/models/voucher_model.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/satuan_params.dart';

abstract class DataMasterRepository{
  Future<Either<AppError,List<DataSatuan>>> getSatuan();
  Future<Either<AppError,bool>> postSatuan(SatuanParams params);
  Future<Either<AppError,bool>> postMenu(FormData data);
  Future<Either<AppError,List<DataMenu>>> getMenu();
  Future<Either<AppError,DataKonfigurasi>> getKonfigurasi();
  Future<Either<AppError,bool>> postVoucher(FormData data);
  Future<Either<AppError,List<DataVoucher>>> getAllVoucher();
}