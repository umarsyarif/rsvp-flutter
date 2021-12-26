// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/core/api_client.dart' as _i5;
import '../data/data_sources/auth_local_data_source.dart' as _i3;
import '../data/data_sources/auth_remote_data_source.dart' as _i4;
import '../data/data_sources/order_remote_data_source.dart' as _i13;
import '../data/data_sources/satuan_remote_data_source.dart' as _i19;
import '../data/repositories/auth_repository_impl.dart' as _i7;
import '../data/repositories/data_master_repository_impl.dart' as _i25;
import '../data/repositories/order_repository_impl.dart' as _i15;
import '../domain/repositories/auth_repository.dart' as _i6;
import '../domain/repositories/data_master_repository.dart' as _i24;
import '../domain/repositories/order_repository.dart' as _i14;
import '../domain/usecases/auth/check_session.dart' as _i8;
import '../domain/usecases/auth/get_detail_user.dart' as _i9;
import '../domain/usecases/auth/login.dart' as _i11;
import '../domain/usecases/auth/logout.dart' as _i12;
import '../domain/usecases/auth/register.dart' as _i17;
import '../domain/usecases/client/get_riwayat_poin.dart' as _i31;
import '../domain/usecases/data-master/get_all_voucher.dart' as _i27;
import '../domain/usecases/data-master/get_konfigurasi.dart' as _i29;
import '../domain/usecases/data-master/get_menu.dart' as _i30;
import '../domain/usecases/data-master/get_satuan.dart' as _i32;
import '../domain/usecases/data-master/post_menu.dart' as _i38;
import '../domain/usecases/data-master/post_satuan.dart' as _i39;
import '../domain/usecases/data-master/post_voucher.dart' as _i40;
import '../domain/usecases/order/count_order.dart' as _i23;
import '../domain/usecases/order/get_all_order.dart' as _i26;
import '../domain/usecases/order/get_detail_order.dart' as _i28;
import '../domain/usecases/order/post_order.dart' as _i16;
import '../domain/usecases/order/update_status.dart' as _i20;
import '../presentation/blocs/admin/home/home_admin_bloc.dart' as _i33;
import '../presentation/blocs/admin/konfigurasi/konfigurasi_bloc.dart' as _i34;
import '../presentation/blocs/admin/order/order_bloc.dart' as _i36;
import '../presentation/blocs/admin/voucher/voucher_bloc.dart' as _i43;
import '../presentation/blocs/auth/auth_bloc.dart' as _i22;
import '../presentation/blocs/client/account/account_bloc.dart' as _i21;
import '../presentation/blocs/client/checkout/checkout_bloc.dart' as _i44;
import '../presentation/blocs/client/dashboard/dashboard_client_bloc.dart'
    as _i45;
import '../presentation/blocs/client/order-detail/order_detail_bloc.dart'
    as _i37;
import '../presentation/blocs/client/riwayat-poin/riwayat_poin_bloc.dart'
    as _i41;
