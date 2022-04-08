// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/core/api_client.dart' as _i5;
import '../data/data_sources/auth_local_data_source.dart' as _i3;
import '../data/data_sources/auth_remote_data_source.dart' as _i4;
import '../data/data_sources/order_remote_data_source.dart' as _i14;
import '../data/data_sources/satuan_remote_data_source.dart' as _i20;
import '../data/repositories/auth_repository_impl.dart' as _i7;
import '../data/repositories/data_master_repository_impl.dart' as _i26;
import '../data/repositories/order_repository_impl.dart' as _i16;
import '../domain/repositories/auth_repository.dart' as _i6;
import '../domain/repositories/data_master_repository.dart' as _i25;
import '../domain/repositories/order_repository.dart' as _i15;
import '../domain/usecases/auth/check_session.dart' as _i8;
import '../domain/usecases/auth/get_detail_user.dart' as _i9;
import '../domain/usecases/auth/login.dart' as _i12;
import '../domain/usecases/auth/logout.dart' as _i13;
import '../domain/usecases/auth/register.dart' as _i18;
import '../domain/usecases/client/get_riwayat_poin.dart' as _i32;
import '../domain/usecases/data-master/get_all_voucher.dart' as _i28;
import '../domain/usecases/data-master/get_konfigurasi.dart' as _i30;
import '../domain/usecases/data-master/get_menu.dart' as _i31;
import '../domain/usecases/data-master/get_notifikasi_user.dart' as _i10;
import '../domain/usecases/data-master/get_satuan.dart' as _i33;
import '../domain/usecases/data-master/post_menu.dart' as _i38;
import '../domain/usecases/data-master/post_satuan.dart' as _i39;
import '../domain/usecases/data-master/post_voucher.dart' as _i40;
import '../domain/usecases/data-master/set_active_menu.dart' as _i43;
import '../domain/usecases/data-master/set_active_voucher.dart' as _i44;
import '../domain/usecases/data-master/update_konfigurasi.dart' as _i46;
import '../domain/usecases/data-master/update_notifikasi.dart' as _i45;
import '../domain/usecases/order/count_order.dart' as _i24;
import '../domain/usecases/order/get_all_order.dart' as _i27;
import '../domain/usecases/order/get_detail_order.dart' as _i29;
import '../domain/usecases/order/post_order.dart' as _i17;
import '../domain/usecases/order/update_status.dart' as _i21;
import '../presentation/blocs/admin/home/home_admin_bloc.dart' as _i34;
import '../presentation/blocs/admin/konfigurasi/konfigurasi_bloc.dart' as _i50;
import '../presentation/blocs/admin/order/order_bloc.dart' as _i36;
import '../presentation/blocs/admin/voucher/voucher_bloc.dart' as _i47;
import '../presentation/blocs/auth/auth_bloc.dart' as _i23;
import '../presentation/blocs/client/account/account_bloc.dart' as _i22;
import '../presentation/blocs/client/checkout/checkout_bloc.dart' as _i48;
import '../presentation/blocs/client/dashboard/dashboard_client_bloc.dart'
    as _i49;
import '../presentation/blocs/client/order-detail/order_detail_bloc.dart'
    as _i37;
import '../presentation/blocs/client/riwayat-poin/riwayat_poin_bloc.dart'
    as _i41;
