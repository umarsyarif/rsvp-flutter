// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/core/api_client.dart' as _i5;
import '../data/data_sources/auth_local_data_source.dart' as _i3;
import '../data/data_sources/auth_remote_data_source.dart' as _i4;
import '../data/data_sources/order_remote_data_source.dart' as _i16;
import '../data/data_sources/satuan_remote_data_source.dart' as _i23;
import '../data/repositories/auth_repository_impl.dart' as _i7;
import '../data/repositories/data_master_repository_impl.dart' as _i32;
import '../data/repositories/order_repository_impl.dart' as _i18;
import '../domain/repositories/auth_repository.dart' as _i6;
import '../domain/repositories/data_master_repository.dart' as _i31;
import '../domain/repositories/order_repository.dart' as _i17;
import '../domain/usecases/auth/check_session.dart' as _i8;
import '../domain/usecases/auth/get_detail_user.dart' as _i9;
import '../domain/usecases/auth/get_redeemed_voucher.dart' as _i11;
import '../domain/usecases/auth/login.dart' as _i14;
import '../domain/usecases/auth/logout.dart' as _i15;
import '../domain/usecases/auth/register.dart' as _i21;
import '../domain/usecases/auth/save_redeemed_voucher.dart' as _i24;
import '../domain/usecases/client/get_riwayat_poin.dart' as _i39;
import '../domain/usecases/client/get_user_poin.dart' as _i12;
import '../domain/usecases/data-master/get_all_voucher.dart' as _i35;
import '../domain/usecases/data-master/get_konfigurasi.dart' as _i37;
import '../domain/usecases/data-master/get_menu.dart' as _i38;
import '../domain/usecases/data-master/get_notifikasi_user.dart' as _i10;
import '../domain/usecases/data-master/get_satuan.dart' as _i40;
import '../domain/usecases/data-master/post_menu.dart' as _i45;
import '../domain/usecases/data-master/post_satuan.dart' as _i46;
import '../domain/usecases/data-master/post_voucher.dart' as _i47;
import '../domain/usecases/data-master/set_active_menu.dart' as _i52;
import '../domain/usecases/data-master/set_active_voucher.dart' as _i53;
import '../domain/usecases/data-master/update_konfigurasi.dart' as _i55;
import '../domain/usecases/data-master/update_menu.dart' as _i56;
import '../domain/usecases/data-master/update_notifikasi.dart' as _i54;
import '../domain/usecases/data-master/update_stok.dart' as _i57;
import '../domain/usecases/data-master/update_voucher.dart' as _i58;
import '../domain/usecases/data-master/upload_file.dart' as _i59;
import '../domain/usecases/order/check_rating.dart' as _i28;
import '../domain/usecases/order/check_seat.dart' as _i29;
import '../domain/usecases/order/count_order.dart' as _i30;
import '../domain/usecases/order/get_all_order.dart' as _i33;
import '../domain/usecases/order/get_all_rating.dart' as _i34;
import '../domain/usecases/order/get_detail_order.dart' as _i36;
import '../domain/usecases/order/post_order.dart' as _i19;
import '../domain/usecases/order/post_rating.dart' as _i20;
import '../domain/usecases/order/update_status.dart' as _i25;
import '../presentation/blocs/admin/home/home_admin_bloc.dart' as _i41;
import '../presentation/blocs/admin/konfigurasi/konfigurasi_bloc.dart' as _i63;
import '../presentation/blocs/admin/order/order_bloc.dart' as _i43;
import '../presentation/blocs/admin/rating/rating_bloc.dart' as _i48;
import '../presentation/blocs/admin/update-menu/update_menu_bloc.dart' as _i66;
import '../presentation/blocs/admin/update_voucher/update_voucher_bloc.dart'
    as _i67;
import '../presentation/blocs/admin/voucher/voucher_bloc.dart' as _i60;
import '../presentation/blocs/auth/auth_bloc.dart' as _i27;
import '../presentation/blocs/client/account/account_bloc.dart' as _i26;
import '../presentation/blocs/client/checkout/checkout_bloc.dart' as _i61;
import '../presentation/blocs/client/dashboard/dashboard_client_bloc.dart'
    as _i62;