import '../presentation/blocs/loading/loading_bloc.dart' as _i10;
import '../presentation/blocs/login/login_bloc.dart' as _i35;
import '../presentation/blocs/menu/menu_bloc.dart' as _i46;
import '../presentation/blocs/register/register_bloc.dart' as _i18;
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
  gh.singleton<_i10.LoadingBloc>(_i10.LoadingBloc());
  gh.lazySingleton<_i11.Login>(() => _i11.Login(get<_i6.AuthRepository>()));
  gh.lazySingleton<_i12.Logout>(() => _i12.Logout(get<_i6.AuthRepository>()));
  gh.lazySingleton<_i13.OrderRemoteDataSource>(
      () => _i13.OrderRemoteDataSourceImpl(get<_i5.ApiClient>()));
  gh.lazySingleton<_i14.OrderRepository>(
      () => _i15.OrderRepositoryImpl(get<_i13.OrderRemoteDataSource>()));
  gh.lazySingleton<_i16.PostOrder>(
      () => _i16.PostOrder(get<_i14.OrderRepository>()));
  gh.lazySingleton<_i17.Register>(
      () => _i17.Register(get<_i6.AuthRepository>()));
  gh.factory<_i18.RegisterBloc>(
      () => _i18.RegisterBloc(get<_i17.Register>(), get<_i10.LoadingBloc>()));
  gh.lazySingleton<_i19.SatuanRemoteDataSource>(
      () => _i19.SatuanRemoteDataSourceImpl(get<_i5.ApiClient>()));
  gh.lazySingleton<_i20.UpdateStatus>(
      () => _i20.UpdateStatus(get<_i14.OrderRepository>()));
  gh.factory<_i21.AccountBloc>(() => _i21.AccountBloc(
      get<_i9.GetDetailUser>(), get<_i12.Logout>(), get<_i10.LoadingBloc>()));
  gh.factory<_i22.AuthBloc>(() => _i22.AuthBloc(get<_i10.LoadingBloc>(),
      get<_i11.Login>(), get<_i8.CheckSession>(), get<_i9.GetDetailUser>()));
  gh.lazySingleton<_i23.CountOrder>(
      () => _i23.CountOrder(get<_i14.OrderRepository>()));
  gh.lazySingleton<_i24.DataMasterRepository>(
      () => _i25.DataMasterRepositoryImpl(get<_i19.SatuanRemoteDataSource>()));
  gh.lazySingleton<_i26.GetAllOrder>(
      () => _i26.GetAllOrder(get<_i14.OrderRepository>()));
  gh.lazySingleton<_i27.GetAllVoucher>(
      () => _i27.GetAllVoucher(get<_i24.DataMasterRepository>()));
  gh.lazySingleton<_i28.GetDetailOrder>(
      () => _i28.GetDetailOrder(get<_i14.OrderRepository>()));
  gh.lazySingleton<_i29.GetKonfigurasi>(
      () => _i29.GetKonfigurasi(get<_i24.DataMasterRepository>()));
  gh.lazySingleton<_i30.GetMenu>(
      () => _i30.GetMenu(get<_i24.DataMasterRepository>()));
  gh.lazySingleton<_i31.GetRiwayatPoin>(
      () => _i31.GetRiwayatPoin(get<_i14.OrderRepository>()));
  gh.lazySingleton<_i32.GetSatuan>(
      () => _i32.GetSatuan(get<_i24.DataMasterRepository>()));
  gh.factory<_i33.HomeAdminBloc>(() => _i33.HomeAdminBloc(
      get<_i12.Logout>(), get<_i10.LoadingBloc>(), get<_i23.CountOrder>()));
  gh.factory<_i34.KonfigurasiBloc>(() =>
      _i34.KonfigurasiBloc(get<_i29.GetKonfigurasi>(), get<_i12.Logout>()));
  gh.factory<_i35.LoginBloc>(() => _i35.LoginBloc(
      get<_i11.Login>(), get<_i10.LoadingBloc>(), get<_i22.AuthBloc>()));
  gh.factory<_i36.OrderBloc>(() => _i36.OrderBloc(
      get<_i26.GetAllOrder>(),
      get<_i28.GetDetailOrder>(),
      get<_i9.GetDetailUser>(),
      get<_i20.UpdateStatus>(),
      get<_i10.LoadingBloc>()));
  gh.factory<_i37.OrderDetailBloc>(() => _i37.OrderDetailBloc(
      get<_i30.GetMenu>(), get<_i20.UpdateStatus>(), get<_i9.GetDetailUser>()));
  gh.lazySingleton<_i38.PostMenu>(
      () => _i38.PostMenu(get<_i24.DataMasterRepository>()));
  gh.lazySingleton<_i39.PostSatuan>(
      () => _i39.PostSatuan(get<_i24.DataMasterRepository>()));
  gh.lazySingleton<_i40.PostVoucher>(
      () => _i40.PostVoucher(get<_i24.DataMasterRepository>()));
  gh.factory<_i41.RiwayatPoinBloc>(() => _i41.RiwayatPoinBloc(
      get<_i31.GetRiwayatPoin>(), get<_i9.GetDetailUser>()));
  gh.factory<_i42.SatuanBloc>(() => _i42.SatuanBloc(
      get<_i39.PostSatuan>(), get<_i10.LoadingBloc>(), get<_i32.GetSatuan>()));
  gh.factory<_i43.VoucherBloc>(() => _i43.VoucherBloc(get<_i10.LoadingBloc>(),
      get<_i40.PostVoucher>(), get<_i27.GetAllVoucher>()));
  gh.factory<_i44.CheckoutBloc>(() => _i44.CheckoutBloc(
      get<_i16.PostOrder>(),
      get<_i10.LoadingBloc>(),
      get<_i27.GetAllVoucher>(),
      get<_i9.GetDetailUser>()));
  gh.factory<_i45.DashboardClientBloc>(
      () => _i45.DashboardClientBloc(get<_i27.GetAllVoucher>()));
  gh.factory<_i46.MenuBloc>(() => _i46.MenuBloc(get<_i10.LoadingBloc>(),
      get<_i32.GetSatuan>(), get<_i38.PostMenu>(), get<_i30.GetMenu>()));
  return get;
}
