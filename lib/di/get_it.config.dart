// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/core/api_client.dart' as _i5;
import '../data/data_sources/auth_local_data_source.dart' as _i3;
import '../data/data_sources/auth_remote_data_source.dart' as _i4;
import '../data/data_sources/order_remote_data_source.dart' as _i15;
import '../data/data_sources/satuan_remote_data_source.dart' as _i21;
import '../data/repositories/auth_repository_impl.dart' as _i7;
import '../data/repositories/data_master_repository_impl.dart' as _i27;
import '../data/repositories/order_repository_impl.dart' as _i17;
import '../domain/repositories/auth_repository.dart' as _i6;
import '../domain/repositories/data_master_repository.dart' as _i26;
import '../domain/repositories/order_repository.dart' as _i16;
import '../domain/usecases/auth/check_session.dart' as _i8;
import '../domain/usecases/auth/get_detail_user.dart' as _i9;
import '../domain/usecases/auth/login.dart' as _i12;
import '../domain/usecases/auth/logout.dart' as _i13;
import '../domain/usecases/auth/register.dart' as _i19;
import '../domain/usecases/client/get_riwayat_poin.dart' as _i33;
import '../domain/usecases/data-master/get_all_voucher.dart' as _i29;
import '../domain/usecases/data-master/get_konfigurasi.dart' as _i31;
import '../domain/usecases/data-master/get_menu.dart' as _i32;
import '../domain/usecases/data-master/get_notifikasi_user.dart' as _i10;
import '../domain/usecases/data-master/get_satuan.dart' as _i34;
import '../domain/usecases/data-master/post_menu.dart' as _i39;
import '../domain/usecases/data-master/post_satuan.dart' as _i40;
import '../domain/usecases/data-master/post_voucher.dart' as _i41;
import '../domain/usecases/data-master/update_konfigurasi.dart' as _i44;
import '../domain/usecases/order/count_order.dart' as _i25;
import '../domain/usecases/order/get_all_order.dart' as _i28;
import '../domain/usecases/order/get_detail_order.dart' as _i30;
import '../domain/usecases/order/post_order.dart' as _i18;
import '../domain/usecases/order/update_status.dart' as _i22;
import '../presentation/blocs/admin/home/home_admin_bloc.dart' as _i35;
import '../presentation/blocs/admin/konfigurasi/konfigurasi_bloc.dart' as _i48;
import '../presentation/blocs/admin/order/order_bloc.dart' as _i37;
import '../presentation/blocs/admin/voucher/voucher_bloc.dart' as _i45;
import '../presentation/blocs/auth/auth_bloc.dart' as _i24;
import '../presentation/blocs/client/account/account_bloc.dart' as _i23;
import '../presentation/blocs/client/checkout/checkout_bloc.dart' as _i46;
import '../presentation/blocs/client/dashboard/dashboard_client_bloc.dart'
    as _i47;
import '../presentation/blocs/client/order-detail/order_detail_bloc.dart'
    as _i38;
import '../presentation/blocs/client/riwayat-poin/riwayat_poin_bloc.dart'
    as _i42;
