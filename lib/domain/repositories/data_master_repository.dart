import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:kopiek_resto/data/models/konfigurasi_model.dart';
import 'package:kopiek_resto/data/models/menu_model.dart';
import 'package:kopiek_resto/data/models/satuan_model.dart';
import 'package:kopiek_resto/data/models/voucher_model.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/menu_params.dart';
import 'package:kopiek_resto/domain/entities/satuan_params.dart';
import 'package:kopiek_resto/domain/entities/update_menu_params.dart';
import 'package:kopiek_resto/domain/entities/update_stok_params.dart';
import 'package:kopiek_resto/domain/entities/voucher_params.dart';

abstract class DataMasterRepository{
  Future<Either<AppError,List<DataSatuan>>> getSatuan();
  Future<Either<AppError,bool>> postSatuan(SatuanParams params);
  Future<Either<AppError,bool>> postMenu(FormData data);
  Future<Either<AppError,List<DataMenu>>> getMenu(String params);
  Future<Either<AppError,DataKonfigurasi>> getKonfigurasi();
  Future<Either<AppError,bool>> postVoucher(FormData data);
  Future<Either<AppError,List<DataVoucher>>> getAllVoucher(String params);
  Future<Either<AppError,bool>> updateKonfigurasi(Map<String,dynamic> params);
  Future<Either<AppError,bool>> updateNotifikasi(int params);
  Future<Either<AppError,bool>> setActvieMenu(UpdateActiveMenuParams params);
  Future<Either<AppError,bool>> setActiveVoucher(UpdateActiveMenuParams params);
  Future<Either<AppError,bool>> updateStokMenu(UpdateStokParams params);
  Future<Either<AppError,bool>> updateMenu(MenuParams params);
  Future<Either<AppError,String>> uploadFile(FormData data);
  Future<Either<AppError,bool>> updateVoucher(VoucherParams params);
}