// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/core/api_client.dart' as _i5;
import '../data/data_sources/auth_local_data_source.dart' as _i3;
import '../data/data_sources/auth_remote_data_source.dart' as _i4;
import '../data/repositories/auth_repository_impl.dart' as _i7;
import '../domain/repositories/auth_repository.dart' as _i6;
import '../domain/usecases/auth/check_session.dart' as _i8;
import '../domain/usecases/auth/get_detail_user.dart' as _i9;
import '../domain/usecases/auth/login.dart' as _i11;
import '../presentation/blocs/auth/auth_bloc.dart' as _i12;
import '../presentation/blocs/loading/loading_bloc.dart' as _i10;
import '../presentation/blocs/login/login_bloc.dart'
    as _i13; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i12.AuthBloc>(() => _i12.AuthBloc(get<_i10.LoadingBloc>(),
      get<_i11.Login>(), get<_i8.CheckSession>(), get<_i9.GetDetailUser>()));
  gh.factory<_i13.LoginBloc>(() => _i13.LoginBloc(
      get<_i11.Login>(), get<_i10.LoadingBloc>(), get<_i12.AuthBloc>()));
  return get;
}
