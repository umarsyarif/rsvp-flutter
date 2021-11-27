// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/core/api_client.dart' as _i5;
import '../data/data_sources/auth_local_data_source.dart' as _i3;
import '../data/data_sources/auth_remote_data_source.dart' as _i4;
import '../data/data_sources/satuan_remote_data_source.dart' as _i15;
import '../data/repositories/auth_repository_impl.dart' as _i7;
import '../data/repositories/data_master_repository_impl.dart' as _i18;
import '../domain/repositories/auth_repository.dart' as _i6;
import '../domain/repositories/data_master_repository.dart' as _i17;
import '../domain/usecases/auth/check_session.dart' as _i8;
import '../domain/usecases/auth/get_detail_user.dart' as _i9;
import '../domain/usecases/auth/login.dart' as _i11;
import '../domain/usecases/auth/logout.dart' as _i12;
import '../domain/usecases/auth/register.dart' as _i13;
import '../domain/usecases/data-master/get_menu.dart' as _i19;
import '../domain/usecases/data-master/get_satuan.dart' as _i20;
import '../domain/usecases/data-master/post_menu.dart' as _i23;
import '../domain/usecases/data-master/post_satuan.dart' as _i24;
import '../presentation/blocs/admin/home/home_admin_bloc.dart' as _i21;
import '../presentation/blocs/auth/auth_bloc.dart' as _i16;
import '../presentation/blocs/loading/loading_bloc.dart' as _i10;
import '../presentation/blocs/login/login_bloc.dart' as _i22;
import '../presentation/blocs/menu/menu_bloc.dart' as _i26;
import '../presentation/blocs/register/register_bloc.dart' as _i14;
import '../presentation/blocs/satuan/satuan_bloc.dart'
    as _i25; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i13.Register>(
      () => _i13.Register(get<_i6.AuthRepository>()));
  gh.factory<_i14.RegisterBloc>(
      () => _i14.RegisterBloc(get<_i13.Register>(), get<_i10.LoadingBloc>()));
  gh.lazySingleton<_i15.SatuanRemoteDataSource>(
      () => _i15.SatuanRemoteDataSourceImpl(get<_i5.ApiClient>()));
  gh.factory<_i16.AuthBloc>(() => _i16.AuthBloc(get<_i10.LoadingBloc>(),
      get<_i11.Login>(), get<_i8.CheckSession>(), get<_i9.GetDetailUser>()));
  gh.lazySingleton<_i17.DataMasterRepository>(
      () => _i18.DataMasterRepositoryImpl(get<_i15.SatuanRemoteDataSource>()));
  gh.lazySingleton<_i19.GetMenu>(
      () => _i19.GetMenu(get<_i17.DataMasterRepository>()));
  gh.lazySingleton<_i20.GetSatuan>(
      () => _i20.GetSatuan(get<_i17.DataMasterRepository>()));
  gh.factory<_i21.HomeAdminBloc>(
      () => _i21.HomeAdminBloc(get<_i12.Logout>(), get<_i10.LoadingBloc>()));
  gh.factory<_i22.LoginBloc>(() => _i22.LoginBloc(
      get<_i11.Login>(), get<_i10.LoadingBloc>(), get<_i16.AuthBloc>()));
  gh.lazySingleton<_i23.PostMenu>(
      () => _i23.PostMenu(get<_i17.DataMasterRepository>()));
  gh.lazySingleton<_i24.PostSatuan>(
      () => _i24.PostSatuan(get<_i17.DataMasterRepository>()));
  gh.factory<_i25.SatuanBloc>(() => _i25.SatuanBloc(
      get<_i24.PostSatuan>(), get<_i10.LoadingBloc>(), get<_i20.GetSatuan>()));
  gh.factory<_i26.MenuBloc>(() => _i26.MenuBloc(get<_i10.LoadingBloc>(),
      get<_i20.GetSatuan>(), get<_i23.PostMenu>(), get<_i19.GetMenu>()));
  return get;
}