import '../presentation/blocs/client/order-detail/order_detail_bloc.dart'
    as _i44;
import '../presentation/blocs/client/redeem_voucher/redeem_voucher_bloc.dart'
    as _i49;
import '../presentation/blocs/client/riwayat-poin/riwayat_poin_bloc.dart'
    as _i50;
import '../presentation/blocs/loading/loading_bloc.dart' as _i13;
import '../presentation/blocs/login/login_bloc.dart' as _i42;
import '../presentation/blocs/menu/menu_bloc.dart' as _i64;
import '../presentation/blocs/notifikasi/notifikasi_bloc.dart' as _i65;
import '../presentation/blocs/register/register_bloc.dart' as _i22;
import '../presentation/blocs/satuan/satuan_bloc.dart'
    as _i51; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initDi(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AuthLocalDataSource>(
      () => _i3.AuthLocalDataSourceImpl());
  gh.lazySingleton<_i4.AuthRemoteDataSource>(
      () => _i4.AuthRemoteDataSourceImpl(get<_i5.ApiClient>()));
  gh.lazySingleton<_i6.AuthRepository>(() => _i7.AuthRepositoryImpl(
      get<_i4.AuthRemoteDataSource>(), get<_i3.AuthLocalDataSource>()));
  gh.lazySingleton<_i8.CheckSession>(
      () => _i8.CheckSession(get<_i6.AuthRepository>()));
  gh.lazySingleton<_i9.GetDetailUser>(
      () => _i9.GetDetailUser(get<_i6.AuthRepository>()));
  gh.lazySingleton<_i10.GetNotifikasiUser>(
      () => _i10.GetNotifikasiUser(get<_i6.AuthRepository>()));
  gh.lazySingleton<_i11.GetRedeemedVoucher>(
      () => _i11.GetRedeemedVoucher(get<_i6.AuthRepository>()));
  gh.lazySingleton<_i12.GetUserPoin>(
      () => _i12.GetUserPoin(get<_i6.AuthRepository>()));
  gh.singleton<_i13.LoadingBloc>(_i13.LoadingBloc());
  gh.lazySingleton<_i14.Login>(() => _i14.Login(get<_i6.AuthRepository>()));
  gh.lazySingleton<_i15.Logout>(() => _i15.Logout(get<_i6.AuthRepository>()));
  gh.lazySingleton<_i16.OrderRemoteDataSource>(
      () => _i16.OrderRemoteDataSourceImpl(get<_i5.ApiClient>()));
  gh.lazySingleton<_i17.OrderRepository>(
      () => _i18.OrderRepositoryImpl(get<_i16.OrderRemoteDataSource>()));
  gh.lazySingleton<_i19.PostOrder>(
      () => _i19.PostOrder(get<_i17.OrderRepository>()));
  gh.lazySingleton<_i20.PostRating>(
      () => _i20.PostRating(get<_i17.OrderRepository>()));
  gh.lazySingleton<_i21.Register>(
      () => _i21.Register(get<_i6.AuthRepository>()));
  gh.factory<_i22.RegisterBloc>(
      () => _i22.RegisterBloc(get<_i21.Register>(), get<_i13.LoadingBloc>()));
  gh.lazySingleton<_i23.SatuanRemoteDataSource>(
      () => _i23.SatuanRemoteDataSourceImpl(get<_i5.ApiClient>()));
  gh.lazySingleton<_i24.SaveRedeemedVoucher>(
      () => _i24.SaveRedeemedVoucher(get<_i6.AuthRepository>()));
  gh.lazySingleton<_i25.UpdateStatus>(
      () => _i25.UpdateStatus(get<_i17.OrderRepository>()));
  gh.factory<_i26.AccountBloc>(() => _i26.AccountBloc(
      get<_i9.GetDetailUser>(), get<_i15.Logout>(), get<_i13.LoadingBloc>()));
  gh.factory<_i27.AuthBloc>(() => _i27.AuthBloc(get<_i13.LoadingBloc>(),
      get<_i14.Login>(), get<_i8.CheckSession>(), get<_i9.GetDetailUser>()));
  gh.lazySingleton<_i28.CheckRating>(
      () => _i28.CheckRating(get<_i17.OrderRepository>()));
  gh.lazySingleton<_i29.CheckSeat>(
      () => _i29.CheckSeat(get<_i17.OrderRepository>()));
  gh.lazySingleton<_i30.CountOrder>(
      () => _i30.CountOrder(get<_i17.OrderRepository>()));
  gh.lazySingleton<_i31.DataMasterRepository>(
      () => _i32.DataMasterRepositoryImpl(get<_i23.SatuanRemoteDataSource>()));
  gh.lazySingleton<_i33.GetAllOrder>(
      () => _i33.GetAllOrder(get<_i17.OrderRepository>()));
  gh.lazySingleton<_i34.GetAllRating>(
      () => _i34.GetAllRating(get<_i17.OrderRepository>()));
  gh.lazySingleton<_i35.GetAllVoucher>(
      () => _i35.GetAllVoucher(get<_i31.DataMasterRepository>()));
  gh.lazySingleton<_i36.GetDetailOrder>(
      () => _i36.GetDetailOrder(get<_i17.OrderRepository>()));
  gh.lazySingleton<_i37.GetKonfigurasi>(
      () => _i37.GetKonfigurasi(get<_i31.DataMasterRepository>()));
  gh.lazySingleton<_i38.GetMenu>(
      () => _i38.GetMenu(get<_i31.DataMasterRepository>()));
  gh.lazySingleton<_i39.GetRiwayatPoin>(
      () => _i39.GetRiwayatPoin(get<_i17.OrderRepository>()));
  gh.lazySingleton<_i40.GetSatuan>(
      () => _i40.GetSatuan(get<_i31.DataMasterRepository>()));
  gh.factory<_i41.HomeAdminBloc>(() => _i41.HomeAdminBloc(
      get<_i15.Logout>(),
      get<_i13.LoadingBloc>(),
      get<_i30.CountOrder>(),
      get<_i38.GetMenu>(),
      get<_i10.GetNotifikasiUser>(),
      get<_i9.GetDetailUser>(),
      get<_i35.GetAllVoucher>()));
  gh.factory<_i42.LoginBloc>(() => _i42.LoginBloc(
      get<_i14.Login>(), get<_i13.LoadingBloc>(), get<_i27.AuthBloc>()));
  gh.factory<_i43.OrderBloc>(() => _i43.OrderBloc(
      get<_i33.GetAllOrder>(),
      get<_i36.GetDetailOrder>(),
      get<_i9.GetDetailUser>(),
      get<_i25.UpdateStatus>(),
      get<_i13.LoadingBloc>(),
      get<_i28.CheckRating>(),
      get<_i20.PostRating>()));
  gh.factory<_i44.OrderDetailBloc>(() => _i44.OrderDetailBloc(
      get<_i38.GetMenu>(), get<_i25.UpdateStatus>(), get<_i9.GetDetailUser>()));
  gh.lazySingleton<_i45.PostMenu>(
      () => _i45.PostMenu(get<_i31.DataMasterRepository>()));
  gh.lazySingleton<_i46.PostSatuan>(
      () => _i46.PostSatuan(get<_i31.DataMasterRepository>()));
  gh.lazySingleton<_i47.PostVoucher>(
      () => _i47.PostVoucher(get<_i31.DataMasterRepository>()));
  gh.factory<_i48.RatingBloc>(() => _i48.RatingBloc(get<_i34.GetAllRating>()));
  gh.factory<_i49.RedeemVoucherBloc>(() => _i49.RedeemVoucherBloc(
      get<_i35.GetAllVoucher>(),
      get<_i24.SaveRedeemedVoucher>(),
      get<_i11.GetRedeemedVoucher>(),
      get<_i13.LoadingBloc>()));
  gh.factory<_i50.RiwayatPoinBloc>(() => _i50.RiwayatPoinBloc(
      get<_i39.GetRiwayatPoin>(),
      get<_i9.GetDetailUser>(),
      get<_i12.GetUserPoin>()));
  gh.factory<_i51.SatuanBloc>(() => _i51.SatuanBloc(
      get<_i46.PostSatuan>(), get<_i13.LoadingBloc>(), get<_i40.GetSatuan>()));
  gh.lazySingleton<_i52.SetActiveMenu>(
      () => _i52.SetActiveMenu(get<_i31.DataMasterRepository>()));
  gh.lazySingleton<_i53.SetActiveVoucher>(
      () => _i53.SetActiveVoucher(get<_i31.DataMasterRepository>()));
  gh.lazySingleton<_i54.UpdaeNotifikasi>(
      () => _i54.UpdaeNotifikasi(get<_i31.DataMasterRepository>()));
  gh.lazySingleton<_i55.UpdateKonfigurasi>(
      () => _i55.UpdateKonfigurasi(get<_i31.DataMasterRepository>()));
  gh.lazySingleton<_i56.UpdateMenu>(
      () => _i56.UpdateMenu(get<_i31.DataMasterRepository>()));
  gh.lazySingleton<_i57.UpdateStok>(
      () => _i57.UpdateStok(get<_i31.DataMasterRepository>()));
  gh.lazySingleton<_i58.UpdateVoucher>(
      () => _i58.UpdateVoucher(get<_i31.DataMasterRepository>()));
  gh.lazySingleton<_i59.UploadFile>(
      () => _i59.UploadFile(get<_i31.DataMasterRepository>()));
  gh.factory<_i60.VoucherBloc>(() => _i60.VoucherBloc(
      get<_i13.LoadingBloc>(),
      get<_i47.PostVoucher>(),
      get<_i35.GetAllVoucher>(),
      get<_i53.SetActiveVoucher>()));
  gh.factory<_i61.CheckoutBloc>(() => _i61.CheckoutBloc(
      get<_i19.PostOrder>(),
      get<_i13.LoadingBloc>(),
      get<_i35.GetAllVoucher>(),
      get<_i9.GetDetailUser>(),
      get<_i12.GetUserPoin>(),
      get<_i11.GetRedeemedVoucher>()));
  gh.factory<_i62.DashboardClientBloc>(() => _i62.DashboardClientBloc(
      get<_i35.GetAllVoucher>(),
      get<_i9.GetDetailUser>(),
      get<_i10.GetNotifikasiUser>(),
      get<_i38.GetMenu>()));
  gh.factory<_i63.KonfigurasiBloc>(() => _i63.KonfigurasiBloc(
      get<_i37.GetKonfigurasi>(),
      get<_i15.Logout>(),
      get<_i13.LoadingBloc>(),
      get<_i55.UpdateKonfigurasi>(),
      get<_i29.CheckSeat>()));
  gh.factory<_i64.MenuBloc>(() => _i64.MenuBloc(
      get<_i13.LoadingBloc>(),
      get<_i40.GetSatuan>(),
      get<_i45.PostMenu>(),
      get<_i38.GetMenu>(),
      get<_i52.SetActiveMenu>(),
      get<_i57.UpdateStok>()));
  gh.factory<_i65.NotifikasiBloc>(() => _i65.NotifikasiBloc(
      get<_i10.GetNotifikasiUser>(),
      get<_i9.GetDetailUser>(),
      get<_i54.UpdaeNotifikasi>()));
  gh.factory<_i66.UpdateMenuBloc>(() => _i66.UpdateMenuBloc(
      get<_i56.UpdateMenu>(),
      get<_i59.UploadFile>(),
      get<_i40.GetSatuan>(),
      get<_i13.LoadingBloc>()));
  gh.factory<_i67.UpdateVoucherBloc>(() => _i67.UpdateVoucherBloc(
      get<_i13.LoadingBloc>(),
      get<_i58.UpdateVoucher>(),
      get<_i59.UploadFile>()));
  return get;
}