import '../presentation/blocs/loading/loading_bloc.dart' as _i11;
import '../presentation/blocs/login/login_bloc.dart' as _i36;
import '../presentation/blocs/menu/menu_bloc.dart' as _i49;
import '../presentation/blocs/notifikasi/notifikasi_bloc.dart' as _i14;
import '../presentation/blocs/register/register_bloc.dart' as _i20;
import '../presentation/blocs/satuan/satuan_bloc.dart'
    as _i43; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i14.NotifikasiBloc>(() => _i14.NotifikasiBloc(
      get<_i10.GetNotifikasiUser>(), get<_i9.GetDetailUser>()));
  gh.lazySingleton<_i15.OrderRemoteDataSource>(
      () => _i15.OrderRemoteDataSourceImpl(get<_i5.ApiClient>()));
  gh.lazySingleton<_i16.OrderRepository>(
      () => _i17.OrderRepositoryImpl(get<_i15.OrderRemoteDataSource>()));
  gh.lazySingleton<_i18.PostOrder>(
      () => _i18.PostOrder(get<_i16.OrderRepository>()));
  gh.lazySingleton<_i19.Register>(
      () => _i19.Register(get<_i6.AuthRepository>()));
  gh.factory<_i20.RegisterBloc>(
      () => _i20.RegisterBloc(get<_i19.Register>(), get<_i11.LoadingBloc>()));
  gh.lazySingleton<_i21.SatuanRemoteDataSource>(
      () => _i21.SatuanRemoteDataSourceImpl(get<_i5.ApiClient>()));
  gh.lazySingleton<_i22.UpdateStatus>(
      () => _i22.UpdateStatus(get<_i16.OrderRepository>()));
  gh.factory<_i23.AccountBloc>(() => _i23.AccountBloc(
      get<_i9.GetDetailUser>(), get<_i13.Logout>(), get<_i11.LoadingBloc>()));
  gh.factory<_i24.AuthBloc>(() => _i24.AuthBloc(get<_i11.LoadingBloc>(),
      get<_i12.Login>(), get<_i8.CheckSession>(), get<_i9.GetDetailUser>()));
  gh.lazySingleton<_i25.CountOrder>(
      () => _i25.CountOrder(get<_i16.OrderRepository>()));
  gh.lazySingleton<_i26.DataMasterRepository>(
      () => _i27.DataMasterRepositoryImpl(get<_i21.SatuanRemoteDataSource>()));
  gh.lazySingleton<_i28.GetAllOrder>(
      () => _i28.GetAllOrder(get<_i16.OrderRepository>()));
  gh.lazySingleton<_i29.GetAllVoucher>(
      () => _i29.GetAllVoucher(get<_i26.DataMasterRepository>()));
  gh.lazySingleton<_i30.GetDetailOrder>(
      () => _i30.GetDetailOrder(get<_i16.OrderRepository>()));
  gh.lazySingleton<_i31.GetKonfigurasi>(
      () => _i31.GetKonfigurasi(get<_i26.DataMasterRepository>()));
  gh.lazySingleton<_i32.GetMenu>(
      () => _i32.GetMenu(get<_i26.DataMasterRepository>()));
  gh.lazySingleton<_i33.GetRiwayatPoin>(
      () => _i33.GetRiwayatPoin(get<_i16.OrderRepository>()));
  gh.lazySingleton<_i34.GetSatuan>(
      () => _i34.GetSatuan(get<_i26.DataMasterRepository>()));
  gh.factory<_i35.HomeAdminBloc>(() => _i35.HomeAdminBloc(get<_i13.Logout>(),
      get<_i11.LoadingBloc>(), get<_i25.CountOrder>(), get<_i32.GetMenu>()));
  gh.factory<_i36.LoginBloc>(() => _i36.LoginBloc(
      get<_i12.Login>(), get<_i11.LoadingBloc>(), get<_i24.AuthBloc>()));
  gh.factory<_i37.OrderBloc>(() => _i37.OrderBloc(
      get<_i28.GetAllOrder>(),
      get<_i30.GetDetailOrder>(),
      get<_i9.GetDetailUser>(),
      get<_i22.UpdateStatus>(),
      get<_i11.LoadingBloc>()));
  gh.factory<_i38.OrderDetailBloc>(() => _i38.OrderDetailBloc(
      get<_i32.GetMenu>(), get<_i22.UpdateStatus>(), get<_i9.GetDetailUser>()));
  gh.lazySingleton<_i39.PostMenu>(
      () => _i39.PostMenu(get<_i26.DataMasterRepository>()));
  gh.lazySingleton<_i40.PostSatuan>(
      () => _i40.PostSatuan(get<_i26.DataMasterRepository>()));
  gh.lazySingleton<_i41.PostVoucher>(
      () => _i41.PostVoucher(get<_i26.DataMasterRepository>()));
  gh.factory<_i42.RiwayatPoinBloc>(() => _i42.RiwayatPoinBloc(
      get<_i33.GetRiwayatPoin>(), get<_i9.GetDetailUser>()));
  gh.factory<_i43.SatuanBloc>(() => _i43.SatuanBloc(
      get<_i40.PostSatuan>(), get<_i11.LoadingBloc>(), get<_i34.GetSatuan>()));
  gh.lazySingleton<_i44.UpdateKonfigurasi>(
      () => _i44.UpdateKonfigurasi(get<_i26.DataMasterRepository>()));
  gh.factory<_i45.VoucherBloc>(() => _i45.VoucherBloc(get<_i11.LoadingBloc>(),
      get<_i41.PostVoucher>(), get<_i29.GetAllVoucher>()));
  gh.factory<_i46.CheckoutBloc>(() => _i46.CheckoutBloc(
      get<_i18.PostOrder>(),
      get<_i11.LoadingBloc>(),
      get<_i29.GetAllVoucher>(),
      get<_i9.GetDetailUser>()));
  gh.factory<_i47.DashboardClientBloc>(
      () => _i47.DashboardClientBloc(get<_i29.GetAllVoucher>()));
  gh.factory<_i48.KonfigurasiBloc>(() => _i48.KonfigurasiBloc(
      get<_i31.GetKonfigurasi>(),
      get<_i13.Logout>(),
      get<_i11.LoadingBloc>(),
      get<_i44.UpdateKonfigurasi>()));
  gh.factory<_i49.MenuBloc>(() => _i49.MenuBloc(get<_i11.LoadingBloc>(),
      get<_i34.GetSatuan>(), get<_i39.PostMenu>(), get<_i32.GetMenu>()));
  return get;
}