import '../presentation/blocs/loading/loading_bloc.dart' as _i11;
import '../presentation/blocs/login/login_bloc.dart' as _i35;
import '../presentation/blocs/menu/menu_bloc.dart' as _i51;
import '../presentation/blocs/notifikasi/notifikasi_bloc.dart' as _i52;
import '../presentation/blocs/register/register_bloc.dart' as _i19;
import '../presentation/blocs/satuan/satuan_bloc.dart'
    as _i42; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i11.LoadingBloc>(_i11.LoadingBloc());
  gh.lazySingleton<_i12.Login>(() => _i12.Login(get<_i6.AuthRepository>()));
  gh.lazySingleton<_i13.Logout>(() => _i13.Logout(get<_i6.AuthRepository>()));
  gh.lazySingleton<_i14.OrderRemoteDataSource>(
      () => _i14.OrderRemoteDataSourceImpl(get<_i5.ApiClient>()));
  gh.lazySingleton<_i15.OrderRepository>(
      () => _i16.OrderRepositoryImpl(get<_i14.OrderRemoteDataSource>()));
  gh.lazySingleton<_i17.PostOrder>(
      () => _i17.PostOrder(get<_i15.OrderRepository>()));
  gh.lazySingleton<_i18.Register>(
      () => _i18.Register(get<_i6.AuthRepository>()));
  gh.factory<_i19.RegisterBloc>(
      () => _i19.RegisterBloc(get<_i18.Register>(), get<_i11.LoadingBloc>()));
  gh.lazySingleton<_i20.SatuanRemoteDataSource>(
      () => _i20.SatuanRemoteDataSourceImpl(get<_i5.ApiClient>()));
  gh.lazySingleton<_i21.UpdateStatus>(
      () => _i21.UpdateStatus(get<_i15.OrderRepository>()));
  gh.factory<_i22.AccountBloc>(() => _i22.AccountBloc(
      get<_i9.GetDetailUser>(), get<_i13.Logout>(), get<_i11.LoadingBloc>()));
  gh.factory<_i23.AuthBloc>(() => _i23.AuthBloc(get<_i11.LoadingBloc>(),
      get<_i12.Login>(), get<_i8.CheckSession>(), get<_i9.GetDetailUser>()));
  gh.lazySingleton<_i24.CountOrder>(
      () => _i24.CountOrder(get<_i15.OrderRepository>()));
  gh.lazySingleton<_i25.DataMasterRepository>(
      () => _i26.DataMasterRepositoryImpl(get<_i20.SatuanRemoteDataSource>()));
  gh.lazySingleton<_i27.GetAllOrder>(
      () => _i27.GetAllOrder(get<_i15.OrderRepository>()));
  gh.lazySingleton<_i28.GetAllVoucher>(
      () => _i28.GetAllVoucher(get<_i25.DataMasterRepository>()));
  gh.lazySingleton<_i29.GetDetailOrder>(
      () => _i29.GetDetailOrder(get<_i15.OrderRepository>()));
  gh.lazySingleton<_i30.GetKonfigurasi>(
      () => _i30.GetKonfigurasi(get<_i25.DataMasterRepository>()));
  gh.lazySingleton<_i31.GetMenu>(
      () => _i31.GetMenu(get<_i25.DataMasterRepository>()));
  gh.lazySingleton<_i32.GetRiwayatPoin>(
      () => _i32.GetRiwayatPoin(get<_i15.OrderRepository>()));
  gh.lazySingleton<_i33.GetSatuan>(
      () => _i33.GetSatuan(get<_i25.DataMasterRepository>()));
  gh.factory<_i34.HomeAdminBloc>(() => _i34.HomeAdminBloc(
      get<_i13.Logout>(),
      get<_i11.LoadingBloc>(),
      get<_i24.CountOrder>(),
      get<_i31.GetMenu>(),
      get<_i10.GetNotifikasiUser>(),
      get<_i9.GetDetailUser>(),
      get<_i28.GetAllVoucher>()));
  gh.factory<_i35.LoginBloc>(() => _i35.LoginBloc(
      get<_i12.Login>(), get<_i11.LoadingBloc>(), get<_i23.AuthBloc>()));
  gh.factory<_i36.OrderBloc>(() => _i36.OrderBloc(
      get<_i27.GetAllOrder>(),
      get<_i29.GetDetailOrder>(),
      get<_i9.GetDetailUser>(),
      get<_i21.UpdateStatus>(),
      get<_i11.LoadingBloc>()));
  gh.factory<_i37.OrderDetailBloc>(() => _i37.OrderDetailBloc(
      get<_i31.GetMenu>(), get<_i21.UpdateStatus>(), get<_i9.GetDetailUser>()));
  gh.lazySingleton<_i38.PostMenu>(
      () => _i38.PostMenu(get<_i25.DataMasterRepository>()));
  gh.lazySingleton<_i39.PostSatuan>(
      () => _i39.PostSatuan(get<_i25.DataMasterRepository>()));
  gh.lazySingleton<_i40.PostVoucher>(
      () => _i40.PostVoucher(get<_i25.DataMasterRepository>()));
  gh.factory<_i41.RiwayatPoinBloc>(() => _i41.RiwayatPoinBloc(
      get<_i32.GetRiwayatPoin>(), get<_i9.GetDetailUser>()));
  gh.factory<_i42.SatuanBloc>(() => _i42.SatuanBloc(
      get<_i39.PostSatuan>(), get<_i11.LoadingBloc>(), get<_i33.GetSatuan>()));
  gh.lazySingleton<_i43.SetActiveMenu>(
      () => _i43.SetActiveMenu(get<_i25.DataMasterRepository>()));
  gh.lazySingleton<_i44.SetActiveVoucher>(
      () => _i44.SetActiveVoucher(get<_i25.DataMasterRepository>()));
  gh.lazySingleton<_i45.UpdaeNotifikasi>(
      () => _i45.UpdaeNotifikasi(get<_i25.DataMasterRepository>()));
  gh.lazySingleton<_i46.UpdateKonfigurasi>(
      () => _i46.UpdateKonfigurasi(get<_i25.DataMasterRepository>()));
  gh.factory<_i47.VoucherBloc>(() => _i47.VoucherBloc(
      get<_i11.LoadingBloc>(),
      get<_i40.PostVoucher>(),
      get<_i28.GetAllVoucher>(),
      get<_i44.SetActiveVoucher>()));
  gh.factory<_i48.CheckoutBloc>(() => _i48.CheckoutBloc(
      get<_i17.PostOrder>(),
      get<_i11.LoadingBloc>(),
      get<_i28.GetAllVoucher>(),
      get<_i9.GetDetailUser>()));
  gh.factory<_i49.DashboardClientBloc>(() => _i49.DashboardClientBloc(
      get<_i28.GetAllVoucher>(),
      get<_i9.GetDetailUser>(),
      get<_i10.GetNotifikasiUser>()));
  gh.factory<_i50.KonfigurasiBloc>(() => _i50.KonfigurasiBloc(
      get<_i30.GetKonfigurasi>(),
      get<_i13.Logout>(),
      get<_i11.LoadingBloc>(),
      get<_i46.UpdateKonfigurasi>()));
  gh.factory<_i51.MenuBloc>(() => _i51.MenuBloc(
      get<_i11.LoadingBloc>(),
      get<_i33.GetSatuan>(),
      get<_i38.PostMenu>(),
      get<_i31.GetMenu>(),
      get<_i43.SetActiveMenu>()));
  gh.factory<_i52.NotifikasiBloc>(() => _i52.NotifikasiBloc(
      get<_i10.GetNotifikasiUser>(),
      get<_i9.GetDetailUser>(),
      get<_i45.UpdaeNotifikasi>()));
  return get;
}
