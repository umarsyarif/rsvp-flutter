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
import '../domain/usecases/client/get_riwayat_poin.dart' as _i30;
import '../domain/usecases/data-master/get_konfigurasi.dart' as _i28;
import '../domain/usecases/data-master/get_menu.dart' as _i29;
import '../domain/usecases/data-master/get_satuan.dart' as _i31;
import '../domain/usecases/data-master/post_menu.dart' as _i37;
import '../domain/usecases/data-master/post_satuan.dart' as _i38;
import '../domain/usecases/order/get_all_order.dart' as _i26;
import '../domain/usecases/order/get_detail_order.dart' as _i27;
import '../domain/usecases/order/post_order.dart' as _i16;
import '../domain/usecases/order/update_status.dart' as _i20;
import '../presentation/blocs/admin/home/home_admin_bloc.dart' as _i32;
import '../presentation/blocs/admin/konfigurasi/konfigurasi_bloc.dart' as _i33;
import '../presentation/blocs/admin/order/order_bloc.dart' as _i35;
import '../presentation/blocs/auth/auth_bloc.dart' as _i22;
import '../presentation/blocs/client/account/account_bloc.dart' as _i21;
import '../presentation/blocs/client/checkout/checkout_bloc.dart' as _i23;
import '../presentation/blocs/client/order-detail/order_detail_bloc.dart'
    as _i36;
import '../presentation/blocs/client/riwayat-poin/riwayat_poin_bloc.dart'
    as _i39;
import '../presentation/blocs/loading/loading_bloc.dart' as _i10;
import '../presentation/blocs/login/login_bloc.dart' as _i34;
import '../presentation/blocs/menu/menu_bloc.dart' as _i41;
import '../presentation/blocs/register/register_bloc.dart' as _i18;
import '../presentation/blocs/satuan/satuan_bloc.dart'
    as _i40; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i23.CheckoutBloc>(
      () => _i23.CheckoutBloc(get<_i16.PostOrder>(), get<_i10.LoadingBloc>()));
  gh.lazySingleton<_i24.DataMasterRepository>(
      () => _i25.DataMasterRepositoryImpl(get<_i19.SatuanRemoteDataSource>()));
  gh.lazySingleton<_i26.GetAllOrder>(
      () => _i26.GetAllOrder(get<_i14.OrderRepository>()));
  gh.lazySingleton<_i27.GetDetailOrder>(
      () => _i27.GetDetailOrder(get<_i14.OrderRepository>()));
  gh.lazySingleton<_i28.GetKonfigurasi>(
      () => _i28.GetKonfigurasi(get<_i24.DataMasterRepository>()));
  gh.lazySingleton<_i29.GetMenu>(
      () => _i29.GetMenu(get<_i24.DataMasterRepository>()));
  gh.lazySingleton<_i30.GetRiwayatPoin>(
      () => _i30.GetRiwayatPoin(get<_i14.OrderRepository>()));
  gh.lazySingleton<_i31.GetSatuan>(
      () => _i31.GetSatuan(get<_i24.DataMasterRepository>()));
  gh.factory<_i32.HomeAdminBloc>(
      () => _i32.HomeAdminBloc(get<_i12.Logout>(), get<_i10.LoadingBloc>()));
  gh.factory<_i33.KonfigurasiBloc>(
      () => _i33.KonfigurasiBloc(get<_i28.GetKonfigurasi>()));
  gh.factory<_i34.LoginBloc>(() => _i34.LoginBloc(
      get<_i11.Login>(), get<_i10.LoadingBloc>(), get<_i22.AuthBloc>()));
  gh.factory<_i35.OrderBloc>(() => _i35.OrderBloc(
      get<_i26.GetAllOrder>(),
      get<_i27.GetDetailOrder>(),
      get<_i9.GetDetailUser>(),
      get<_i20.UpdateStatus>(),
      get<_i10.LoadingBloc>()));
  gh.factory<_i36.OrderDetailBloc>(() => _i36.OrderDetailBloc(
      get<_i29.GetMenu>(), get<_i20.UpdateStatus>(), get<_i9.GetDetailUser>()));
  gh.lazySingleton<_i37.PostMenu>(
      () => _i37.PostMenu(get<_i24.DataMasterRepository>()));
  gh.lazySingleton<_i38.PostSatuan>(
      () => _i38.PostSatuan(get<_i24.DataMasterRepository>()));
  gh.factory<_i39.RiwayatPoinBloc>(() => _i39.RiwayatPoinBloc(
      get<_i30.GetRiwayatPoin>(), get<_i9.GetDetailUser>()));
  gh.factory<_i40.SatuanBloc>(() => _i40.SatuanBloc(
      get<_i38.PostSatuan>(), get<_i10.LoadingBloc>(), get<_i31.GetSatuan>()));
  gh.factory<_i41.MenuBloc>(() => _i41.MenuBloc(get<_i10.LoadingBloc>(),
      get<_i31.GetSatuan>(), get<_i37.PostMenu>(), get<_i29.GetMenu>()));
  return get;
}
